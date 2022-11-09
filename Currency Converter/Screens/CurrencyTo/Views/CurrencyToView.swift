//
//  CurrencyToView.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import UIKit

final class CurrencyToView: UIView {
    
    //MARK: Properties
    public var tableView = UITableView(frame: .zero)
      
    private func setupTableView() {
        tableView.register(CurrencyToCell.self, forCellReuseIdentifier: CurrencyToCell.identifier)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.isScrollEnabled = false
    }
    
    //MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupTableView()
        setupSubView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View hierarhy
    private func setupSubView() {
        
        self.addSubview(tableView)
    }
    
    //MARK: Constaint
    private func setupConstraint() {
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
