//
//  ViewController.swift
//  CodeCaseBN
//
//  Created by AppLogist on 14.02.2020.
//  Copyright © 2020 AhmetSina. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductsViewController: BaseViewController {

    private let viewModel = ProductViewModel()
    private let bag = DisposeBag()
    
    private lazy var topLogoImageView = UIImageView()
    private lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.rx.setDelegate(self).disposed(by: bag)
        bindTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        setupImageView()
        setupTableView()
    }
    
    private func setupImageView() {

        let image = UIImage(named: "bundle.jpg")
        topLogoImageView = UIImageView(image: image)
        topLogoImageView.contentMode = .scaleAspectFit
        topLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topLogoImageView)
        
        topLogoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        topLogoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topLogoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topLogoImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupTableView() {
        
        // Layout
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: topLogoImageView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Properties
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    // MARK: - Binding
    private func bindTableView() {
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
        
        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: "cellId", cellType: ProductTableViewCell.self)) { (row,item,cell) in
            let viewModel = ProductCellViewModel(item)
            cell.buyButton.rx.tap.asDriver()
                .drive(onNext: { [weak self] in
                    let productVC = ProductViewController(Int(item.id ?? "") ?? 0)
                    self?.navigationController?.pushViewController(productVC, animated: true)
                }).disposed(by: cell.bag)
                     
            cell.setupUI(viewModel)
        }.disposed(by: bag)
        
        viewModel.fetchProductList()
        
    }
}

// MARK: - UITableViewDelegate
extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

