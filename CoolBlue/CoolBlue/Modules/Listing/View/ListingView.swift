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
        fetchValuesToBePresented()
    }
}

//MARk: - ListingViewProtocol

extension ListingView: ListingViewProtocol {
    
    func fetchValuesToBePresented() {
        presenter?.fetchValuesToBePresented()
    }
}

//MARk: - ListingPresenterOutputProtocol

extension ListingView: ListingPresenterOutputProtocol {
    
}
