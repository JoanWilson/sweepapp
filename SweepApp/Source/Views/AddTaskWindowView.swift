//
//  AddTaskWindow.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 14/09/22.
//

import UIKit

class AddTaskWindowView: UIView {

    fileprivate lazy var upperStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.backgroundColor = .clear
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    fileprivate lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.backgroundColor = .yellow
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView

    }()

    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "CRIAR TAREFA"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)

        return label
    }()

    fileprivate lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Aqui você pode registrar os desafios do seu persoangem..."
        label.textColor = .white
        label.textAlignment = .center

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension AddTaskWindowView: ViewCoding {
    func setupView() {
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([

            self.upperStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.upperStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.upperStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.upperStackView.bottomAnchor.constraint(equalTo: self.centerYAnchor),

            self.bottomStackView.topAnchor.constraint(equalTo: self.centerYAnchor),
            self.bottomStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

        ])
    }

    func setupHierarchy() {
        self.upperStackView.addArrangedSubview(titleLabel)
        self.upperStackView.addArrangedSubview(descriptionLabel)
        self.addSubview(bottomStackView)
        self.addSubview(upperStackView)

    }

}
