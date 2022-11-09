//
//  CurrencyFromDataSource.swift
//  Currency Converter
//
//  Created by APPLE on 31.10.2022.
//

import UIKit

protocol CurrencyFromDataSourceOutput: AnyObject {
    func addCurrencyFrom(currency: Valute)
}

final class CurrencyFromDataSource: NSObject {
    
    public var model: [Valute]
    
    public var output: CurrencyFromDataSourceOutput?
    
    private var models: [ModelCurrencyFromCell] {
        map(model: model)
    }
    
    private var lastSelectedIndexPath: IndexPath = [0, 0]
    
    init(model: [Valute]) {
        self.model = model
    }
    
    private func map(model: [Valute]) -> [ModelCurrencyFromCell] {
        model.map { currency in
            ModelCurrencyFromCell(
                countryFlag: UIImage(named: currency.charCode),
                chareCode: currency.charCode,
                nameCurrency: currency.name,
                isSelected: currency.isSelected)
        }
    }
}
//MARK: Extension
extension CurrencyFromDataSource: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyFromCell.identifier, for: indexPath) as? CurrencyFromCell else {return UITableViewCell()}
        
        if indexPath.row < models.count {            
            if self.model[indexPath.row].isSelected {
                lastSelectedIndexPath = indexPath
            }
            cell.configure(with: models[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        guard let cell = tableView.cellForRow(at: indexPath) as? CurrencyFromCell else { return }
        
        let currencyIsSelected = model[indexPath.row].isSelected
        
        guard currencyIsSelected == false else { return }
        
        model[indexPath.row].isSelected = true
        
        cell.accessoryType = .checkmark
        
        guard let cellSelected = tableView.cellForRow(at: lastSelectedIndexPath) as? CurrencyFromCell else { return }
        
        cellSelected.accessoryType = .none
        
        model[lastSelectedIndexPath.row].isSelected = false
        
        lastSelectedIndexPath = indexPath
      
        output?.addCurrencyFrom(currency: model[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
