//
//  ProductCellViewModel.swift
//  CodeCaseBN
//
//  Created by AppLogist on 15.02.2020.
//  Copyright © 2020 AhmetSina. All rights reserved.
//

import Foundation

class ProductCellViewModel {
    
    private(set) var category: String?
    private(set) var name: String?
    private(set) var price: String?
    private(set) var image: URL?
 
    init(_ product: BNProduct) {
        self.category = product.category
        self.name = product.name
        self.price = product.price
        self.image = product.image
    }
    
}
