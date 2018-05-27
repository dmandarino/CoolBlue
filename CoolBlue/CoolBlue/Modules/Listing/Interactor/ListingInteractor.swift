//
//  ListingInteractor.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 26/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation

//MARK: - ListingInteractor

class ListingInteractor {
    
    weak var delegate: ListingInteractorOutputProtocol?
    
    init() {
        
    }
}

//MARK: - ListingInteractorOutputProtocol

extension ListingInteractor: ListingInteractorProtocol {
    
}

