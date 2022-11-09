//
//  CurrencyToDataSource.swift
//  Currency Converter
//
//  Created by APPLE on 31.10.2022.
//

import UIKit

protocol CurrencyToDataSourceOutput: AnyObject {
    func costDifferense(from: Valute, to: Valute) -> Double
    
    func removeFromFavorites(index: Int)
    
    func addInFavorite(index: Int)
}

final class CurrencyToDataSource: NSObject {
    
    private let model: [Valute]
    
    weak var output: CurrencyToDataSourceOutput?
    
    private var models: [ModelCurrencyToCell] {
        map(model: model)
    }
    
    private var currentCurrency: Valute
    
    init(model: ModelToCurrency) {
        self.model = model.currencyTo
        self.currentCurrency = model.currentСurrency
    }
    
    private func map(model: [Valute]) -> [ModelCurrencyToCell] {
        model.map { currency in
            ModelCurrencyToCell(
                countryFlag: UIImage(named: currency.charCode),
                chareCode: currency.charCode,
                nameCurrency: currency.name,
                rates: output?.costDifferense(from: currentCurrency, to: currency) ?? 0,
                isSelected: currency.isSelected)
        }
    }
}
//MARK: Extension
extension CurrencyToDataSource : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyToCell.identifier, for: indexPath) as? CurrencyToCell else {return UITableViewCell()}
        
        if indexPath.row < models.count {
            cell.configure(with: models[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) as? CurrencyToCell else {return}
        
        switch cell.accessoryType {
            
        case .checkmark:
            output?.removeFromFavorites(index: indexPath.row)
            cell.accessoryType = .none
            
        case .none:
            output?.addInFavorite(index: indexPath.row)
            cell.accessoryType = .checkmark
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
