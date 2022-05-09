//
//  CustomHeader.swift
//  Task6UITableView
//
//  Created by Tymofii (Work) on 04.10.2021.
//

import UIKit

final class CustomHeader: UITableViewHeaderFooterView {
    
    // MARK: - Configuration
    
    private enum Configuration {
        static let itemSpacing: CGFloat = 10
        static let fontSize: CGFloat = 16
    }
    
    // MARK: - static variable
    
    static let identifier = "sectionHeader"

    // MARK: - UI element
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: Configuration.fontSize)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor.black
        return button
    }()
    
    // MARK: - callBack
    
    var addCallBack: (() -> Void)?
    
    // MARK: - initialization
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSubview()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setting up the subview
    
    private func setupSubview() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addItemInSection), for: .touchUpInside)
    }
    
    // MARK: - Setting up the constraint
    
    private func setupConstraint() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([            
            addButton.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            addButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Configuration.itemSpacing),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Configuration.itemSpacing)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: Configuration.itemSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Configuration.itemSpacing),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Configuration.itemSpacing)
        ])
    }
    
    // MARK: - Setting up the custom hearder
    
    func setup(_ title: String) {
        titleLabel.text = title
    }
    
    // MARK: - UIAction
    
    @objc private func addItemInSection() {
        addCallBack?()
    }
}
