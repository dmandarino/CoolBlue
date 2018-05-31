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
        updateProductList()
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

//MARk: - UICollectionView

extension ListingView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard !productList.isEmpty else {
            return 10
        }
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCell
        
        guard !productList.isEmpty else {
            return cell
        }
        
        let url = URL(string: productList[indexPath.item].productImage)!
        cell.productName.text = productList[indexPath.item].productName
        cell.productPrice.text = productList[indexPath.item].salesPriceIncVat.currency
        cell.productImage.af_setImage(
            withURL: url,
            placeholderImage: UIImage(named: "placeholder"),
            imageTransition: .crossDissolve(0.5)
        )
        
        return cell
    }
    
    private func updateProductList() {
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        self.collectionView.register(UINib.init(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
}

//MARk: - UISearchResultsUpdating

extension ListingView: UISearchResultsUpdating {
    
    private func setupSearchController() {
        UITextField.appearance(whenContainedInInstancesOf:
            [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "What are you looking for?"
        searchController.searchBar.tintColor = UIColor.white
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
