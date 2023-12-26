//
//  CurrencySelectionViewController.swift
//  Coinlee
//
//  Created by Valentyn Ponomarenko on 22/08/2023.
//

import UIKit
import RxSwift
import RxCocoa

final class CurrencySelectionViewController: UIViewController {
    let viewModel: CurrencySelectionViewModelType
    let currencySelectionView = CurrencySelectionView()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Inits
    init(viewModel: CurrencySelectionViewModelType) {
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
        bindFilteredCurrenciesToCurrenciesTableView()
        subscribeToFilteredCurrencies()
        subscribeToSearchTextFieldText()
        subscribeToScrollViewWillBeginDragging()
        subscribeToTapGestureRecignizerEvent()
    }
    
    // MARK: - Subscriptions
    private func subscribeToFilteredCurrencies() {
        viewModel.filteredCurrencies
            .subscribe(onNext: { _ in
                self.toggleNoResultsView()
            })
            .disposed(by: disposeBag)
    }
    
    private func subscribeToSearchTextFieldText() {
        currencySelectionView.searchTextField.rx
            .text
            .orEmpty
            .scan(String(), accumulator: { previousText, newText in
                defer {
                    self.updateNoResultLabel(withText: newText)
                    self.updateCurrenciesList(withText: newText)
                }
                
                let maxNumberOfSymbols = self.currencySelectionView.searchTextField.maximumNumberOfSymbols
                
                if maxNumberOfSymbols > 0 && newText.count > maxNumberOfSymbols {
                    self.currencySelectionView.searchTextField.text = newText.truncated(to: maxNumberOfSymbols)
                    return previousText
                }
                
                return newText
            })
            .bind(to: currencySelectionView.searchTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func subscribeToScrollViewWillBeginDragging() {
        currencySelectionView.currenciesTableView.rx
            .willBeginDragging
            .subscribe { _ in
                self.currencySelectionView.searchTextField.resignFirstResponder()
            }
            .disposed(by: disposeBag)
    }
    
    private func subscribeToTapGestureRecignizerEvent() {
        currencySelectionView.searchTextField.tapGestureRecognizer?.rx
            .event
            .subscribe(onNext: { _ in
                self.updateCurrenciesList(withText: self.currencySelectionView.searchTextField.text)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: Methods
    private func toggleNoResultsView() {
        let filteredCurrenciesIsEmpty = viewModel.filteredCurrencies.value.isEmpty
        currencySelectionView.noResultsView.isHidden = !filteredCurrenciesIsEmpty
    }
    
    private func updateNoResultLabel(withText searchText: String) {
        currencySelectionView.noResultsView.noResultLabel.text = NSLocalizedString("no_result_label", comment: "Localized search result")
        currencySelectionView.noResultsView.tryAgainLabel.text = NSLocalizedString("try_a_new_search_label", comment: "Try a new search")
        currencySelectionView.noResultsView.noResultLabel.text = (currencySelectionView.noResultsView.noResultLabel.text ?? String()) +
        " \"\(searchText.truncated(to: currencySelectionView.searchTextField.maximumNumberOfSymbols))\""
    }
    
    private func updateCurrenciesList(withText text: String?) {
        guard let text = text else { return }
        if text.isEmpty {
            viewModel.filteredCurrencies.accept(viewModel.currencies)
        } else {
            viewModel.updateFilteredCurrenciesWithSearchText(text)
        }
    }
}

// MARK: - UITableViewDataSource
extension CurrencySelectionViewController {
    private func bindFilteredCurrenciesToCurrenciesTableView() {
        viewModel.filteredCurrencies
            .bind(to: currencySelectionView.currenciesTableView.rx.items(cellIdentifier: CurrencyTableViewCell.reuseIdentifier,
                                                                         cellType: CurrencyTableViewCell.self)) { row, currency, cell in
                cell.viewModel = self.viewModel.cellViewModel(currency: currency)
        }
        .disposed(by: disposeBag)
    }
}


