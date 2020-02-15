//
//  BN+UIView.swift
//  CodeCaseBN
//
//  Created by AppLogist on 15.02.2020.
//  Copyright © 2020 AhmetSina. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
          get {
              return layer.cornerRadius
          }
          set {
              layer.cornerRadius = newValue
              layer.masksToBounds = newValue > 0
          }
      }
}
