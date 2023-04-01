//
//  TweetViewViewModel.swift
//  Twitter Clone
//
//  Created by Vladlens Kukjans on 31/03/2023.
//

import Foundation
import Combine
import FirebaseAuth

final class TweetViewViewModel: ObservableObject {
    
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var isValidToTweet: Bool = false
    @Published var error: String = ""
    @Published var shouldDismissCompouser: Bool = false
    private var user: TwitterUser?
    var tweetContent: String = ""
    
    
    
    func getUserData() {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        DatabaseManager.shared.collectionUser(retreive: userID)
            .sink { [weak self] complition in
                if case .failure(let error) = complition {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] twitterUser in
                self?.user = twitterUser
            }
            .store(in: &subscriptions)
    }
    
    
    func validateToTweet() {
        isValidToTweet = !tweetContent.isEmpty
    }
    
    func dispatchTweet() {
        guard let user = user else {return}
        let tweet = Tweet(author: user, authorId: user.id, tweetContent: tweetContent, likeCount: 0, likers: [], isReply: false, parentReference: nil)
        DatabaseManager.shared.collectionTweets(dispatch: tweet)
            .sink { [weak self] complition in
                if case .failure(let error) = complition {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] state in
                self?.shouldDismissCompouser = state
            }
            .store(in: &subscriptions)
    }
}
