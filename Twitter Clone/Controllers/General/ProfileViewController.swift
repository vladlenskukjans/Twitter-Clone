//
//  ProfileViewController.swift
//  Twitter Clone
//
//  Created by Vladlens Kukjans on 22/03/2023.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileTableView: UITableView = {
        let table = UITableView()
        table.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = .systemBackground
        navigationItem.title = "Profile"
        
        let headerView = ProfileTableViewHeader(frame: CGRect(x: 0, y: 0, width: profileTableView.frame.width, height: 380))
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        view.addSubview(profileTableView)
        profileTableView.tableHeaderView = headerView
        addConstraints()
       
        
    }
 
    
}
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else { return UITableViewCell() }
        return cell
    }
}

extension ProfileViewController {
    func addConstraints() {
        NSLayoutConstraint.activate([
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
