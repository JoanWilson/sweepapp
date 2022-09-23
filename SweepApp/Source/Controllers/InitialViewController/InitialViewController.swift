//
//  InitialViewController.swift
//  SweepApp
//
//  Created by Ana Raiany Guimarães Gomes on 2022-09-21.
//

import UIKit

class InitialViewController: UIViewController {

    fileprivate lazy var label1: UILabel = {
        let label = UILabel()
        label.text = "Olá meu nome é Marco e preciso da sua ajuda..."
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Trebuchet-BoldItalic", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate lazy var imageCollectionViewBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background-2")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    fileprivate lazy var imageCollectionViewAsphalt: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "asphalt")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    fileprivate lazy var imageCollectionViewMarco: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tutorial")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    var step = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imageCollectionViewBackground)
        self.view.addSubview(imageCollectionViewAsphalt)
        self.view.addSubview(imageCollectionViewMarco)
        self.view.addSubview(label1)
        setupConstraints()

        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)

    }

    @objc func doubleTapped() {
        step += 1
        if step == 1 {
            label1.text = """
            Minha terra foi atacada por zumbis e
            estou procurando refugio em alguma cidade vizinha...
            """
        }
        if step == 2 {
            self.label1.text = "Mas pra isso preciso da sua ajuda nessa jornada..."

        }
        if step == 3 {
            self.label1.text = """
                          A cada tarefa realizada eu chego mais perto do meu objetivo.
            """

        }
        if step == 4 {
            self.label1.text = "Crie sua primeira atividade."

        }

        if step >= 5 {
            let viewController = ViewController()
            viewController.modalPresentationStyle = .overCurrentContext
            viewController.modalTransitionStyle = .crossDissolve

            self.present(UINavigationController(rootViewController: viewController), animated: true)
            viewController.showAddTaskView()

        }

    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageCollectionViewBackground.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            imageCollectionViewBackground.bottomAnchor.constraint(
                equalTo: imageCollectionViewAsphalt.topAnchor, constant: 20
            ),
            imageCollectionViewBackground.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            imageCollectionViewBackground.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            imageCollectionViewMarco.bottomAnchor.constraint(
                equalTo: imageCollectionViewAsphalt.topAnchor, constant: 40
            ),
            imageCollectionViewMarco.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor, constant: 140
            ),
            label1.centerXAnchor.constraint(
                equalTo: view.centerXAnchor,
                constant: view.bounds.width*0.03
            ),
            label1.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),


        ])
    }

}
