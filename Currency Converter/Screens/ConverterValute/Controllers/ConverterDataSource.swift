//
//  ConverterDataSource.swift
//  Currency Converter
//
//  Created by APPLE on 28.10.2022.
//

import UIKit

final class ConverterDataSource: NSObject {
    
    private let converterServices = RatesAPI()
    
    weak var output: ConverterDataSourceDelegate?
    
    private let flagiArray = ["USD", "EUR", "GBP", "CNY", "CHF", "AUD", "CAD"]
    
    public var currencyFrom: [Valute] = []
      
    public var currencyTo: [Valute] = []
    
    public var favoriteArray: [Valute] = [] {
        didSet {
            models = map(currencys: favoriteArray)
        }
    }
   
    private var models: [ConverterValuteCell] = []
   
    public var currentDate: DateModel?
    
    public var currentСurrency: Valute? {
        didSet {
            output?.updateView(
            currentCurrency: currentСurrency,
            date: currentDate)
            models = map(currencys: favoriteArray)
        }
    }

    public let baseCurrensyTo = "USD"
    
    public let baseСurrencyFrom = Valute(
        previous: 1,
        numCode: "1",
        charCode: "RUB",
        nominal: 1,
        name: "Российский рубль",
        id: "R01077",
        value: 1,
        isSelected: true)
    
    override init() {
        super.init()
        start()
    }
    
    private func start() {
        converterServices.getRates {[weak self] currency, date   in
            guard let self = self else {return}
            
            self.flagiArray.forEach { valute in
                guard let valute = currency[valute] else {return}
                self.currencyFrom.append(valute)
            }
            DispatchQueue.main.async {
                self.currentDate = date
                self.currencyTo = self.currencyFrom
                
                self.currencyFrom.insert(self.baseСurrencyFrom, at: 0)
                self.setupStartScreenTo()
                self.setupStartScreenFrom()
                self.currentСurrency = self.baseСurrencyFrom
            }
        }
    }
    
    private func map(currencys: [Valute]) -> [ConverterValuteCell] {
        currencys.map { currency in
          return  ConverterValuteCell(
                onAction: { [weak self] in
                    self?.output?.addToValute()
                },
                nameValute: currency.name,
                imageValute: UIImage(named: currency.charCode),
                charCode: currency.charCode,
                value: String(currency.value),
                rate: output?.currencyRatioCalculation(
                    to: currency,
                    baseFrom: baseСurrencyFrom) ?? "",
                currentValuteCharCode: output?.setCharCode() ?? "")
        }
    }

    private func setupStartScreenTo() {
        guard let indexRUB = (currencyFrom.firstIndex{$0.charCode == baseСurrencyFrom.charCode}) else { return }
        currencyFrom[indexRUB].isSelected = true
    }
    
    private func setupStartScreenFrom() {
        guard let indexUSD = (currencyTo.firstIndex{$0.charCode == baseCurrensyTo}) else { return }
        currencyTo[indexUSD].isSelected = true
        favoriteArray.append(currencyTo[indexUSD])
    }
}
extension ConverterDataSource: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.identifire, for: indexPath) as? CurrencyCell else {return UITableViewCell()}
        
        if indexPath.row < models.count {
            cell.configure(with: models[indexPath.row])
            
            cell.valuteTextField.text = output?.calculateExchangeRate(to: favoriteArray[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            output?.deleteCurrencyInFavorite(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
