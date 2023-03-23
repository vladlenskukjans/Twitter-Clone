//
//  HomeViewController.swift
//  Twitter Clone
//
//  Created by Vladlens Kukjans on 22/03/2023.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    private func configureNavigationBar() {
        let size: CGFloat = 50
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.image = UIImage(named: "logo")
        
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
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timelineTableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        if Auth.auth().currentUser == nil {
            let vc = UINavigationController(rootViewController: OnboardingViewController())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
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
