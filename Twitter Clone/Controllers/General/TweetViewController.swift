//
//  TweetViewController.swift
//  Twitter Clone
//
//  Created by Vladlens Kukjans on 31/03/2023.
//

import UIKit
import Combine

class TweetViewController: UIViewController, UITextViewDelegate {
    
    private let viewModel = TweetViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
  
    lazy var tweetButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: UIAction { [weak self] _ in
            self?.viewModel.dispatchTweet()
            print("tweet button was pressed, and tweet was send to Firebase")
        })
       // let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .twitterBlueColor
        button.layer.cornerRadius = 20
        button.isEnabled = false
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white.withAlphaComponent(0.6), for: .disabled)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.setTitle("Tweet", for: .normal)
        return button
    }()
    
    private let tweetContentTextView: UITextView = {
        let textView = UITextView()
        //textView.backgroundColor = .secondarySystemFill
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 8
        textView.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        textView.text = "What's happening?"
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = .gray
        textView.translatesAutoresizingMaskIntoConstraints = false
       return textView
    }()
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Tweet"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(didTapToCancel))
        tweetContentTextView.delegate = self
        
        view.addSubview(tweetButton)
        view.addSubview(tweetContentTextView)
       setConstraints()
        bindViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUserData()
    }
        
    private func bindViews() {
        viewModel.$isValidToTweet.sink { [weak self] state in
            self?.tweetButton.isEnabled = state
        }
        .store(in: &subscriptions)
        
        viewModel.$shouldDismissCompouser.sink { [weak self] success in
            if success {
                self?.dismiss(animated: true)
            }
        }.store(in: &subscriptions)
    }
    
    
    @objc func didTapToCancel() {
        dismiss(animated: true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray {
            textView.textColor = .label
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What's happening?"
            textView.textColor = .gray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.tweetContent = textView.text
        viewModel.validateToTweet()
    }
    
    
}
extension TweetViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            tweetButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor,constant: -10),
            tweetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tweetButton.widthAnchor.constraint(equalToConstant: 120),
            tweetButton.heightAnchor.constraint(equalToConstant: 40),
            
            tweetContentTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tweetContentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            tweetContentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            tweetContentTextView.bottomAnchor.constraint(equalTo: tweetButton.topAnchor,constant: -10),
            
    ])
    }
}
