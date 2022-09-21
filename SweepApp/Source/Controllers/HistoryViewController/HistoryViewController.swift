//
//  HistoryViewController.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 19/09/22.
//

import UIKit

final class HistoryViewController: UIViewController {

    fileprivate lazy var blurEffectBackground: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        return blurEffectView
    }()

    public lazy var windowHistory: HistoryWindowView = {
        let windowHistory = HistoryWindowView(frame: .zero) {
            self.dismiss(animated: false)
        }
        windowHistory.translatesAutoresizingMaskIntoConstraints = false
        windowHistory.backgroundColor = UIColor(named: "window-color")
        windowHistory.layer.cornerRadius = 10

        return windowHistory
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        buildLayout()
    }

    public func cancelView() {
        self.dismiss(animated: true)
    }

}

extension HistoryViewController: ViewCoding {

    func setupView() {
        self.view.backgroundColor = .clear
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.windowHistory.heightAnchor.constraint(equalToConstant: self.view.bounds.height*0.8),
            self.windowHistory.widthAnchor.constraint(equalToConstant: self.view.bounds.width*0.6),
            self.windowHistory.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.windowHistory.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }

    func setupHierarchy() {
        self.checkIfTransparencyIsEnabled()
        self.view.addSubview(windowHistory)
    }

    private func checkIfTransparencyIsEnabled() {
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.view.addSubview(blurEffectBackground)
        } else {
            view.backgroundColor = .clear
        }
    }

}
