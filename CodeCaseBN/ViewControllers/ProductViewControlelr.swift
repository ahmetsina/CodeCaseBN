//
//  ProductViewControlelr.swift
//  CodeCaseBN
//
//  Created by AppLogist on 15.02.2020.
//  Copyright © 2020 AhmetSina. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductViewController: BaseViewController {

    private var id : Int?
    private let viewModel = ProductViewModel()
    private let bag = DisposeBag()
    
    private lazy var imageView = UIImageView()
    private lazy var categoryLabel = UILabel()
    private lazy var nameLabel = UILabel()
    private lazy var priceLabel = UILabel()
    
    private lazy var buyButton = UIButton()
    private lazy var addToCartButton = UIButton()
    
    convenience init(_ id: Int ) {
        self.init()
        self.id = id
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        setupNavigationBar()
        setupImageView()
        setupLabels()
        bindViews()
    }
    
    private func setupImageView() {
        // ImageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0).isActive = true
        
        imageView.backgroundColor = .lightGray
    }
    
    private func setupLabels() {
        
        // MARK: - Category Label UI
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryLabel)
        
        categoryLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        
        categoryLabel.font = UIFont.systemFont(ofSize: 12)
        categoryLabel.textColor = .darkGray
        categoryLabel.textAlignment = .center

        
        // MARK: - Name Label UI
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        nameLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: categoryLabel.trailingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10).isActive = true
        
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        nameLabel.textColor = .darkText
        nameLabel.textAlignment = .center

        
        // MARK: - Price Label UI
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(priceLabel)
        
        priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        
        priceLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        priceLabel.textAlignment = .center
        
        // MARK: - Buy Button UI
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buyButton)
        
        buyButton.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor).isActive = true
        buyButton.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor).isActive = true
        buyButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10).isActive = true
        buyButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        buyButton.titleLabel?.textColor = .white
        buyButton.setTitle("HEMEN AL", for: .normal)
        buyButton.backgroundColor = .systemRed
        
        
        // MARK: - Add Cart Button UI
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addToCartButton)
        
        addToCartButton.leadingAnchor.constraint(equalTo: buyButton.leadingAnchor).isActive = true
        addToCartButton.trailingAnchor.constraint(equalTo: buyButton.trailingAnchor).isActive = true
        addToCartButton.topAnchor.constraint(equalTo: buyButton.bottomAnchor, constant: 10).isActive = true
        addToCartButton.heightAnchor.constraint(equalTo: buyButton.heightAnchor, multiplier: 1.0).isActive = true
        
        addToCartButton.setTitle("SEPETE EKLE", for: .normal)
        addToCartButton.titleLabel?.textColor = .white
        addToCartButton.backgroundColor = .black
    }
    
    private func setupNavigationBar() {
        title = "ÜRÜN DETAYI"
    }
    
    
    // MARK: - Binding
    private func bindViews() {
        viewModel.item.subscribe(onNext: { [weak self] (product) in
            guard let self = self else { return }
            self.categoryLabel.text = product.category
            self.nameLabel.text = product.name
            self.priceLabel.text = "\(product.price ?? "") TL"
            }).disposed(by: bag)
        viewModel.fetchProduct(id ?? 0)
    }
    
    
}
