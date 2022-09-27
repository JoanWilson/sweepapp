//
//  TasksCollectionViewCell.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 13/09/22.
//

import UIKit

final class TasksCollectionViewCell: UICollectionViewCell {

    static let identifier = "TasksCollectionViewCell"

    lazy var buttonMenu: UIButton = {
        let button = UIButton()
        button.showsMenuAsPrimaryAction = true
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    lazy var taskLabel: UILabel = {
        let label = UILabel()
        label.text = "Task"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    lazy var imageLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sword")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TasksCollectionViewCell: ViewCoding {
    func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 5
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageLogo.trailingAnchor.constraint(equalTo: taskLabel.leadingAnchor),
            imageLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageLogo.heightAnchor.constraint(equalToConstant: self.bounds.height*0.7),
            imageLogo.widthAnchor.constraint(equalToConstant: self.bounds.width*0.2),
            taskLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            taskLabel.leadingAnchor.constraint(equalTo: imageLogo.trailingAnchor),
            taskLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            buttonMenu.topAnchor.constraint(equalTo: self.topAnchor),
            buttonMenu.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            buttonMenu.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonMenu.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    func setupHierarchy() {
        self.addSubview(taskLabel)
        self.addSubview(imageLogo)
        self.addSubview(buttonMenu)
    }

}
