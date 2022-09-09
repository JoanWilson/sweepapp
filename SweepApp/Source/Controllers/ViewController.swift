//
//  ViewController.swift
//  SweepApp
//
//  Created by Nicolas Barbosa on 09/09/22.
//

import UIKit

class ViewController: UIViewController {

    fileprivate let viewModel = ViewModel()
    
    override func loadView() {
        self.view = View()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    

}
