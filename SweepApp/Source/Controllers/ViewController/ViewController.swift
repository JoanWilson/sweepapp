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
            NSLayoutConstraint.activate([
                zombieLifeBar.bottomAnchor.constraint(equalTo: zombieCharacter.topAnchor, constant: -view.bounds.height*0.05),
                zombieLifeBar.heightAnchor.constraint(equalToConstant: 10),
                zombieLifeBar.widthAnchor.constraint(equalToConstant: CGFloat(viewModel.getUncompletedArray().count)),
                zombieLifeBar.centerXAnchor.constraint(equalTo: zombieCharacter.centerXAnchor)
            ])
            print(viewModel.getUncompletedArray().count)
            

            tasksCollectionView.reloadData()
        }
    }

    fileprivate lazy var zombieLifeBar: UIView = {
        let lifeBar = UIView()
        lifeBar.backgroundColor = .systemGreen
        lifeBar.translatesAutoresizingMaskIntoConstraints = false

        return lifeBar
    }()

    public lazy var noTaskDetectedLabel: UILabel = {
        let label = UILabel()
        label.text = "Sem tarefas para completar, adicione mais tarefas!"
        label.numberOfLines = 0
        label.textColor = .white
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    public lazy var marcoCharacter: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    public lazy var attackAnimation: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    public lazy var zombieCharacter: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    fileprivate lazy var licenseButton: UIButton = {
        let button = UIButton(type: .custom)
        let imageConfiguration = UIImage.SymbolConfiguration(
            pointSize: view.bounds.height*0.05,
            weight: .bold,
            scale: .large
        )
        let image = UIImage(systemName: "info.circle", withConfiguration: imageConfiguration)
        button.setImage(
            image,
            for: .normal
        )
        button.sizeToFit()
        button.tintColor = .white
        button.addTarget(
            self,
            action: #selector(showLicenseView),
            for: .touchUpInside
        )
        button.setTitle("Licenças", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.alignTextBelow()
        
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    fileprivate lazy var historyButton: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(named: "history-button"),
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(showHistoryView),
            for: .touchUpInside
        )
        button.setTitle("Histórico", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.alignTextBelow()
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
        button.setTitle("Adicionar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.alignTextBelow()

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
        self.navigationController?.isToolbarHidden = false
        buildLayout()
    }
    
    @objc public func showAddTaskView() {
        let addTaskViewController = AddTaskViewController()
        addTaskViewController.modalPresentationStyle = .overFullScreen
        addTaskViewController.windowAddTask.delegate = self
        addTaskViewController.modalTransitionStyle = .crossDissolve
        self.present(addTaskViewController, animated: true)
    }
    
    @objc private func showHistoryView() {
        let historyViewController = HistoryViewController()
        historyViewController.modalPresentationStyle = .overFullScreen
        historyViewController.modalTransitionStyle = .crossDissolve
        self.present(historyViewController, animated: true)
    }

    @objc private func showLicenseView() {
        let licenseViewController = UINavigationController(rootViewController: LicenseViewController())
        licenseViewController.modalPresentationStyle = .overCurrentContext
        licenseViewController.modalTransitionStyle = .crossDissolve
        self.present(licenseViewController, animated: true)
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
        
        self.startAnimations()

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
            addButton.widthAnchor.constraint(equalToConstant: view.bounds.height*0.15),
            
            historyButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            historyButton.trailingAnchor.constraint(
                equalTo: addButton.leadingAnchor,
                constant: -view.bounds.height*0.01
            ),
            historyButton.heightAnchor.constraint(equalToConstant: view.bounds.height*0.1),
            historyButton.widthAnchor.constraint(equalToConstant: view.bounds.height*0.2),

            licenseButton.heightAnchor.constraint(equalToConstant: view.bounds.height*0.1),
            licenseButton.widthAnchor.constraint(equalToConstant: view.bounds.height*0.15),
            licenseButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            licenseButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            marcoCharacter.heightAnchor.constraint(equalToConstant: 440),
            marcoCharacter.widthAnchor.constraint(equalToConstant: 216),
            marcoCharacter.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.bounds.height*0.08),
            marcoCharacter.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: view.bounds.width*0.28
            ),
            
            attackAnimation.heightAnchor.constraint(equalToConstant: 440),
            attackAnimation.widthAnchor.constraint(equalToConstant: 216),
            attackAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.bounds.height*0.08),
            attackAnimation.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: view.bounds.width*0.28
            ),
            
            zombieCharacter.heightAnchor.constraint(equalToConstant: 105),
            zombieCharacter.widthAnchor.constraint(equalToConstant: 60),
            zombieCharacter.bottomAnchor.constraint(
                equalTo: imageCollectionViewBackground.topAnchor,
                constant: view.bounds.height*0.01
            ),
            zombieCharacter.leadingAnchor.constraint(
                equalTo: marcoCharacter.centerXAnchor,
                constant: view.bounds.width*0.08
            ),

            noTaskDetectedLabel.centerYAnchor.constraint(equalTo: tasksCollectionView.centerYAnchor),
            noTaskDetectedLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),



        ])
    }
    
    func setupHierarchy() {
        view.addSubview(imageBackground)
        view.addSubview(imageCollectionViewBackground)
        view.addSubview(zombieCharacter)
        view.addSubview(marcoCharacter)
        view.addSubview(attackAnimation)
        view.addSubview(tasksCollectionView)
        view.addSubview(addButton)
        view.addSubview(historyButton)
        view.addSubview(licenseButton)
        view.addSubview(noTaskDetectedLabel)
        view.addSubview(zombieLifeBar)

    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if viewModel.getUncompletedArray().count == 0 {
            self.noTaskDetectedLabel.isHidden = false
            buildLayout()
            return 0
        } else {
            self.noTaskDetectedLabel.isHidden = true
            return viewModel.getUncompletedArray().count
        }

    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TasksCollectionViewCell.identifier,
            for: indexPath
        ) as? TasksCollectionViewCell else {
            return UICollectionViewCell()
            
        }
        let favorite = UIAction(title: "Completar",
          image: UIImage(systemName: "checkmark.square")) { _ in
            DispatchQueue.main.async {
                let task = self.viewModel.getUncompletedArray()[indexPath.row]
                self.viewModel.service.completeATask(task)
                self.viewModel.setTaskArray()
                self.doAnimate()
                print(indexPath)
            }
        }

        cell.taskLabel.text = viewModel.getUncompletedArray()[indexPath.row].name
        cell.buttonMenu.menu = UIMenu(
            title: "\(viewModel.getUncompletedArray()[indexPath.row].name!)",
            children: [favorite]
        )

        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
