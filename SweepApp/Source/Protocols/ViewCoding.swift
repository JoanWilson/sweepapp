//
//  ViewCoding.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 13/09/22.
//

import Foundation

protocol ViewCoding {
    func setupView()
    func setupConstraints()
    func setupHierarchy()
}

extension ViewCoding {
    func buildLayout() {
        setupView()
        setupHierarchy()
        setupConstraints()
    }
}
