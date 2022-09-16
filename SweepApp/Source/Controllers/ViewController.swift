//
//  ViewController.swift
//  SweepApp
//
//  Created by Nicolas Barbosa on 09/09/22.
//  swiftlint:disable trailing_whitespace

import UIKit
import CoreData

final class ViewController: UIViewController {
    
    fileprivate var viewModel = ViewModel() {
        didSet {
            viewModel.setTaskArray()
            tasksCollectionView.reloadData()
        }
    }
    
    fileprivate lazy var marcoCharacter: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    fileprivate lazy var zombieCharacter: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "zombie")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    fileprivate lazy var historyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(
            UIImage(named: "history-button"),
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(showHistoryView),
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    fileprivate lazy var addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(
            UIImage(named: "add-button"),
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(showAddTaskView),
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
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
        layout.itemSize = CGSize(width: view.bounds.width*0.3, height: view.bounds.height*0.1)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.setCollectionViewLayout(layout, animated: true)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }
    
    @objc private func showAddTaskView() {
        let addTaskViewController = AddTaskViewController()
        addTaskViewController.modalPresentationStyle = .overFullScreen
        addTaskViewController.windowAddTask.delegate = self
        self.present(addTaskViewController, animated: false)
    }
    
    @objc private func showHistoryView() {
        print("Mostrar historico")
    }

}

extension ViewController: AddTaskWindowDelegate {
    func addANewTask(nameTask: String) {
        viewModel.service.addATask(for: nameTask)
        viewModel.setTaskArray()
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
        
        self.breathingAnimation()
        
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
            imageCollectionViewBackground.heightAnchor.constraint(equalToConstant: view.bounds.height*0.3),
            
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            addButton.heightAnchor.constraint(equalToConstant: view.bounds.height*0.1),
            addButton.widthAnchor.constraint(equalToConstant: view.bounds.height*0.1),
            
            historyButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            historyButton.trailingAnchor.constraint(
                equalTo: addButton.leadingAnchor,
                constant: -view.bounds.height*0.05
            ),
            historyButton.heightAnchor.constraint(equalToConstant: view.bounds.height*0.1),
            historyButton.widthAnchor.constraint(equalToConstant: view.bounds.height*0.1),
            
            marcoCharacter.heightAnchor.constraint(equalToConstant: 424),
            marcoCharacter.widthAnchor.constraint(equalToConstant: 439),
            marcoCharacter.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.bounds.height*0.05),
            marcoCharacter.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: view.bounds.width*0.13
            ),
            
            zombieCharacter.heightAnchor.constraint(equalToConstant: 106),
            zombieCharacter.widthAnchor.constraint(equalToConstant: 125),
            zombieCharacter.bottomAnchor.constraint(equalTo: imageCollectionViewBackground.topAnchor, constant: -view.bounds.height*0.03),
            zombieCharacter.leadingAnchor.constraint(equalTo: marcoCharacter.centerXAnchor, constant: view.bounds.width*0.1)
        ])
    }
    
    func setupHierarchy() {
        view.addSubview(imageBackground)
        view.addSubview(imageCollectionViewBackground)
        view.addSubview(marcoCharacter)
        view.addSubview(tasksCollectionView)
        view.addSubview(addButton)
        view.addSubview(historyButton)
        view.addSubview(zombieCharacter)
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.taskArray.count
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
        
        cell.taskLabel.text = viewModel.taskArray[indexPath.row].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = viewModel.taskArray[indexPath.row]
        viewModel.service.deleteATask(cell)
        viewModel.setTaskArray()
    }
    
}

// MARK: - Characters Animations
extension ViewController {
    
    private func breathingAnimation() {
        
        let breathingNames = ["RES1","RES2","RES3","RES4"]
        var breathingImages = [UIImage]()
        
        for index in 0..<breathingNames.count{
            
            breathingImages.append(UIImage(named: breathingNames[index])!)
        }
        self.marcoCharacter.animationImages = breathingImages
        self.marcoCharacter.animationDuration = 1
        self.marcoCharacter.startAnimating()
        
    }
    
}
