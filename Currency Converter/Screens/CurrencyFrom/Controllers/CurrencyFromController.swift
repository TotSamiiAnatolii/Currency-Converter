//
//  CurrencyFromController.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import UIKit

final class CurrencyFromController: UIViewController {
    
    //MARK: Properties
    fileprivate var viewCurrency: CurrencyFromView {
        guard let view = self.view as? CurrencyFromView else {return CurrencyFromView()}
        return view
    }
    
    private let header = "Add currency from"
        
    public var delegate: CurrencyDelegate?
    
    private var dataSource: CurrencyFromDataSource

    private var lastSelectedIndexPath: IndexPath = [0, 0]
    
    //MARK: Init
    init(model: ModelFromCurrency) {
        self.dataSource = CurrencyFromDataSource(model: model.currencyFrom)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    override func loadView() {
        super.loadView()
        self.view = CurrencyFromView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        dataSource.output = self
        viewCurrency.tableView.delegate = dataSource
        viewCurrency.tableView.dataSource = dataSource
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.updateCurrencyFrom(value: dataSource.model)
    }
    
    //MARK: Setup navigationBar
    private func setupNavigationBar() {
        self.title = header
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
extension CurrencyFromController: CurrencyFromDataSourceOutput {
    func addCurrencyFrom(currency: Valute) {
        delegate?.addCurrencyFrom(value: currency)
    }
    
    
}
