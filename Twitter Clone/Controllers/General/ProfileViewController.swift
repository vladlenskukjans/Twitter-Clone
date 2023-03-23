//
//  ProfileViewController.swift
//  Twitter Clone
//
//  Created by Vladlens Kukjans on 22/03/2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    
    private var isStatusBarHidden: Bool = true
    
    
    private let statusBar: UIView = {
        let statusBar = UIView()
        statusBar.translatesAutoresizingMaskIntoConstraints = false
        statusBar.backgroundColor = .systemBackground
        statusBar.layer.opacity = 0
        return statusBar
    }()
    

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
        let headerView = ProfileTableViewHeader(frame: CGRect(x: 0, y: 0, width: profileTableView.frame.width, height: 390))
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        view.addSubview(profileTableView)
        view.addSubview(statusBar)
       
        
        profileTableView.tableHeaderView = headerView
        profileTableView.contentInsetAdjustmentBehavior = .never
        navigationController?.navigationBar.isHidden = true
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPosition = scrollView.contentOffset.y
        
        if yPosition > 150 && isStatusBarHidden {
            isStatusBarHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.statusBar.layer.opacity = 1
            } completion: { _ in }
            
            
        } else if yPosition < 0 && !isStatusBarHidden {
            isStatusBarHidden = true
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.statusBar.layer.opacity = 0
            } completion: { _ in }
        }
    }
}

extension ProfileViewController {
    func addConstraints() {
        NSLayoutConstraint.activate([
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            statusBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBar.topAnchor.constraint(equalTo: view.topAnchor),
            statusBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBar.heightAnchor.constraint(equalToConstant: view.bounds.height > 800 ? 40 : 20),
            
           
        ])
    }
}
