//
//  ConverterView.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import UIKit

import UIKit

final class ConverterView: UIView {
    
    //MARK: Properties
    private var onAdd: (()->())?
    
    private var onAction: (()->())?
    
    private let indentForLayout: CGFloat = 10
    
    private let indent: CGFloat = 20
    
    private let indetnBottom: CGFloat = 15
    
    private let distanceBetween: CGFloat = 5
    
    private let indentBottomTextField: CGFloat = 5
    
    public var tableView = UITableView(frame: .zero)
    
    private let containerView = UIView()
        .setStyle()
        .setRoundCorners(radius: AppDesign.mainContainer)
        .setShadows(
            color: Colors.shadow,
            width: 0.1,
            height: 1,
            radius: 2,
            opacity: 4)
    
    private lazy var addValuteButton = CurrencyButton()
        .setMyStyle(cornerRadius: AppDesign.cornerRadiusAddValute)
        .setShadow()
        .setTarget(method: #selector(addButtonAction),
                   target: self,
                   event: .touchUpInside)
    
    private let dateLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: Fonts.date)
        .setTextColor(color: Colors.textColor)
    
    private let subTitleLabel = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: Fonts.subTitle)
        .setTextColor(color: Colors.mainTextColor)
    
    private let charCodeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        .setMyStyle(
            numberOfLines: 0,
            textAlignment: .center,
            font: Fonts.charCode)
    
    private let updateTime = UILabel()
        .setMyStyle(
            numberOfLines: 1,
            textAlignment: .left,
            font: Fonts.date)
        .setTextColor(color: Colors.textColor)
    
    private lazy var dateImageView = UIImageView()
        .setMyStyle()
        .setImage(image: Images.calendar)
        .setTintColor(color: Colors.textColor)
    
    private lazy var updateTimeImageView = UIImageView()
        .setMyStyle()
        .setImage(image: Images.update)
        .setTintColor(color: Colors.textColor)
    
    public lazy var mainTextField = UITextField()
        .setMyStyle(
            textAligment: .center,
            font: Fonts.converter)
        .setLeftViewMode(
            viewMode: .always,
            view: charCodeLabel)
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.identifire)
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = Colors.mainBackground
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.mainBackground
        setupTableView()
        setViewHierarhy()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View hierarhy
    private func setViewHierarhy() {
        
        self.addSubview(containerView)
        containerView.addSubview(mainTextField)
        containerView.addSubview(updateTimeImageView)
        containerView.addSubview(updateTime)
        containerView.addSubview(addValuteButton)
        containerView.addSubview(subTitleLabel)
        containerView.addSubview(dateImageView)
        containerView.addSubview(dateLabel)
        self.addSubview(tableView)
    }
    
    //MARK: Constraint
    private func setConstraint() {
        
        NSLayoutConstraint.activate([
            addValuteButton.widthAnchor.constraint(equalToConstant: 60),
            addValuteButton.heightAnchor.constraint(equalToConstant: 60),
            addValuteButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: indent),
            addValuteButton.topAnchor.constraint(equalTo: updateTimeImageView.bottomAnchor, constant: indetnBottom)
        ])
        
        NSLayoutConstraint.activate([
            updateTimeImageView.widthAnchor.constraint(equalToConstant: 20),
            updateTimeImageView.heightAnchor.constraint(equalToConstant: 20),
            updateTimeImageView.centerYAnchor.constraint(equalTo: dateImageView.centerYAnchor),
            updateTimeImageView.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: indentForLayout)
        ])
        
        NSLayoutConstraint.activate([
            updateTime.leadingAnchor.constraint(equalTo: updateTimeImageView.trailingAnchor, constant: distanceBetween),
            updateTime.centerYAnchor.constraint(equalTo: updateTimeImageView.centerYAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: addValuteButton.bottomAnchor, constant: indetnBottom)
        ])
        
        NSLayoutConstraint.activate([
            dateImageView.widthAnchor.constraint(equalToConstant: 20),
            dateImageView.heightAnchor.constraint(equalToConstant: 20),
            dateImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: indent),
            dateImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: dateImageView.trailingAnchor, constant: distanceBetween),
            dateLabel.centerYAnchor.constraint(equalTo: dateImageView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainTextField.bottomAnchor.constraint(equalTo: addValuteButton.centerYAnchor, constant: indentBottomTextField),
            mainTextField.heightAnchor.constraint(equalToConstant: 40),
            mainTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -indent),
            mainTextField.leadingAnchor.constraint(equalTo: addValuteButton.trailingAnchor, constant: indentForLayout)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            subTitleLabel.topAnchor.constraint(equalTo: mainTextField.bottomAnchor),
            subTitleLabel.leadingAnchor.constraint(equalTo: mainTextField.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc func addButtonAction(sender: UIButton) {
        onAdd?()
    }
}

//MARK: Extension
extension ConverterView: ConfigurableView {
    
    typealias Model = ConverterValuteView
    
    func configure(with model: Model) {
        self.addValuteButton.configure(with: ModelButton(
            image: UIImage(named: model.charCode)))
        self.onAdd = model.onAdd
        self.charCodeLabel.text = model.charCode
        self.subTitleLabel.text = model.headerRUB
        self.subTitleLabel.removeExtraText()
        self.dateLabel.text = model.date
        self.updateTime.text = model.timeUpdate
    }
}
