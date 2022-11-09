//
//  CurrencyFromCell.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import UIKit

final class CurrencyFromCell: UITableViewCell {
    
    //MARK: Properties
    static let identifier = "CurrencySelectionCell"
    
    private let indentForLayout: CGFloat = 15
    
    private let countryFlagImage = UIImageView()
        .setMyStyle()
        .setShadow(color: Colors.shadow)
    
    private let containerStackView = UIStackView()
        .myStyleStack(
            spacing: 3,
            alignment: .fill,
            axis: .vertical,
            distribution: .equalCentering,
            userInteraction: false)
    
    private let nameCurrencyLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: Fonts.subTitle)
        .setTextColor(color: Colors.mainTextColor)
    
    private let charCodeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: Fonts.charCode)
    
    override var isSelected: Bool {
        didSet {
            switch isSelected {
            case true:
                self.accessoryType = .checkmark
            case false:
                self.accessoryType = .none
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isSelected = false
    }
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAddSubViews()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    //MARK: Hierarhy view
    private func setupAddSubViews() {
        contentView.addSubview(countryFlagImage)
        containerStackView.addArrangedSubview(charCodeLabel)
        containerStackView.addArrangedSubview(nameCurrencyLabel)
        contentView.addSubview(containerStackView)
    }
    
    //MARK: Constraint
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            countryFlagImage.widthAnchor.constraint(equalToConstant: 50),
            countryFlagImage.heightAnchor.constraint(equalToConstant: 50),
            countryFlagImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countryFlagImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: indentForLayout)
        ])
        
        NSLayoutConstraint.activate([
            containerStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            containerStackView.leadingAnchor.constraint(equalTo: countryFlagImage.trailingAnchor, constant: indentForLayout),
            containerStackView.centerYAnchor.constraint(equalTo: countryFlagImage.centerYAnchor)
        ])
    }
}

//MARK: Extension
extension CurrencyFromCell: ConfigurableView {
    
    typealias Model = ModelCurrencyFromCell
    
    func configure(with model: Model) {
        self.charCodeLabel.text = model.chareCode
        self.countryFlagImage.image = model.countryFlag
        self.nameCurrencyLabel.text = model.nameCurrency
        self.nameCurrencyLabel.removeExtraText()
        self.isSelected = model.isSelected
    }
}
