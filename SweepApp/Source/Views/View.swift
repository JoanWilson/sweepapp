//
//  View.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 09/09/22.
//

import UIKit

class View: UIView {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .yellow
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
