//
//  СonverterViewController.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import UIKit

final class ConverterViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    fileprivate var converterView: ConverterView {
        guard let view = self.view as? ConverterView else {return ConverterView()}
        return view
    }
        
    private let header = "Сonvert"
    
    private lazy var viewKeyboard = ViewKeyBoard(target: converterView.mainTextField)

    private var dataSource: ConverterDataSource

    private lazy var addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonAction))
    
    init() {
        dataSource = ConverterDataSource()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LifeCycle
    override func loadView() {
        super.loadView()
        self.view = ConverterView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupKeyBoard()
        dataSource.output = self
        converterView.mainTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        converterView.mainTextField.becomeFirstResponder()
    }
    
    private func setupNavigationBar() {
        self.title = header
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = Colors.mainBackground
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        self.navigationItem.setRightBarButtonItems([addButton], animated: true)
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    private func setupKeyBoard() {
        viewKeyboard.frame = CGRect(x: 0, y: 0, width: self.converterView.frame.width, height: converterView.frame.height * 0.3)
        viewKeyboard.configure(with: ViewKeyBoard.Model())
        converterView.mainTextField.inputView = viewKeyboard
    }
    
    private func setupTableView() {
        converterView.tableView.delegate = dataSource
        converterView.tableView.dataSource = dataSource
    }
    
    @objc func keyBoardShow(notification: Notification) {
        let height = viewKeyboard.frame.height

        converterView.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
    }

    @objc func addButtonAction() {
        guard let currentСurrency = dataSource.currentСurrency else { return }

        let currencySelection = CurrencyToController(model: ModelToCurrency(
            currencyTo: dataSource.currencyTo,
            currentСurrency: currentСurrency))
        
        navigationController?.pushViewController(currencySelection, animated: true)
        currencySelection.delegate = self
        converterView.tableView.isEditing = false
    }
    
    private func convertTextInNumerals(text: String?) -> Double {
        if let textWithoutSpaces = text?.replacingOccurrences(of: " ", with: "") {
            guard  let number = Formatter.formatterFrom.number(from: textWithoutSpaces) as? Double else { return 0 }
            return number
        }
        return 0
    }
    
    private func unitOfCurrency(model: Valute) -> String {
        let oneUnit = model.value / Double(model.nominal)
      
        return NumberFormatter.formatToCurrency(maximumFractionDigits: 2).string(from: oneUnit as NSNumber) ?? ""
    }
    
    private func replaceFromCurrency() {
        let currencySelection = CurrencyFromController(model: ModelFromCurrency(currencyFrom: dataSource.currencyFrom))
        navigationController?.pushViewController(currencySelection, animated: true)
        currencySelection.delegate = self
    }

    private func textFieldDidChange() {
        converterView.tableView.reloadData()
    }

    private func updateIsSelected(index: Int) {
        dataSource.currencyTo[index].isSelected = (dataSource.currencyTo[index].isSelected == false) ? true : false
    }
    
    private func replaceCurrencyTo(currency: Valute, isCurrency: Bool) {
        guard var currentСurrency = dataSource.currentСurrency else {return}

        guard let index = (dataSource.currencyTo.firstIndex{$0.name == currency.name}) else { return }

        if isCurrency {
          currentСurrency.isSelected = true
        } else {
            currentСurrency.isSelected = false
        }
        dataSource.currencyTo[index] = currentСurrency
    }

    private func replaсeFavoriteArray(currency: Valute) -> Bool {
        guard let currentСurrency = dataSource.currentСurrency else {return false}
        
        guard let index = (dataSource.favoriteArray.firstIndex{$0.name == currency.name}) else {return false}
        
        dataSource.favoriteArray[index] = currentСurrency
        converterView.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .left)
        return true
    }
    
    //MARK: Delegate method TextField
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text? = convertTextInNumerals(text: textField.text).formatterFrom
        textFieldDidChange()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text? = convertTextInNumerals(text: textField.text).formatterFrom
        textFieldDidChange()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let decimalSeparator = Locale.current.decimalSeparator else { return false }
        
        if string == decimalSeparator {

            if textField.text?.contains(decimalSeparator) == true {
                return false
            }
            textField.insertText(decimalSeparator)
            return false
        }
        return true
    }
}

