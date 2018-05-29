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
    
    override func viewDidLoad() {
        ListingConfigurator.configure(viewController: self)
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
