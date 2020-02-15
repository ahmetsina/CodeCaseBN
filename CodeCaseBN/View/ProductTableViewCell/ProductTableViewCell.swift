//
//  ProductTableViewCell.swift
//  CodeCaseBN
//
//  Created by AppLogist on 15.02.2020.
//  Copyright © 2020 AhmetSina. All rights reserved.
//

import UIKit
import RxSwift

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    var bag = DisposeBag()

    
    func setupUI(_ viewModel: ProductCellViewModel) {
        productCategoryLabel.text = viewModel.category
        productPriceLabel.text = viewModel.price
        productNameLabel.text = viewModel.name
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
        productCategoryLabel.text = nil
        productNameLabel.text = nil
        productImageView.image = nil
        productPriceLabel.text = nil
    }
}
