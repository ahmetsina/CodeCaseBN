//
//  Product.swift
//  CodeCaseBN
//
//  Created by AppLogist on 14.02.2020.
//  Copyright © 2020 AhmetSina. All rights reserved.
//

import Foundation

public struct BNProduct: Codable, Equatable {
    public init(id: String?, category: String?, name: String?, price: String?, image: URL?) {
        self.id = id
        self.category = category
        self.name = name
        self.price = price
        self.image = image
    }
    
    public let id: String?
    public let category: String?
    public let name: String?
    public let price: String?
    public let image: URL?
    
    public static func == (lhs: BNProduct, rhs: BNProduct) -> Bool {
        return lhs.id == rhs.id
    }

}
