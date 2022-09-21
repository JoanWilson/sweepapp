//
//  HistoryWindowView.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 19/09/22.
//

import UIKit

final class HistoryWindowView: UIView {

    private var viewModel = ViewModel()

    private var dismissView: () -> Void

    private let viewControllerBounds: CGRect = ViewController().view.bounds

    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "LISTA DE TAREFAS FINALIZADAS"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    fileprivate lazy var backButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.addTarget(self, action: #selector(dismissHistoryWindow), for: .touchUpInside)
        button.setTitle("Voltar", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    fileprivate lazy var historyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: viewControllerBounds.width*0.55, height: viewControllerBounds.height*0.1)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.showsVerticalScrollIndicator = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.layer.borderColor = UIColor.black.cgColor
        collectionView.layer.borderWidth = 0.5

        return collectionView
    }()

    init(frame: CGRect, dismiss: @escaping () -> Void) {
        self.dismissView = dismiss
        super.init(frame: .zero)
        buildLayout()
        backButton.addBorders(edges: [.all], color: .black)
        historyCollectionView.addBorders(edges: [.all], color: UIColor.black)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func dismissHistoryWindow() {
        dismissView()
    }

}

extension HistoryWindowView: ViewCoding {

    func setupView() {
        self.historyCollectionView.delegate = self
        self.historyCollectionView.dataSource = self
        self.historyCollectionView.register(
            HistoryCollectionViewCell.self,
            forCellWithReuseIdentifier: HistoryCollectionViewCell.identifier
        )
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: viewControllerBounds.height*0.05),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            self.backButton.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -viewControllerBounds.height*0.05
            ),
            self.backButton.widthAnchor.constraint(equalToConstant: viewControllerBounds.width*0.25),
            self.backButton.heightAnchor.constraint(equalToConstant: viewControllerBounds.height*0.1),
            self.backButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            self.historyCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.historyCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.historyCollectionView.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -20),
            self.historyCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50)
        ])
    }

    func setupHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(backButton)
        self.addSubview(historyCollectionView)
    }

}

extension HistoryWindowView: UICollectionViewDelegate, UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0

        for index in 0..<viewModel.taskArray.count {
            if viewModel.taskArray[index].isCompleted == true {
                count += 1
            }
        }

        return count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HistoryCollectionViewCell.identifier,
            for: indexPath
        ) as? HistoryCollectionViewCell else {
            return UICollectionViewCell()
        }

        if viewModel.taskArray[indexPath.row].isCompleted == true {
            cell.taskLabel.text = viewModel.taskArray[indexPath.row].name
        }

        return cell
    }
}
