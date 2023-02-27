//
//  ViewController.swift
//  Recipes
//
//  Created by user on 11.02.2023.
//

import UIKit

class HomeViewController: UIViewController {

    let userDefaults = UserDefaults.standard
    let RecipesVC = RecipesViewController()

    var person: [String : String] = [:]

    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.placeholder = "Телефон или почта"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect

        return textField
    }()

    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8817924857, green: 0.8861443996, blue: 0.9078727365, alpha: 1)
        button.layer.cornerRadius = 15
        button.setTitleColor(.black , for: .normal)

        return button
    }()

    private let registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Зарегистрироваться", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2860158086, green: 0.6941199899, blue: 0.3407269716, alpha: 1)
        button.layer.cornerRadius = 15
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        setConstraints()

        registerButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)

        person = userDefaults.object(forKey: "password") as? [String : String] ?? [:]
        passwordTextField.isSecureTextEntry = true
    }

    @objc func registerUser() {

        let person = [loginTextField.text: passwordTextField.text]
        userDefaults.set(person, forKey: "password")
        print("save data")
    }

    @objc func signIn() {
        let personal = [loginTextField.text: passwordTextField.text]

        if personal == userDefaults.object(forKey: "password") as? [String : String] {
            present(RecipesVC, animated: true)
        } else {
            presentSimpleAlert(title: "Oops", message: "Пользователь не найден")

        }
    }
}

extension HomeViewController {
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

            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 250),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),

        ])
    }

    private func addView() {
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)

    }
}

