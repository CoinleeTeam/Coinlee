//
//  CurrencySelectionViewController.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 22/08/2023.
//

import UIKit

final class CurrencySelectionScreenViewController: UIViewController {
    let viewModel: CurrencyTableViewViewModelType
    let currencySelectionView = CurrencySelectionView()
    
    // MARK: - Inits
    init(viewModel: CurrencyTableViewViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController's Lifecycle
    override func loadView() {
         super.loadView()
        view = currencySelectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencySelectionView.assignCurrenciesTableViewDelegates(to: self)
        currencySelectionView.assignSearchTextFieldDelegates(to: self)
    }
   
    // MARK: - Methods
    private func toggleNoResultsView() {
        let filteredCurrenciesIsEmpty = viewModel.filteredCurrencies.isEmpty
        currencySelectionView.noResultsView.isHidden = !filteredCurrenciesIsEmpty
    }
    
    private func updateNoResultLabel(withText searchText: String) {
        currencySelectionView.noResultsView.noResultLabel.text = NSLocalizedString("no_result_label", comment: "Localized search result")
        currencySelectionView.noResultsView.tryAgainLabel.text = NSLocalizedString("try_a_new_search_label", comment: "Try a new search")
        currencySelectionView.noResultsView.noResultLabel.text = (currencySelectionView.noResultsView.noResultLabel.text ?? String()) +
        " \"\(searchText.truncated(to: currencySelectionView.searchTextField.maximumNumberOfSymbols))\""
    }
    
    private func updateCurrenciesList(withText text: String) {
        if text.isEmpty {
            viewModel.filteredCurrencies = viewModel.currencies
        } else {
            viewModel.updateFilteredCurrenciesWithSearchText(text)
        }
        
        currencySelectionView.currenciesTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension CurrencySelectionScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toggleNoResultsView()
        return viewModel.numberOfRows(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = currencySelectionView.currenciesTableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.reuseIdentifier, for: indexPath) as? CurrencyTableViewCell else { return UITableViewCell() }
                
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.viewModel = cellViewModel
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CurrencySelectionScreenViewController: UITableViewDelegate {
}

// MARK: - UITableViewDelegate: UITextFieldDelegate
extension CurrencySelectionScreenViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let searchedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? String()
        
        defer {
            updateNoResultLabel(withText: searchedText)
            updateCurrenciesList(withText: searchedText)
        }
        
        guard let searchTextField = textField as? CustomUITextField else { return true }
        let maxNumberOfSymbols = searchTextField.maximumNumberOfSymbols
        
        if maxNumberOfSymbols > 0 && searchedText.count > maxNumberOfSymbols {
            textField.text = searchedText.truncated(to: maxNumberOfSymbols)
            
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        true
    }
}

// MARK: - ClearTextFieldDelegate
extension CurrencySelectionScreenViewController: ClearTextFieldDelegate {
    func clearTextField(_ textField: UITextField) {
        updateCurrenciesList(withText: textField.text ?? String())
    }
}


