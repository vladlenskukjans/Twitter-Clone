//
//  ProfileDataFormViewController.swift
//  Twitter Clone
//
//  Created by Vladlens Kukjans on 26/03/2023.
//

import UIKit
import PhotosUI

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
        textField.attributedPlaceholder = NSAttributedString(string: "Display Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
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
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let bioTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .secondarySystemFill
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 8
        textView.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        textView.text = "Tell the world about your selft"
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = .gray
        textView.translatesAutoresizingMaskIntoConstraints = false
       return textView
    }()
    
   
    private let submitButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor =  UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(hintLabel)
        scrollView.addSubview(avatarPlaceHolderImageView)
        scrollView.addSubview(displayNametextField)
        scrollView.addSubview(userNametextField)
        scrollView.addSubview(bioTextView)
        scrollView.addSubview(submitButton)
        addConstraints()
        isModalInPresentation = true
        bioTextView.delegate = self
        displayNametextField.delegate = self
        userNametextField.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
        avatarPlaceHolderImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToUpload)))
    }
    
    @objc private func didTapToUpload() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
        
    }
    
    @objc private func didTapView() {
        view.endEditing(true)
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
            
            bioTextView.leadingAnchor.constraint(equalTo: displayNametextField.leadingAnchor),
            bioTextView.trailingAnchor.constraint(equalTo: displayNametextField.trailingAnchor),
            bioTextView.topAnchor.constraint(equalTo: userNametextField.bottomAnchor,constant: 20),
            bioTextView.heightAnchor.constraint(equalToConstant: 150),
            
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            submitButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor,constant: -20)
        ]
        )
    }
}
extension ProfileDataFormViewController: UITextViewDelegate, UITextFieldDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y - 100), animated: true)
        if textView.textColor == .gray {
            textView.textColor = .label
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        if textView.text.isEmpty {
            textView.text = "Tell the world about your selft"
            textView.textColor = .gray
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y - 100), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}

extension ProfileDataFormViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self?.avatarPlaceHolderImageView.image = image
                    }
                }
            }
        }
    }
}
