//
//  LicenseViewController+TableViewController.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 22/09/22.
//

import Foundation
import UIKit

extension LicenseViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Componentes"
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        if let header = view as? UITableViewHeaderFooterView {

            header.textLabel?.textColor = .white
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.data[indexPath.row].object
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .darkGray

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let licenseDetailViewController = LicenseDetailViewController()
        licenseDetailViewController.license = viewModel.data[indexPath.row]
        self.navigationController?.pushViewController(licenseDetailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)

    }

}
