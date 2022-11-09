//
//  CurrencyFromCell.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import UIKit

final class CurrencyToCell: UITableViewCell {
    
    //MARK: Properties
    static let identifier = "CurrencySelectionCell"
    
    private let indentForLayout: CGFloat = 10
    
    private let distanceBetween: CGFloat = 5
    
    private let containerStackView = UIStackView()
        .myStyleStack(
            spacing: 1,
            alignment: .fill,
            axis: .vertical,
            distribution: .equalCentering,
            userInteraction: false)
    
    private let ratesStackView = UIStackView()
        .myStyleStack(
            spacing: 10,
            alignment: .fill,
            axis: .horizontal,
            distribution: .equalCentering,
            userInteraction: false)
    
    private let countryFlagImage = UIImageView()
        .setMyStyle()
        .setShadow(color: Colors.shadow)
    
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
    
    private let ratesLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: Fonts.rates)
    
    private let imageForRates = UIImageView()
        .setMyStyle()
        .setImage(image: Images.up)
    
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
        selectedBackgroundView?.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
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
        ratesStackView.addArrangedSubview(ratesLabel)
        ratesStackView.addArrangedSubview(imageForRates)
        contentView.addSubview(ratesStackView)
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
        
        NSLayoutConstraint.activate([
            imageForRates.widthAnchor.constraint(equalToConstant: 12),
            imageForRates.heightAnchor.constraint(equalToConstant: 12),
        ])
        
        NSLayoutConstraint.activate([
            ratesStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60),
            ratesStackView.centerYAnchor.constraint(equalTo: countryFlagImage.centerYAnchor)
        ])
    }
    
    private func setButtonTransform(button: UIButton) {
        let scaleX = 0.97
        let scaleY = 0.97
        button.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
    }
    
    private func setColorRates(d: Double) {
        
        if d > 0 {
            self.ratesLabel.text = "+\(String(format: "%.3f", d))"
            self.ratesLabel.textColor = .green
            self.imageForRates.image = Images.up
        } else {
            self.ratesLabel.text = String(format: "%.3f", d)
            self.ratesLabel.textColor = .red
            self.imageForRates.image = Images.down
        }
    }
}

//MARK: Extension
extension CurrencyToCell: ConfigurableView {
    
    typealias Model = ModelCurrencyToCell
    
    func configure(with model: Model) {
        self.charCodeLabel.text = model.chareCode
        self.countryFlagImage.image = model.countryFlag
        self.nameCurrencyLabel.text = model.nameCurrency
        self.imageForRates.image = model.arrowUp
        self.nameCurrencyLabel.removeExtraText()
        self.isSelected = model.isSelected
        setColorRates(d: model.rates)
    }
}
