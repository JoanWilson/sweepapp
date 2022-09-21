//
//  HistoryCollectionViewCell.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 20/09/22.
//

import UIKit

final class HistoryCollectionViewCell: UICollectionViewCell {

    static let identifier = "HistoryCollectionViewCell"

    public lazy var taskLabel: UILabel = {
        let label = UILabel()
        label.text = "Task"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    fileprivate lazy var imageCheck: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "check")
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

extension HistoryCollectionViewCell: ViewCoding {

    func setupView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([

            self.imageCheck.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.imageCheck.heightAnchor.constraint(equalToConstant: self.bounds.height*0.7),
            self.imageCheck.widthAnchor.constraint(equalToConstant: self.bounds.width*0.2),
            self.imageCheck.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            self.taskLabel.leadingAnchor.constraint(equalTo: self.imageCheck.trailingAnchor),
            self.taskLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.taskLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10)

        ])
    }

    func setupHierarchy() {
        self.addSubview(self.taskLabel)
        self.addSubview(self.imageCheck)
    }

}
