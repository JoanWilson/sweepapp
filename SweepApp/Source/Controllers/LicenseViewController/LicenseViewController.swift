//
//  LicenseScreen.swift
//  TheWalkingTask
//
//  Created by Tales Valente on 21/09/22.
//  swiftlint:disable trailing_whitespace

import Foundation
import UIKit
//https://www.youtube.com/watch?v=2yVzeFIMtyc

struct License {
    let object: String // Nome do Objeto
    let type: [String] // Tipo de Licensa
    let authors: [String] // Autores do Objeto
    let links: [String] // Link para licenças
}

class LicenseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()

    var data: [License] = [
        License(object: "Adult Shadow", type: ["cc0"], authors: ["drjamgo@hotmail.com"], links: ["https://opengameart.org/content/shadow-for-lpc-sprite"]),
        
        License(
            object: "Body Muscular White v2",
            
            type: [
            "CC-BY-SA 3.0",
            ],
            
            authors: [
                "Benjamin K. Smith (BenCreating)",
                "Sander Frenken (castelonia)",
                "dalonedrau, Durrani, ElizaWy",
                "Johannes Sjölund (wulax)",
                "kheftel",
                "Marcel van de Steeg (MadMarcel)",
                "Matthew Krohn (makrohn)",
                "MuffinElZangano",
                "Nila122",
                "Pierre Vigier (pvigier)",
                "Stephen Challener (Redshrike)",
                "William.Thompsonj",
                "Zi Ye"
            ],
            
            links: [
                "https://opengameart.org/content/lpc-barbarian-sprite-base",
                "https://opengameart.org/content/lpc-character-bases",
            ]
        ),
        
        License(
            object: "Eye Male Yellow",
            
            type: [
            "CC-BY-SA 3.0",
            "GPL 3.0",
            ],
            
            authors: [
            "David Conway Jr. (JaidynReiman)",
            "Stephen Challener (Redshrike)",
            "Johannes Sjölund (wulax)",
            "Matthew Krohn (makrohn)",
            ],
            
            links: [
            "https://opengameart.org/content/liberated-pixel-cup-lpc-base-assets-sprites-map-tiles",
            "https://opengameart.org/content/lpc-medieval-fantasy-character-sprites",
            ]
        ),
        License(
            object: "Hair Jewfro Dark Brown",
            
            type: [
            "CC-BY-SA 3.0",
            "GPL 3.0"
            ],
            
            authors: [
            "David Conway Jr. (JaidynReiman)",
            ],
            
            links: [
            "https://opengameart.org/content/lpc-curly-hair-elven-ears-white-cape-with-blue-trim-and-more",
            "https://github.com/jrconway3/Universal-LPC-spritesheet/commit/46ddcf05a0e43e7aa6ffd47d350eef0eb529ac24"
            ]
        ),
        License(
            object: "Hat Bandana Red",
            
            type: [
            "CC-BY-SA 3.0",
            ],
            
            authors: [
            "Matthew Krohn (makrohn)",
            "David Conway Jr. (JaidynReiman)",
            "Marcel van de Steeg (MadMarcel)"
            ],
            
            links: [
            "https://opengameart.org/content/lpc-female-orcogregoblintroll-base-walkcycle",
            "https://github.com/makrohn/Universal-LPC-spritesheet/commit/f50007cb47c235d8896cafae7a613f0b6a9a09a8?short_path=02b86d4#diff-02b86d45789a3e3e8e79519c7d17d15c9e6ecc9b4ddecb1bcd8dfbbaef430b75",
            
            ]
        ),
        License(
            object: "Leg Pants Muscular Brown",
            
            type: [
            "CC-BY-SA 3.0",
            "GPL 2.0",
            "GPL 3.0"
            ],
            
            authors: [
            "Nila122",
            "Johannes Sjölund (wulax)",
            "Stephen Challener (Redshrike)"
            ],
            
            links: [
            "https://opengameart.org/content/more-lpc-clothes-and-hair",
            
            ]
        ),
        License(
            object: "Weapon LognSword",
            
            type: [
            "CC-BY-SA 3.0.",
            ],
            
            authors: [
            "Johannes Sjölund (wulax)",
            "bluecarrot16"
            ],
            
            links: [
            "https://opengameart.org/content/lpc-medieval-fantasy-character-sprites",
            "https://opengameart.org/content/lpc-extended-weapon-animations"
            
            ]
        ),
        License(
            object: "Body Male Special Zombie",
            
            type: [
            "CC-BY-SA 3.0",
            "GPL 3.0."
            ],
            
            authors: [
            "",
            "Benjamin K. Smith (BenCreating)",
            "Sander Frenken (castelonia)",
            "Johannes Sjölund (wulax)",
            "Stephen Challener (Redshrike)"
            ],
            
            links: [
            "https://opengameart.org/content/liberated-pixel-cup-lpc-base-assets-sprites-map-tiles",
            "https://opengameart.org/content/lpc-medieval-fantasy-character-sprites",
            "https://opengameart.org/content/lpc-zombie"
            ]
        ),
        License(
            object: "Hangar Scene Tileset",
            
            type: [
            "CC0",
            ],
            
            authors: [
            "Ansimuz",
            ],
            
            links: [
            "https://opengameart.org/content/bulkhead-walls-hangar",
            
            ]
        ),
        License(
            object: "Ground",
            
            type: [
            "OGA-BY 3.0",
            ],
            
            authors: [
            "CraftPix.net 2D Game Assets",
            ],
            
            links: [
            "https://opengameart.org/content/oga-by-30-faq",

            ]
        ),
    
        

    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].object
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailViewController = DetailViewController()
        detailViewController.textLabel.text = data[indexPath.row].type
        detailViewController.modalPresentationStyle = .popover
        self.showDetailViewController(detailViewController, sender: nil)
        
    }
}

class DetailViewController: UIViewController {
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Sem nada"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .roundedRect)
        
        button.setTitle("voltar", for: UIControl.State.normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(voltar), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.textLabel)
        self.view.addSubview(self.button)
        
        NSLayoutConstraint.activate([
            textLabel.widthAnchor.constraint(equalToConstant: 100),
            textLabel.heightAnchor.constraint(equalToConstant: 20),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textLabel.topAnchor.constraint(equalTo: view.topAnchor),
            
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            button.heightAnchor.constraint(equalToConstant: 30),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.bottomAnchor.constraint(equalTo: textLabel.topAnchor)
        ])
        
    }
    
    @objc func voltar() {
        self.dismiss(animated: true)
    }
    
}
