//
//  ViewController+ViewCoding.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 22/09/22.
//

import Foundation
import UIKit

extension UIView {
    func pin(to superview: UIView)  {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor)
        ])
    }
}


