//
//  CustomTableViewCell.swift
//  Task6UITableView
//
//  Created by Tymofii (Work) on 04.10.2021.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {

    // MARK: - Configuration
    
    private enum Configuration {
        static let itemSpacing: CGFloat = 10
        static let imageSize = CGSize(width: 50, height: 50)
        static let imageRadius: CGFloat = 10
        static let numberOfLines = 10
        static let fontSize: CGFloat = 16
    }
    
    // MARK: - Static variable

    static let identifier = "CityCell"
    
    // MARK: - UI element
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = Configuration.imageRadius
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: Configuration.fontSize)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: Configuration.fontSize)
        label.textAlignment = .left
        label.numberOfLines = Configuration.numberOfLines
        return label
    }()
    
    private lazy var expandButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.down.circle"), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    private lazy var cityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Configuration.itemSpacing
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Configuration.itemSpacing
        return stackView
    }()
    
    // MARK: - callBack
    
    var expandCallBack: (() -> Void)?
    
    // MARK: - initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setting up the subview
    
    private func setupSubview() {
        
        cityStackView.addArrangedSubview(image)
        cityStackView.addArrangedSubview(titleLabel)
        cityStackView.addArrangedSubview(expandButton)
        expandButton.addTarget(self, action: #selector(expandButtonTouched), for: .touchUpInside)
        
        mainStackView.addArrangedSubview(cityStackView)
        mainStackView.addArrangedSubview(descriptionLabel)
        contentView.addSubview(mainStackView)
    }
    
    // MARK: - Setting up the constraint
    
    private func setupConstraint() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Configuration.itemSpacing),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Configuration.itemSpacing),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Configuration.itemSpacing),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Configuration.itemSpacing)
        ])
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: Configuration.imageSize.height),
            image.widthAnchor.constraint(equalToConstant: Configuration.imageSize.width),
        ])
    }
    
    // MARK: - Setting up the custom tableViewCell

    func setup(city: City, isExpanded: Bool = false) {
        titleLabel.text = city.name
        image.image = UIImage(named: city.image)
        descriptionLabel.text = city.description
        descriptionLabel.isHidden = !isExpanded
    }
    
    // MARK: - UIAction
    
    @objc private func expandButtonTouched() {
        expandCallBack?()
    }
}
