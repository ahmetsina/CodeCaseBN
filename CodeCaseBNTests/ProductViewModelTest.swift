//
//  ProductViewModelTest.swift
//  CodeCaseBNTests
//
//  Created by AppLogist on 15.02.2020.
//  Copyright © 2020 AhmetSina. All rights reserved.
//

import XCTest
@testable import CodeCaseBN
import RxSwift
import RxTest

class ProductViewModelTest: XCTestCase {
    
    let mockData: BNProduct = BNProduct(id: "1",
                                        category: "Baby",
                                        name: "Handcrafted",
                                        price: "336.00",
                                        image: nil)
    
    func testProducts() {
        
        let scheduler = TestScheduler(initialClock: 0)
        // Create our view model
        let viewModel = ProductViewModel()
        // Always remember to dispose of subscriptions
        let disposeBag = DisposeBag()
        
        viewModel.items.subscribeOn(scheduler).subscribe(onNext: { [weak self] (products) in
            guard let self = self else { return }
            assert(self.mockData == products.first, "Products are not equal")
        }, onError: { (error) in
            assertionFailure(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    func testProduct() {
        
        let scheduler = TestScheduler(initialClock: 0)
        // Create our view model
        let viewModel = ProductViewModel()
        // Always remember to dispose of subscriptions
        let disposeBag = DisposeBag()
        
        viewModel.item.subscribeOn(scheduler).subscribe(onNext: { [weak self] (product) in
            guard let self = self else { return }
            assert(self.mockData == product, "Products are not equal")
        }, onError: { (error) in
            assertionFailure(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
}
