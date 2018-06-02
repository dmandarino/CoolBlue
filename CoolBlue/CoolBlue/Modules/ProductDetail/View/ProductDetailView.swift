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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    
    convenience init(productId: Int) {
        self.init(nibName: String(describing: ProductDetailView.self), bundle: nil)
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
        showImages(images: product.images)
        hideSkeleton()
    }
    
    private func showImages(images: [String]) {
        for i in 0..<images.count {
            let imageView = UIImageView()
            let viewWidth = self.view.frame.size.width
            let x = viewWidth * CGFloat(i)
            imageView.frame = CGRect(x: x, y: 0, width: viewWidth, height: self.scrollView.frame.height)
            imageView.contentMode = .scaleAspectFit
            imageView.af_setImage(
                withURL: URL(string: images[i])!,
                placeholderImage: UIImage().placeholder,
                imageTransition: .crossDissolve(0.2)
            )
            scrollView.contentSize.width = scrollView.frame.size.width * CGFloat(i + 1)
            scrollView.addSubview(imageView)
        }
    }
    
    private func hideSkeleton() {
        self.productName.hideSkeleton()
        self.productPrice.hideSkeleton()
        self.productDescription.hideSkeleton()
    }
}
