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
    private var productList: [Product]?
    private var imageList: [UIImage] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
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
        
        ApiClient.sharedInstance.fetchImage(forURLString: "https://image.coolblue.nl/300x750/products/984093", completion: { image in
            self.imageList.append(image)
        })
        
//        for product in productList {
//            let imagePath = product.productImage
//        }
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

extension ListingView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCell
        guard productList != nil else {
            return cell
        }
        cell.productName.text = productList?[indexPath.item].productName
        cell.productPrice.text = productList![indexPath.item].salesPriceIncVat.currency
        
        if !imageList.isEmpty {
            cell.productImage.image = imageList[0]
        }
        
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
