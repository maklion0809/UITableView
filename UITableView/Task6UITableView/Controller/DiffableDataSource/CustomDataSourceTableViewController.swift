//
//  CustomDataSourceTableViewController.swift
//  Task6UITableView
//
//  Created by Tymofii (Work) on 05.10.2021.
//

import UIKit

final class CustomDataSourceTableViewController: UIViewController {
    
    // MARK: - UI element
    
    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private lazy var refreshControl = UIRefreshControl(frame: .zero, primaryAction: UIAction(handler: refreshHandler))
    
    // MARK: - Data source
    
    private lazy var dataSource = DiffableDataSource(tableView: tableView) { tableView, indexPath, city in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as? CustomTableViewCell else { return CustomTableViewCell ()}
        
        let city = self.cityViewModel.getObject(for: indexPath)
        cell.setup(city: city, isExpanded: self.cityViewModel.isShowedExpendObject(at: indexPath.section, item: city))
        cell.expandCallBack = { [weak self] in
            guard let self = self else { return }
            if self.cityViewModel.isShowedExpendObject(at: indexPath.section, item: city) {
                self.cityViewModel.removeExpendedObject(at: indexPath.section, item: city)
            } else {
                self.cityViewModel.loadDataExpendedObject(at: indexPath.section, item: city)
            }
            self.applySnapshot()
        }
        
        return cell
    }

    // MARK: - Variable
    
    private var cityViewModel = CityViewModel()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupConstraint()
        setupTableView()
        loadCities()
    }
    
    // MARK: - Setting up the subview
    
    private func setupSubview() {
        view.addSubview(tableView)
    }
    
    // MARK: - Setting up the constraint
    
    private func setupConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Setting up the tableView
    
    private func setupTableView() {
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.register(CustomHeader.self,
                           forHeaderFooterViewReuseIdentifier: CustomHeader.identifier)
        tableView.refreshControl = refreshControl
        tableView.delegate = self
        dataSource.defaultRowAnimation = .fade
        tableView.dataSource = dataSource
    }
    
    // MARK: - Loading data
    
    private func loadCities() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.cityViewModel.loadData()
            self.applySnapshot()
        }
    }
    
    // MARK: - Apply snapshot
    
    private func applySnapshot() {
        let snapshot = cityViewModel.createSnaphot()
        dataSource.apply(snapshot)
    }
    
    // MARK: - Refresh handler
    
    private func refreshHandler(_ action: UIAction) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.cityViewModel.loadData(at: Section<City>(name: "Some city", objects: [City(name: "Some city", image: "cityOne", description: "Some description")], expendedObject: Set<City>()))
            self.applySnapshot()
            self.refreshControl.endRefreshing()
        }
    }
}

// MARK: - CustomDataSourceTableViewController

extension CustomDataSourceTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeader.identifier) as? CustomHeader else { return CustomHeader() }
        viewHeader.setup(cityViewModel.getSectionName(at: section))
        viewHeader.addCallBack = { [weak self] in
            guard let self = self else { return }
            self.cityViewModel.loadDataItemInSection(at: section, item: City(name: "some city", image: "cityOne", description: "Some description"))
            self.applySnapshot()
        }
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cityViewModel.removeItemInSection(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
