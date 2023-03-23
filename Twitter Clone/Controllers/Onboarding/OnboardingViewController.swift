//
//  OnboardingViewController.swift
//  Twitter Clone
//
//  Created by Vladlens Kukjans on 23/03/2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "See what's happening in the world right now."
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create Account", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let promtLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.tintColor = .gray
        label.text = "Have an account already?"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.tintColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(welcomeLabel)
        view.addSubview(createAccountButton)
        view.addSubview(promtLabel)
        view.addSubview(loginButton)
        setConstraints()
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
    }
    
    @objc private func didTapCreateAccount() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
extension OnboardingViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            createAccountButton.widthAnchor.constraint(equalTo: welcomeLabel.widthAnchor,constant: -20),
            createAccountButton.heightAnchor.constraint(equalToConstant: 60),
            
            promtLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            promtLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -60),
        
            loginButton.centerYAnchor.constraint(equalTo: promtLabel.centerYAnchor),
            loginButton.leadingAnchor.constraint(equalTo: promtLabel.trailingAnchor,constant: 10)
            
            
        ])
    }
}
