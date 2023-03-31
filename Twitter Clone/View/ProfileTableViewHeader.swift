//
//  ProfileTableViewHeader.swift
//  Twitter Clone
//
//  Created by Vladlens Kukjans on 23/03/2023.
//

import UIKit

class ProfileTableViewHeader: UIView {
    
    private enum SectionTabs: String {
        case tweet = "Tweets"
        case tweetAndReplies = "Tweets & Replies"
        case media = "Media"
        case likes = "Likes"
          
        var index: Int {
            switch self {
            case .tweet:
                return 0
            case .tweetAndReplies:
                return 1
            case .media:
                return 2
            case .likes:
                return 3
            }
        }
    }
    
  private var leadingAnchors: [NSLayoutConstraint] = []
  private  var trailingAnchors: [NSLayoutConstraint] = []
    
    
    
    private let indicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .twitterBlueColor
        return view
    }()
    
    
    private var selectedIndexTab: Int = 0 {
        didSet {
            for index in 0..<tabs.count {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
                    self?.sectionStack.arrangedSubviews[index].tintColor = index == self?.selectedIndexTab ? .label : .secondaryLabel
                    self?.leadingAnchors[index].isActive = index == self?.selectedIndexTab ? true : false
                    self?.trailingAnchors[index].isActive = index == self?.selectedIndexTab ? true : false
                    self?.layoutIfNeeded()
                } completion: { _ in
                    
                }
            }
        }
    }
    
    private var tabs: [UIButton] = ["Tweets", "Tweets & Replies", "Media", "Likes"].map { buttonTitle in
        let button = UIButton(type: .system)
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private lazy var sectionStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: tabs)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
 var followersTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Followers"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
 var followersCountLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.text = "1M"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
  var followingTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Following"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
   var followingCountLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.text = "345"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
  var joinedDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.text = "Joined March 2023"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14,weight: .regular)
        return label
    }()
    
 var joinDateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar",withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
        
   var userBioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .label
        label.text = "iOS Developer"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
   var userNameLabel: UILabel = {
        let lable = UILabel()
        lable.text = "@vladlenskukjans"
        lable.textColor = .secondaryLabel
        lable.font = .systemFont(ofSize: 18, weight: .regular)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
        
    var displayNameLabel: UILabel = {
        let lable = UILabel()
      //  lable.text = "Vladlens Kukjans"
        lable.font = .systemFont(ofSize: 22, weight: .bold)
        lable.textColor = .label
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
        
   var profileAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
       imageView.contentMode = .scaleAspectFill
       // imageView.image = UIImage(systemName: "person")
       // imageView.backgroundColor = .green
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
        addSubview(sectionStack)
        addSubview(indicator)
        
        addConstraints()
        configureStackButtons()
    }
    
    private func  configureStackButtons() {
        for (index ,button) in sectionStack.arrangedSubviews.enumerated() {
            guard let button = button as? UIButton else {return}
            
            if index == selectedIndexTab {
                button.tintColor = .label
            } else {
                button.tintColor = .secondaryLabel
            }
            
            button.addTarget(self, action: #selector(didTapTab), for: .touchUpInside)
        }
    }
    
    @objc private func didTapTab(_ sender: UIButton) {
        guard let label = sender.titleLabel?.text else {return}
        switch label {
        case SectionTabs.tweet.rawValue:
            selectedIndexTab = 0
        case SectionTabs.tweetAndReplies.rawValue:
            selectedIndexTab = 1
        case SectionTabs.media.rawValue:
            selectedIndexTab = 2
        case SectionTabs.likes.rawValue:
            selectedIndexTab = 3
        default:
            selectedIndexTab = 0
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}
extension ProfileTableViewHeader {
    func addConstraints() {
        
        for index in 0..<tabs.count {
            let leadingAnchor = indicator.leadingAnchor.constraint(equalTo: sectionStack.arrangedSubviews[index].leadingAnchor)
            leadingAnchors.append(leadingAnchor)
            let trailingAnchor = indicator.trailingAnchor.constraint(equalTo: sectionStack.arrangedSubviews[index].trailingAnchor)
            trailingAnchors.append(trailingAnchor)
        }
        
        
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
            
            sectionStack.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 25),
            sectionStack.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -25),
            sectionStack.topAnchor.constraint(equalTo: followingCountLabel.bottomAnchor,constant: 5),
            sectionStack.heightAnchor.constraint(equalToConstant: 35),
            
            // adding under button indicator
            leadingAnchors[0],
            trailingAnchors[0],
            indicator.topAnchor.constraint(equalTo: sectionStack.arrangedSubviews[0].bottomAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 4),

        ])
    }
}
