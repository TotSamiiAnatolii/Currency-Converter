//
//  CurrencyCell.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import UIKit

final class CurrencyCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifire = "CurrencyCell"
    
    private var onAction: (()->())?
    
    private let indent: CGFloat = 30
    
    private let indentForLayout: CGFloat = 10
    
    private let distanceBetween: CGFloat = 2
    
    private let indentBottomTextField: CGFloat = 5
    
    private let nameValuteLabel = UILabel()
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
            textAlignment: .center,
            font: Fonts.rates)
        .setTextColor(color: Colors.mainTextColor)
    
    public lazy var valuteTextField = UITextField()
        .setMyStyle(
            textAligment: .center,
            font: Fonts.converter)
        .setLeftViewMode(
            viewMode: .always,
            view: charCodeLabel)
    
    private lazy var addValuteButton = CurrencyButton()
        .setMyStyle(cornerRadius: AppDesign.cornerRadiusAddValute)
        .setShadow()
        .setTarget(method: #selector(addButtonAction),
                   target: self,
                   event: .touchUpInside)
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Colors.mainBackground
        setupAddSubViews()
        setupConstraints()
        valuteTextField.delegate = self
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View hierarhies
    private func setupAddSubViews() {
        contentView.addSubview(addValuteButton)
        contentView.addSubview(nameValuteLabel)
        contentView.addSubview(valuteTextField)
        contentView.addSubview(ratesLabel)
    }
    
    //MARK: Constraints
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            addValuteButton.widthAnchor.constraint(equalToConstant: 60),
            addValuteButton.heightAnchor.constraint(equalToConstant: 60),
            addValuteButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: indent),
            addValuteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            valuteTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -indent),
            valuteTextField.heightAnchor.constraint(equalToConstant: 40),
            valuteTextField.leadingAnchor.constraint(equalTo: addValuteButton.trailingAnchor, constant: indentForLayout),
            valuteTextField.bottomAnchor.constraint(equalTo: addValuteButton.centerYAnchor, constant: indentBottomTextField)
        ])
        
        NSLayoutConstraint.activate([
            nameValuteLabel.topAnchor.constraint(equalTo: valuteTextField.bottomAnchor),
            nameValuteLabel.leadingAnchor.constraint(equalTo: valuteTextField.leadingAnchor), 
        ])
        
        NSLayoutConstraint.activate([
            ratesLabel.topAnchor.constraint(equalTo: valuteTextField.bottomAnchor),
            ratesLabel.trailingAnchor.constraint(equalTo: valuteTextField.trailingAnchor, constant: -distanceBetween)
        ])
    }

    @objc func addButtonAction(sender: UIButton) {
        onAction?()
    }
}

//MARK: Extension configurable view
extension CurrencyCell: ConfigurableView {
    
    typealias Model = ConverterValuteCell
    
    func configure(with model: Model) {
        self.onAction = model.onAction
        self.nameValuteLabel.text = model.nameValute
        self.addValuteButton.configure(with: ModelButton(image: model.imageValute!))
        self.valuteTextField.text = String(model.value)
        self.charCodeLabel.text = model.charCode
        self.nameValuteLabel.removeExtraText()
        self.ratesLabel.text = "1 \(model.charCode) = \(model.rate) \(model.currentValuteCharCode)"
    }
}

//MARK: Extension text UITextFieldDelegate
extension CurrencyCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        valuteTextField.resignFirstResponder()
    }
}

