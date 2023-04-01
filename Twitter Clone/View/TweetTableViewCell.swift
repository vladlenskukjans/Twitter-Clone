//
//  TweetTableViewCell.swift
//  Twitter Clone
//
//  Created by Vladlens Kukjans on 22/03/2023.
//

import UIKit

protocol TweetTableViewCellDelegate: AnyObject {
    func tweetTableViewCellDidTapReply()
    func tweetTableViewCellDidTapRetweet()
    func tweetTableViewCellDidTapLike()
    func tweetTableViewCellDidTapShare()
}

class TweetTableViewCell: UITableViewCell {
    
    static let identifier = "TweetTableViewCell"
    private let actionSpacing: CGFloat = 60
    
    weak var delegate: TweetTableViewCellDelegate?
    
    
    private let avatarImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person")
        imageView.backgroundColor = .systemRed
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let displayNamelabel: UILabel = {
       let label = UILabel()
        label.text = "Vladlen Kukjan"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userNameLabel: UILabel = {
       let label = UILabel()
        label.text = "@kukj"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tweetTextContentLabel: UILabel = {
       let label = UILabel()
        label.text = "This is mock test ,we testing how many lines we need to add in our table view, but lets add some more lines of code man "
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let replyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "replyicon"), for: .normal)
        button.tintColor = .systemGray2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "retweetLogo"), for: .normal)
        button.tintColor = .systemGray2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "heartLogo"), for: .normal)
        button.tintColor = .systemGray2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "shareLogo"), for: .normal)
        button.tintColor = .systemGray2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(displayNamelabel)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(tweetTextContentLabel)
        contentView.addSubview(retweetButton)
        contentView.addSubview(replyButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(shareButton)
        addConstraints()
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func didTapReply() {
        delegate?.tweetTableViewCellDidTapReply()
    }
    
    @objc func didTapRetweet() {
        delegate?.tweetTableViewCellDidTapRetweet()
    }
    
    @objc func didTapLike() {
        delegate?.tweetTableViewCellDidTapLike()
    }
    
    @objc func didTapShare() {
        delegate?.tweetTableViewCellDidTapShare()
    }
    
    
    private func configureButtons() {
        replyButton.addTarget(self, action: #selector(didTapReply), for: .touchUpInside)
        retweetButton.addTarget(self, action: #selector(didTapRetweet), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
    }
    
    func configureTweet(whit displayName: String, userName: String, tweetTextContent: String, avatarPath: String) {
        displayNamelabel.text = displayName
        userNameLabel.text = "@\(userName)"
        tweetTextContentLabel.text = tweetTextContent
        avatarImageView.sd_setImage(with: URL(string: avatarPath))
    }
    
    
}
extension TweetTableViewCell {
    func addConstraints() {
        NSLayoutConstraint.activate([
        
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
        
            displayNamelabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            displayNamelabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            userNameLabel.leadingAnchor.constraint(equalTo: displayNamelabel.trailingAnchor, constant: 10),
            userNameLabel.centerYAnchor.constraint(equalTo: displayNamelabel.centerYAnchor),
            
            tweetTextContentLabel.leadingAnchor.constraint(equalTo: displayNamelabel.leadingAnchor),
            tweetTextContentLabel.topAnchor.constraint(equalTo: displayNamelabel.bottomAnchor, constant: 10),
            tweetTextContentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            replyButton.leadingAnchor.constraint(equalTo: tweetTextContentLabel.leadingAnchor),
            replyButton.topAnchor.constraint(equalTo: tweetTextContentLabel.bottomAnchor, constant: 10),
            replyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            retweetButton.leadingAnchor.constraint(equalTo: replyButton.trailingAnchor, constant: actionSpacing),
            retweetButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor),
            
            likeButton.leadingAnchor.constraint(equalTo: retweetButton.trailingAnchor, constant: actionSpacing),
            likeButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor),
            
            shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: actionSpacing),
            shareButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor)
            
            
        ])
    }
}
