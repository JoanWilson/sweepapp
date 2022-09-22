//
//  AddTaskWindow.swift
//  SweepApp
//
//  Created by Joan Wilson Oliveira on 14/09/22.
//

import UIKit

protocol AddTaskWindowDelegate: AnyObject {
    func addANewTask(nameTask: String)
}

final class AddTaskWindowView: UIView {

    var dismissView: () -> Void

    private let viewModel = ViewModel()

    weak var delegate: AddTaskWindowDelegate?

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
        label.text = "Aqui você pode registrar os desafios do seu personagem..."
        label.textColor = .white
        label.textAlignment = .center

        return label
    }()

    fileprivate lazy var taskNameTextField: UITextField = {
        let textField = TextFieldWithPadding()
        textField.placeholder = "Digite o nome da tarefa"
        textField.keyboardType = .alphabet
        textField.autocorrectionType = .yes
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(
            string: "Digite uma tarefa, ex: Limpar a casa, Estudar e etc.",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray.cgColor]
        )
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    fileprivate lazy var cancelButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.addTarget(self, action: #selector(dismissAddTaskWindow), for: .touchUpInside)
        button.setTitle("Cancelar", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    fileprivate lazy var doneButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.addTarget(self, action: #selector(addANewTask), for: .touchUpInside)
        button.setTitle("Adicionar", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    init(frame: CGRect, dismiss: @escaping () -> Void) {
        self.dismissView = dismiss
        super.init(frame: .zero)
        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func dismissAddTaskWindow() {
        dismissView()
    }

    @objc func addANewTask() {
        let newTaskName: String = taskNameTextField.text!
        delegate?.addANewTask(nameTask: newTaskName)
        dismissView()
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

            self.taskNameTextField.topAnchor.constraint(equalTo: upperStackView.bottomAnchor),
            self.taskNameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.taskNameTextField.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: ViewController().view.bounds.width*0.08
            ),
            self.taskNameTextField.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -ViewController().view.bounds.width*0.08
            ),
            self.taskNameTextField.heightAnchor.constraint(equalToConstant: ViewController().view.bounds.height*0.1),

            self.cancelButton.topAnchor.constraint(
                equalTo: taskNameTextField.bottomAnchor,
                constant: ViewController().view.bounds.width*0.02
            ),
            self.cancelButton.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: ViewController().view.bounds.width*0.08
            ),
            self.cancelButton.trailingAnchor.constraint(
                equalTo: self.centerXAnchor,
                constant: -ViewController().view.bounds.width*0.03
            ),
            self.cancelButton.heightAnchor.constraint(
                equalToConstant: ViewController().view.bounds.height*0.1
            ),

            self.doneButton.topAnchor.constraint(
                equalTo: taskNameTextField.bottomAnchor,
                constant: ViewController().view.bounds.width*0.02
            ),
            self.doneButton.leadingAnchor.constraint(
                equalTo: cancelButton.trailingAnchor,
                constant: ViewController().view.bounds.width*0.03
            ),
            self.doneButton.heightAnchor.constraint(
                equalToConstant: ViewController().view.bounds.height*0.1
            ),
            self.doneButton.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -ViewController().view.bounds.width*0.08
            )

        ])
    }

    func setupHierarchy() {
        self.upperStackView.addArrangedSubview(titleLabel)
        self.upperStackView.addArrangedSubview(descriptionLabel)
        self.addSubview(taskNameTextField)
        self.addSubview(upperStackView)
        self.addSubview(cancelButton)
        self.addSubview(doneButton)
    }

}
