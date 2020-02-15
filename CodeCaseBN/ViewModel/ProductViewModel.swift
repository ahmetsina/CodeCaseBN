//
//  Product.swift
//  CodeCaseBN
//
//  Created by AppLogist on 15.02.2020.
//  Copyright © 2020 AhmetSina. All rights reserved.
//

import RxSwift

public class ProductViewModel {
    
    // MARK: - Dependencies
    
    public let items = PublishSubject<[BNProduct]>()
    public let item = PublishSubject<BNProduct>()
    
    public func fetchProductList() {
        ServiceManager.shared.products { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let response):
                    self.items.onNext(response)
                    self.items.onCompleted()
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self.items.onError(error)
            }
        }
    }
    
    public func fetchProduct(_ id: Int) {
        ServiceManager.shared.product(id) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let response):
                    self.item.onNext(response)
                    self.item.onCompleted()
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self.item.onError(error)
            }
        }
    }
}
