//
//  ViewController.swift
//  Recipes
//
//  Created by user on 11.02.2023.
//

import UIKit

class LoginViewController: UIViewController {

    private let userDefaults = UserDefaults.standard
    private let recipesVC = MainTabBarController()
    private var person: [String: String] = [:]

    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Телефон или почта"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect

        return textField
    }()

    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8817924857, green: 0.8861443996, blue: 0.9078727365, alpha: 1)
        button.layer.cornerRadius = 15
        button.setTitleColor(.black , for: .normal)

        return button
    }()

    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2860158086, green: 0.6941199899, blue: 0.3407269716, alpha: 1)
        button.layer.cornerRadius = 15
        return button
    }()

    private let failureLabel: UILabel = {
        let label = UILabel()
        label.text = "Oops, такой пользователь уже существует"
        label.textColor = .red
        label.font = label.font.withSize(12)
        label.numberOfLines = 0
        label.textAlignment = .center

        return label
    }()

    private let succesLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы зарегистрировались!"
        label.textColor = .black
        label.font = label.font.withSize(20)
        label.numberOfLines = 0
        label.textAlignment = .center

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        updateUi()
        setConstraints()
        setupKeyboard()
        addTarget()
        dataRecovery()
    }

    @objc func registerUser() {
        let personal = [loginTextField.text: passwordTextField.text] as? [String: String] ?? [:]

        if passwordTextField.text == "" {
            presentSimpleAlert(title: "Oops", message: "Введите необходимые поля")

        } else if personal == person {
            failureLabel.isHidden = false
        } else {
            let person = [loginTextField.text: passwordTextField.text]
            userDefaults.set(person, forKey: "password")
            succesLabel.isHidden = false
        }
    }

    @objc func signIn() {
        let personal = [loginTextField.text: passwordTextField.text] as? [String: String] ?? [:]

        if personal == person {
            recipesVC.modalPresentationStyle = .fullScreen
            present(recipesVC, animated: true, completion: nil)
            
            failureLabel.isHidden = true
            loginTextField.text = ""
            passwordTextField.text = ""
            print(personal)
        } else {
            presentSimpleAlert(title: "Oops", message: "Пользователь не найден", textField: passwordTextField)
        }
    }
}

extension LoginViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([

            loginTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),

            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 32),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),

            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),

            failureLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 1),
            failureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            failureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            failureLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 1),

            succesLabel.bottomAnchor.constraint(equalTo: loginTextField.topAnchor, constant: -8),
            succesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            succesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)

        ])
    }

    private func setupViews() {
        view.addView(loginButton)
        view.addView(registerButton)
        view.addView(loginTextField)
        view.addView(passwordTextField)
        view.addView(failureLabel)
        view.addView(succesLabel)
    }

    private func dataRecovery() {
        person = userDefaults.object(forKey: "password") as? [String: String] ?? [:]

    }

    private func setupKeyboard() {
        //passwordTextField.keyboardType = .asciiCapableNumberPad
        passwordTextField.isSecureTextEntry = true

    }

    private func addTarget() {
        registerButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
    }

    private func updateUi() {
        view.backgroundColor = .white
        failureLabel.isHidden = true
        succesLabel.isHidden = true
    }
}

extension LoginViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