//MARK: Extension Delegate
extension ConverterViewController: CurrencyDelegate {
    
    func removeFromFavorites(index: Int) {
        let currency = dataSource.currencyTo[index]
        guard let currencyIndex = (dataSource.favoriteArray.firstIndex{$0.id == currency.id}) else {return}
        dataSource.favoriteArray.remove(at: currencyIndex)
        updateIsSelected(index: index)
    }
    
    func addInFavorite(index: Int) {
        let currency = dataSource.currencyTo[index]
        
        if !dataSource.favoriteArray.contains(where: {$0.id == currency.id}) {
            dataSource.favoriteArray.append(currency)
        }
        updateIsSelected(index: index)
        converterView.tableView.reloadData()
    }
    
    func updateCurrencyFrom(value: [Valute]) {
        dataSource.currencyFrom = value
    }
    
    func addCurrencyFrom(value: Valute) {
        let isCurrency = replaсeFavoriteArray(currency: value)
        replaceCurrencyTo(currency: value, isCurrency: isCurrency)
        dataSource.currentСurrency = value
    }
}

extension ConverterViewController: ConverterDataSourceDelegate {
    
    func updateView(currentCurrency: Valute?, date: DateModel?) {
        guard let currentCurrency = currentCurrency else { return }
        self.converterView.configure(with: ConverterView.Model(
            onAdd:{[weak self] in
                self?.replaceFromCurrency()
            },
            date: DateFormatter.getWeekDay(date: date?.date, type: .weekDay),
            timeUpdate: DateFormatter.getWeekDay(date: date?.date, type: .timeUpdate) ,
            headerRUB: currentCurrency.name,
            charCode: currentCurrency.charCode))
            converterView.tableView.reloadData()
    }

    func setCharCode() -> String {
        guard let currentСurrency = dataSource.currentСurrency else { return ""}
        return currentСurrency.charCode
    }
    
    func currencyRatioCalculation( to: Valute, baseFrom: Valute) -> String {
        guard let currentСurrency = dataSource.currentСurrency else { return ""}
        
        if currentСurrency.charCode == baseFrom.charCode {
            return unitOfCurrency(model: to)
        }

        let currentUnitOfCurrency = currentСurrency.value / Double(currentСurrency.nominal)
        let unitOfCurrency = to.value / Double(to.nominal)
        let rezult = unitOfCurrency / currentUnitOfCurrency
        return NumberFormatter.formatToCurrency(maximumFractionDigits: 2).string(from: rezult as NSNumber) ?? ""
    }
    
    func addToValute() {
        addButtonAction()
    }
    
    func deleteCurrencyInFavorite(index: Int) {
        let charCode = dataSource.favoriteArray[index].charCode
        
        guard let indexСurrency = (dataSource.currencyTo.firstIndex{$0.charCode == charCode}) else { return }
        
        dataSource.favoriteArray.remove(at: index)
        updateIsSelected(index: indexСurrency)
    }

    func calculateExchangeRate( to: Valute) -> String {
        guard let currentСurrency = dataSource.currentСurrency else { return ""}
        let from = currentСurrency
        let sum: Double = convertTextInNumerals(text: converterView.mainTextField.text)
        
        let unitValueFrom = from.value / Double(from.nominal)
        let unitValueTo = to.value / Double(to.nominal)
               
        let rezult = (sum * unitValueFrom) / unitValueTo
        
        switch rezult {
        case _ where rezult < 1:
            return NumberFormatter.formatToCurrency(maximumFractionDigits: 6).string(from: rezult as NSNumber) ?? ""
            
        case _ where rezult > 1:
            return NumberFormatter.formatToCurrency(maximumFractionDigits: 2).string(from: rezult as NSNumber) ?? ""
        default:
            return ""
        }
    }
}
