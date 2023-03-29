//
//  ProfileDataFormViewController.swift
//  Twitter Clone
//
//  Created by Vladlens Kukjans on 26/03/2023.
//

import UIKit

class ProfileDataFormViewController: UIViewController {
    
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.alwaysBounceVertical = true
        scroll.keyboardDismissMode = .onDrag
        scroll.translatesAutoresizingMaskIntoConstraints = true
        return scroll
    }()
    
    private let hintLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Fill in your data"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let displayNametextField: UITextField = {
        let textField = UITextField()
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .secondarySystemFill
        textField.keyboardType = .default
        textField.leftView = UIVisualEffectView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.layer.cornerRadius = 8
        textField.attributedText = NSAttributedString(string: "Display Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        return textField
    }()
    
    private let userNametextField: UITextField = {
        let textField = UITextField()
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .secondarySystemFill
        textField.keyboardType = .default
        textField.leftView = UIVisualEffectView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.layer.cornerRadius = 8
        textField.attributedPlaceholder = NSAttributedString(string: "User Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textField
    }()
    
    private let avatarPlaceHolderImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 60
        imageView.backgroundColor = .lightGray
        imageView.image = UIImage(systemName: "camera.fill")
        imageView.tintColor = .gray
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(hintLabel)
        scrollView.addSubview(avatarPlaceHolderImageView)
        scrollView.addSubview(displayNametextField)
        scrollView.addSubview(userNametextField)
        
        addConstraints()
        isModalInPresentation = true
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.frame = view.bounds
        
    }

}
extension ProfileDataFormViewController {
    func addConstraints() {
        NSLayoutConstraint.activate([
        
            hintLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            hintLabel.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 30),
            
            avatarPlaceHolderImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            avatarPlaceHolderImageView.heightAnchor.constraint(equalToConstant: 120),
            avatarPlaceHolderImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarPlaceHolderImageView.topAnchor.constraint(equalTo: hintLabel.bottomAnchor,constant: 30),
            
            displayNametextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            displayNametextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            displayNametextField.topAnchor.constraint(equalTo: avatarPlaceHolderImageView.bottomAnchor,constant: 40),
            displayNametextField.heightAnchor.constraint(equalToConstant: 50),
            
            userNametextField.leadingAnchor.constraint(equalTo: displayNametextField.leadingAnchor),
            userNametextField.trailingAnchor.constraint(equalTo: displayNametextField.trailingAnchor),
            userNametextField.topAnchor.constraint(equalTo: displayNametextField.bottomAnchor,constant: 20),
            userNametextField.heightAnchor.constraint(equalToConstant: 50),


        ]
        )
    }
}
