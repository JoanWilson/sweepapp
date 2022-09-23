//
//  LicenseDetailViewController.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 23/09/22.
//

import UIKit

struct Section {
    let name: String
    var rows: [String]
}

class LicenseDetailViewController: UIViewController {

    public var license: License = License(object: "Teste", type: ["CCO"], authors: ["teste"], links: ["Teste"])
    private var sectionTitles: [String] = [
        "Componente",
        "Licença",
        "Autores",
        "Links"
    ]

    var sections = [Section]()

    fileprivate lazy var blurEffectBackground: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        return blurEffectView
    }()

    private lazy var licenseDetailTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "licenseCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSectionsData()
        buildLayout()
        // Do any additional setup after loading the view.
    }

    private func setUpSectionsData() {
        self.sections = [
            Section(name: "Componente", rows: [license.object]),
            Section(name: "Licença", rows: self.license.type),
            Section(name: "Autores", rows: self.license.authors),
            Section(name: "Links", rows: self.license.links)
        ]
    }

}

extension LicenseDetailViewController: ViewCoding {
    func setupView() {
        self.view.backgroundColor = .clear
        self.licenseDetailTableView.dataSource = self
        self.licenseDetailTableView.delegate = self
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.licenseDetailTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.licenseDetailTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.licenseDetailTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.licenseDetailTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    func setupHierarchy() {
        checkIfTransparencyIsEnabled()
        self.view.addSubview(licenseDetailTableView)
    }

    private func checkIfTransparencyIsEnabled() {
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.view.addSubview(blurEffectBackground)
        } else {
            view.backgroundColor = .clear
        }
    }
}

extension LicenseDetailViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        if let header = view as? UITableViewHeaderFooterView {

            header.textLabel?.textColor = .white
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section].name
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = self.sections[section].rows
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "licenseCell", for: indexPath)
        let items = self.sections[indexPath.section].rows
        let item = items[indexPath.row]
        cell.backgroundColor = .clear
        cell.textLabel?.text = item
        cell.textLabel?.textColor = .white

        return cell

    }

}
