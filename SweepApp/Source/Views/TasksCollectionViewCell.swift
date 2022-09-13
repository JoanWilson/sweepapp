//
//  TasksCollectionViewCell.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 13/09/22.
//

import UIKit

class TasksCollectionViewCell: UICollectionViewCell {
    static let identifier = "TasksCollectionViewCell"
    lazy var taskLabel: UILabel = {
        let label = UILabel()
        label.text = "Task"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 12
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(taskLabel)
        backgroundColor = .systemGray4
        layer.cornerRadius = 15
        configConstrains()
    }
    private func configConstrains() {
        NSLayoutConstraint.activate([
            taskLabel.widthAnchor.constraint(equalToConstant: 180),
            taskLabel.heightAnchor.constraint(equalToConstant: 60),
            taskLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            taskLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
