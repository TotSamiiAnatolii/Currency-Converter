//
//  CurrencyToController.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import UIKit

class CurrencyToController: UIViewController {
    
    //MARK: Properties
    fileprivate var viewCurrency: CurrencyToView {
        guard let view = self.view as? CurrencyToView else {return CurrencyToView()}
        return view
    }
    
    private let header = "Add currency to"
    
    public var delegate: CurrencyDelegate?
    
    private let dataSource: CurrencyToDataSource
    
    init(model: ModelToCurrency) {
        self.dataSource = CurrencyToDataSource(model: model)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    override func loadView() {
        super.loadView()
        self.view = CurrencyToView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        dataSource.output = self
        viewCurrency.tableView.delegate = dataSource
        viewCurrency.tableView.dataSource = dataSource
    }
    
    //MARK: Setup navigationBar
    private func setupNavigationBar() {
        self.title = header
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func unitOfCurrency(model: Valute) -> Double {
        
        return model.value / Double(model.nominal)
    }
}
extension CurrencyToController: CurrencyToDataSourceOutput {
    func removeFromFavorites(index: Int) {
        delegate?.removeFromFavorites(index: index)
    }
    
    func addInFavorite(index: Int) {
        delegate?.addInFavorite(index: index)
    }
    
    func costDifferense(from: Valute, to: Valute) -> Double {
       if from.charCode == "RUB" {
           
           return (to.value / Double(to.nominal)) - (to.previous / Double(to.nominal))
       }
       
       if to.charCode == "RUB" {
           return (from.value  / Double(from.nominal)) - (from.previous / Double(from.nominal))
       }
       
       let previus = (from.previous / Double(from.nominal)) / (to.previous / Double(to.nominal))
       
       let current = (from.value / Double(from.nominal)) / (to.value / Double(to.nominal))

       return current - previus
   }
}
