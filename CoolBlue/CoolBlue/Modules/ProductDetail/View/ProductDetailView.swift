//
//  ProductDetailView.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 31/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit

//MARK: - ProductDetailView

class ProductDetailView: UIViewController {
 
    var presenter: ProductDetailPresenterProtocol?
    private var productId: Int?
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    
    convenience init(productId: Int) {
        self.init(nibName: "ProductDetailView", bundle: nil)
        self.productId = productId
    }
    
    override func viewDidLoad() {
        ProductDetailConfigurator.configure(viewController: self)
        setupView()
    }
    
    private func setupView() {
        productName.showAnimatedGradientSkeleton()
        productPrice.showAnimatedGradientSkeleton()
        productDescription.showAnimatedGradientSkeleton()
        updateView()
    }
}

//MARK: - ProductDetailViewProtocol

extension ProductDetailView: ProductDetailViewProtocol {
    
    func updateView() {
        guard productId != nil else {
            return
        }
        presenter?.updateView(byProductId: productId!)
    }
}

//MARK: - ProductDetailPresenterOutputProtocol

extension ProductDetailView: ProductDetailPresenterOutputProtocol {
    
    func showError() {
        let alertError = UIAlertController.getAlertError(callback: {
            self.updateView()
        })
        self.present(alertError, animated: true, completion: nil)
    }
    
    func showProduct(product: Product) {
        self.productName.text = product.name
        self.productPrice.text = product.salesPriceIncVat.currency
        self.productDescription.text = product.description.withoutHtmlTags
        self.productImage.af_setImage(
            withURL: URL(string: product.images.first!)!,
            placeholderImage: UIImage(named: "placeholder"),
            imageTransition: .crossDissolve(0.2)
        )
        hideSkeleton()
    }
    
    private func hideSkeleton() {
        self.productName.hideSkeleton()
        self.productPrice.hideSkeleton()
        self.productDescription.hideSkeleton()
    }
}
