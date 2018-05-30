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
    
    @IBOutlet var collectionView: UICollectionView!
    
    var labels = ["label1", "label2", "label3"]
    
    convenience init() {
        self.init(nibName: "ListingView", bundle: nil)
    }
    
    override func viewDidLoad() {
        ListingConfigurator.configure(viewController: self)
        setupScreen()
    }
    
    private func setupScreen() {
        updateView()
        setupCollectionView()
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
    
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.black
        return cell
    }
    
    private func setupCollectionView() {
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
