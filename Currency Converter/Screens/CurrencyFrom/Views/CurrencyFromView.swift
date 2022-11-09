//
//  CurrencyFromView.swift
//  Currency Converter
//
//  Created by APPLE on 16.10.2022.
//

import UIKit

final class CurrencyFromView: UIView {
    
    //MARK: Properties
    public var tableView = UITableView(frame: .zero)
        
    private func setupTableView() {
        tableView.register(CurrencyFromCell.self, forCellReuseIdentifier: CurrencyFromCell.identifier)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    //MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.mainBackground
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
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
