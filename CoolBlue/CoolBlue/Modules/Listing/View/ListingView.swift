//
//  ListingView.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 26/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit
import SkeletonView

//MARk: - ListingView

class ListingView: UIViewController {

    var presenter: ListingPresenterProtocol?
    private var productList: [Product] = []
    private var filteredProducList: [Product] = []
    private let reuseIdentifier = "cell"
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    convenience init() {
        self.init(nibName: String(describing: ListingView.self), bundle: nil)
    }
    
    override func viewDidLoad() {
        ListingConfigurator.configure(viewController: self)
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
        if productList.isEmpty {
            return 10
        }
        if isFiltering() {
            return filteredProducList.count
        }
        return productList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCell
        let labelsToBeSkeltonable: [UILabel] = [cell.productName, cell.productPrice]
        
        guard isProductListNotEmpty() else {
            setSkeletonableLabels(labels: labelsToBeSkeltonable)
            return cell
        }
        
        hideSkeletonsForLabels(labels: labelsToBeSkeltonable)
        return cellConfigured(cell: cell, forIndex: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        notifyDidSelectedProduct(forIndexPath: indexPath)
    }
    
    private func cellConfigured(cell: ProductCell, forIndex index: Int) -> ProductCell {
        var collection: [Product] = []
        
        if isFiltering() {
            collection = filteredProducList
        } else {
            collection = productList
        }
        
        cell.productName.text = collection[index].name
        cell.productPrice.text = collection[index].salesPriceIncVat.currency
        cell.productImage.af_setImage(
            withURL: URL(string: collection[index].images.first!)!,
            placeholderImage: UIImage().placeholder,
            imageTransition: .crossDissolve(0.2)
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
        self.collectionView.register(UINib.init(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
}

//MARk: - ListingViewProtocol

extension ListingView: ListingViewProtocol {
    
    func updateView() {
        presenter?.updateView()
    }
    
    private func notifyDidSelectedProduct(forIndexPath indexPath: IndexPath) {
        guard isProductListNotEmpty() else {
            return
        }
        
        if isFiltering() {
            presenter?.didSelectedProduct(productId: filteredProducList[indexPath.row].id)
        } else {
            presenter?.didSelectedProduct(productId: productList[indexPath.row].id)
        }
    }
}

//MARk: - ListingPresenterOutputProtocol

extension ListingView: ListingPresenterOutputProtocol {
    
    func showProducts(productList: [Product]) {
        self.productList = productList
        updateCollectionView()
    }
    
    func showError() {
        let alertError = UIAlertController.getAlertError(callback: {
            self.updateView()
        })
        self.present(alertError, animated: true, completion: nil)
    }
}

//MARK: - SkeletonTableViewDataSource

extension ListingView {
    
    private func setSkeletonableLabels(labels: [UILabel]) {
        for label in labels {
            label.isSkeletonable = true
            label.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideSkeletonsForLabels(labels: [UILabel]) {
        for label in labels {
            label.hideSkeleton()
        }
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
            return product.name.lowercased().contains(searchText.lowercased())
        })
        updateCollectionView()
    }
}
