//
//  LicenseViewController+TableViewController.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 22/09/22.
//

import Foundation
import UIKit

extension LicenseViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfLicences.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arrayOfLicences[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(arrayOfLicences[indexPath.row])
    }

}

class LicenseDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
