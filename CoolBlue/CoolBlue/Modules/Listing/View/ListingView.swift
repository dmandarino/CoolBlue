//
//  ListingView.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 26/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit

//MARk: - ListingView

class ListingView: UIViewController {

    var presenter: ListingPresenterProtocol?
    private var productList: [Product] = []
    private var filteredProducList: [Product] = []
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    convenience init() {
        self.init(nibName: "ListingView", bundle: nil)
        ListingConfigurator.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        setupView()
    }
    
    private func setupView() {
        setupCollectionView()
        setupSearchController()
        updateView()
    }
}

//MARk: - UICollectionView

extension ListingView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredProducList.count
        }
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCell
        
        guard isProductListNotEmpty() else {
            return cell
        }
        
        var collection: [Product] = []
        
        if isFiltering() {
            collection = filteredProducList
        } else {
            collection = productList
        }
        
        let url = URL(string: collection[indexPath.row].productImage)!
        cell.productName.text = collection[indexPath.row].productName
        cell.productPrice.text = collection[indexPath.row].salesPriceIncVat.currency
        cell.productImage.af_setImage(
            withURL: url,
            placeholderImage: UIImage(named: "placeholder"),
            imageTransition: .crossDissolve(0.5)
        )
        
        return cell
    }
    
    private func isProductListNotEmpty() -> Bool {
        return !productList.isEmpty
    }
    
    private func updateCollectionView() {
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        self.collectionView.register(UINib.init(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
}

//MARk: - ListingViewProtocol

extension ListingView: ListingViewProtocol {
    
    func updateView() {
        presenter?.updateView()
    }
}

//MARk: - ListingPresenterOutputProtocol

extension ListingView: ListingPresenterOutputProtocol {
    
    func showProducts(productList: [Product]) {
        self.productList = productList
        updateCollectionView()
    }
    
    func showError() {
        presentErrorAlertController()
    }
    
    private func presentErrorAlertController() {
        let alertController = UIAlertController(title: "Oops", message: "Something went wrong. Do you want to try again?", preferredStyle: .alert)
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default) { (action:UIAlertAction) in
            self.updateView()
        }
        let dissmissAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(tryAgainAction)
        alertController.addAction(dissmissAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

//MARk: - UISearchResultsUpdating

extension ListingView: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterProductList(searchController.searchBar.text!)
    }
    
    private func setupSearchController() {
        UITextField.appearance(whenContainedInInstancesOf:
            [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "May I help you?"
        searchController.searchBar.tintColor = UIColor.white
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    private func filterProductList(_ searchText: String) {
        filteredProducList = productList.filter({( product : Product) -> Bool in
            return product.productName.lowercased().contains(searchText.lowercased())
        })
        updateCollectionView()
    }
}
