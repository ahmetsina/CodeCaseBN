//
//  BaseViewController.swift
//  CodeCaseBN
//
//  Created by AppLogist on 14.02.2020.
//  Copyright © 2020 AhmetSina. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private lazy var navBar = UINavigationBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white
    }
}
