//
//  AddTaskViewController.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 14/09/22.
//

import UIKit

final class AddTaskViewController: UIViewController {

    fileprivate lazy var blurEffectBackground: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        return blurEffectView
    }()

    public lazy var windowAddTask: AddTaskWindowView = {
        let windowAddTask = AddTaskWindowView(frame: .zero) {

            self.dismiss(animated: true)
        }
        windowAddTask.translatesAutoresizingMaskIntoConstraints = false
        windowAddTask.backgroundColor = UIColor(named: "window-color")
        windowAddTask.layer.cornerRadius = 10
        return windowAddTask
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        getKeyboardRecognition()

    }

    func cancelView() {
        self.modalTransitionStyle = .crossDissolve
        self.dismiss(animated: true)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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

extension AddTaskViewController {
    private func getKeyboardRecognition() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let bottomSpace = self.view.frame.height - (windowAddTask.frame.origin.y + windowAddTask.frame.height)
            self.view.frame.origin.y -= keyboardHeight - bottomSpace + 10
        }
    }

    @objc private func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }

}
