//
//  ViewController.swift
//  SweepApp
//
//  Created by Nicolas Barbosa on 09/09/22.
//  swiftlint:disable trailing_whitespace

import UIKit
import CoreData

final class ViewController: UIViewController {

    fileprivate let viewModel = ViewModel()
    fileprivate let coreDataManager = CoreDataManager()
    
    fileprivate lazy var imageBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background-2")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    fileprivate lazy var tasksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.bounds.width*0.3, height: view.bounds.height*0.15)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear

        return collectionView
    }()
    
    fileprivate lazy var imageCollectionViewBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "asphalt")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var tasks: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

}

extension ViewController: ViewCoding {
    func setupView() {
        tasksCollectionView.delegate = self
        tasksCollectionView.dataSource = self
        tasksCollectionView.register(
            TasksCollectionViewCell.self,
            forCellWithReuseIdentifier: TasksCollectionViewCell.identifier
        )
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageBackground.topAnchor.constraint(equalTo: view.topAnchor),
            imageBackground.bottomAnchor.constraint(equalTo: imageCollectionViewBackground.topAnchor),
            imageBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tasksCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tasksCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tasksCollectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -view.bounds.height*0.075
            ),
            tasksCollectionView.topAnchor.constraint(equalTo: imageCollectionViewBackground.topAnchor),
            
            imageCollectionViewBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageCollectionViewBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageCollectionViewBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageCollectionViewBackground.heightAnchor.constraint(equalToConstant: view.bounds.height*0.3)
        ])
    }
    
    func setupHierarchy() {
        view.addSubview(imageBackground)
        view.addSubview(imageCollectionViewBackground)
        view.addSubview(tasksCollectionView)
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.mocArray.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TasksCollectionViewCell.identifier,
            for: indexPath
        ) as? TasksCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.taskLabel.text = viewModel.mocArray[indexPath.row].name
        
        return cell
    }

}
