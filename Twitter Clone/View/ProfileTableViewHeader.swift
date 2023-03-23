//
//  ProfileTableViewHeader.swift
//  Twitter Clone
//
//  Created by Vladlens Kukjans on 23/03/2023.
//

import UIKit

class ProfileTableViewHeader: UIView {
    
    
    private let followersTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Followers"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let followersCountLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.text = "1M"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let followingTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Following"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let followingCountLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.text = "345"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let joinedDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.text = "Joined March 2023"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14,weight: .regular)
        return label
    }()
    
    private let joinDateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar",withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let userBioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .label
        label.text = "iOS Developer"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let userNameLabel: UILabel = {
        let lable = UILabel()
        lable.text = "@vladlenskukjans"
        lable.textColor = .secondaryLabel
        lable.font = .systemFont(ofSize: 18, weight: .regular)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    private let displayNameLabel: UILabel = {
        let lable = UILabel()
        lable.text = "Vladlens Kukjans"
        lable.font = .systemFont(ofSize: 22, weight: .bold)
        lable.textColor = .label
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    
    private let profileAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person")
        imageView.backgroundColor = .green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let profileHeaderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "header")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileHeaderImageView)
        addSubview(profileAvatarImageView)
        addSubview(displayNameLabel)
        addSubview(userNameLabel)
        addSubview(userBioLabel)
        addSubview(joinDateImageView)
        addSubview(joinedDateLabel)
        addSubview(followingCountLabel)
        addSubview(followingTextLabel)
        addSubview(followersCountLabel)
        addSubview(followersTextLabel)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
extension ProfileTableViewHeader {
    func addConstraints() {
        NSLayoutConstraint.activate([
            profileHeaderImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileHeaderImageView.topAnchor.constraint(equalTo: topAnchor),
            profileHeaderImageView.trailingAnchor.constraint(equalTo:trailingAnchor),
            profileHeaderImageView.heightAnchor.constraint(equalToConstant: 150),
            
            profileAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileAvatarImageView.centerYAnchor.constraint(equalTo: profileHeaderImageView.bottomAnchor,constant: 10),
            profileAvatarImageView.widthAnchor.constraint(equalToConstant: 80),
            profileAvatarImageView.heightAnchor.constraint(equalToConstant: 80),
            
            displayNameLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            displayNameLabel.topAnchor.constraint(equalTo: profileAvatarImageView.bottomAnchor, constant: 18),
            
            userNameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            userNameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 8),
            
            userBioLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            //userBioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            userBioLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            
            joinDateImageView.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            joinDateImageView.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor, constant: 8),
            
            joinedDateLabel.leadingAnchor.constraint(equalTo: joinDateImageView.trailingAnchor, constant: 2),
            joinedDateLabel.centerYAnchor.constraint(equalTo: joinDateImageView.centerYAnchor),
            
            followingCountLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            followingCountLabel.topAnchor.constraint(equalTo: joinedDateLabel.bottomAnchor, constant: 10),
            
            followingTextLabel.leadingAnchor.constraint(equalTo: followingCountLabel.trailingAnchor, constant: 4),
            followingTextLabel.bottomAnchor.constraint(equalTo: followingCountLabel.bottomAnchor),
            
            followersCountLabel.leadingAnchor.constraint(equalTo: followingTextLabel.trailingAnchor,constant: 8),
            followersCountLabel.bottomAnchor.constraint(equalTo: followingCountLabel.bottomAnchor),
            
            followersTextLabel.leadingAnchor.constraint(equalTo: followersCountLabel.trailingAnchor,constant: 4),
            followersTextLabel.bottomAnchor.constraint(equalTo: followingCountLabel.bottomAnchor),
            
            
            

        ])
    }
}
