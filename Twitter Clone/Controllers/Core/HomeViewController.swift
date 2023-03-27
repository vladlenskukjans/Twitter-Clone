//
//  HomeViewController.swift
//  Twitter Clone
//
//  Created by Vladlens Kukjans on 22/03/2023.
//

import UIKit
import FirebaseAuth
import Combine

class HomeViewController: UIViewController {

    private var viewModel = HomViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    private func configureNavigationBar() {
        let size: CGFloat = 50
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.image = UIImage(named: "twitter")
        
        let middleView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        middleView.addSubview(logoImageView)
        navigationItem.titleView = middleView
        
        let profileImage = UIImage(systemName: "person")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: profileImage, style: .plain, target: self, action: #selector(didTapProfile))
    }
        
    @objc func didTapProfile() {
   let profileVc = ProfileViewController()
        navigationController?.pushViewController(profileVc, animated: true)
}
    
    
    private let timelineTableView: UITableView = {
         let table = UITableView()
        table.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        return table
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.addSubview(timelineTableView)
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
        configureNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(didTapSingOut))
        bindViews()
    }
    
    func completeUserOnboarding() {
        let vc = ProfileDataFormViewController()
        present(vc, animated: true)
    }
    
    func bindViews() {
        viewModel.$user.sink { [weak self] user in
            guard let user = user else {return}
            if !user.isUserOnboarded {
                self?.completeUserOnboarding()
                print("complition onbord")
            }
        }
        .store(in: &subscriptions)
    }
    
    
    @objc private func didTapSingOut() {
      try? Auth.auth().signOut()
        heandleAuthentication()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timelineTableView.frame = view.bounds
    }
    
    private func heandleAuthentication() {
        if Auth.auth().currentUser == nil {
            let vc = UINavigationController(rootViewController: OnboardingViewController())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
       heandleAuthentication()
        viewModel.retreiveUser()
    }
    
    }
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else {return UITableViewCell()}
        cell.delegate = self
        return cell
    }
    
    
    
}
extension HomeViewController: TweetTableViewCellDelegate {
    func tweetTableViewCellDidTapReply() {
        print("reply")
    }
    
    func tweetTableViewCellDidTapRetweet() {
       print("retweet")
    }
    
    func tweetTableViewCellDidTapLike() {
        print("like")
    }
    
    func tweetTableViewCellDidTapShare() {
        print("share")
    }
    
    
    
    
    
}
