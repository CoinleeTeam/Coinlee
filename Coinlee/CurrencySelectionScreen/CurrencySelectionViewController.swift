//
//  CurrencySelectionViewController.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 22/08/2023.
//

import UIKit

class CurrencySelectionScreenViewController: UIViewController {
    var viewModel: CurrencyTableViewViewModelType
    let currencySelectionView = CurrencySelectionView()
    
    init(viewModel: CurrencyTableViewViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = currencySelectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencySelectionView.assignCurrenciesTableViewDelegates(to: self)
        currencySelectionView.assignSearchTextFieldDelegate(to: self)
    }
}

extension CurrencySelectionScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = currencySelectionView.currenciesTableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.reuseIdentifier, for: indexPath) as? CurrencyTableViewCell
        
        guard let cell = cell else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.viewModel = cellViewModel
        
        return cell
    }
}

extension CurrencySelectionScreenViewController: UITableViewDelegate {
    
}

extension CurrencySelectionScreenViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let searchedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        if searchedText.isEmpty {
            viewModel.filteredCurrencies = viewModel.currencies
        } else {
            viewModel.updateFilteredCurrenciesWithSearchText(searchedText)
        }
        
        currencySelectionView.currenciesTableView.reloadData()
    
        return true
    }
}


