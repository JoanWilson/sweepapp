//
//  AddTaskViewController.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 14/09/22.
//

import UIKit

class AddTaskViewController: UIViewController {

    fileprivate lazy var blurEffectBackground: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        return blurEffectView
    }()

    fileprivate lazy var windowAddTask: AddTaskWindowView = {
        let windowAddTask = AddTaskWindowView()
        windowAddTask.translatesAutoresizingMaskIntoConstraints = false
        windowAddTask.backgroundColor = UIColor(named: "window-color")
        windowAddTask.layer.cornerRadius = 10

        return windowAddTask
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        view.backgroundColor = .clear
    }

}

extension AddTaskViewController: ViewCoding {
    func setupView() {
        self.view.backgroundColor = .clear
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.windowAddTask.heightAnchor.constraint(equalToConstant: self.view.bounds.height*0.6),
            self.windowAddTask.widthAnchor.constraint(equalToConstant: self.view.bounds.width*0.6),
            self.windowAddTask.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.windowAddTask.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }

    func setupHierarchy() {
        checkIfTransparencyIsEnabled()
        self.view.addSubview(windowAddTask)
    }

    private func checkIfTransparencyIsEnabled() {
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.view.addSubview(blurEffectBackground)
        } else {
            view.backgroundColor = .clear
        }
    }
}
