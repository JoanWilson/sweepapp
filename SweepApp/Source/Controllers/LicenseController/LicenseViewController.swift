//
//  LicenseViewController.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 22/09/22.
//

import UIKit

class LicenseViewController: UIViewController {

    public var viewModel: LicenseViewModel = LicenseViewModel()

    fileprivate lazy var blurEffectBackground: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        return blurEffectView
    }()

    private lazy var licenseTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        buildLayout()
    }

    @objc func dismissView() {
        self.dismiss(animated: true)
    }

}

extension LicenseViewController: ViewCoding {
    func setupView() {
        self.view.backgroundColor = .clear
        self.navigationItem.title = "Licenças"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.isToolbarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(
            title: "Voltar",
            style: .plain,
            target: self,
            action: #selector(dismissView)
        )
        self.navigationController?.navigationBar.tintColor = .white

        self.licenseTableView.delegate = self
        self.licenseTableView.dataSource = self
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.licenseTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.licenseTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.licenseTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.licenseTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    func setupHierarchy() {
        checkIfTransparencyIsEnabled()
        self.view.addSubview(licenseTableView)
    }

    private func checkIfTransparencyIsEnabled() {
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.view.addSubview(blurEffectBackground)
        } else {
            view.backgroundColor = .clear
        }
    }
}
