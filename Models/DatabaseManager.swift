//
//  DatabaseManager.swift
//  Twitter Clone
//
//  Created by Vladlens Kukjans on 26/03/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift
import Combine

class DatabaseManager {
    
    static let shared = DatabaseManager()
    init() {}
    
    let db = Firestore.firestore()
    let usersPath: String = "users"
    let tweetsPath: String = "tweets"
    
    func collectionUsers(add user: User) -> AnyPublisher<Bool, Error> {
        let twitterUser = TwitterUser(from: user)
        return db.collection(usersPath).document(twitterUser.id).setData(from: twitterUser)
            .map { _ in
                return true
            }
            .eraseToAnyPublisher()
    }
    
    
    func collectionUser(retreive id: String) -> AnyPublisher<TwitterUser, Error> {
        db.collection(usersPath).document(id).getDocument()
            .tryMap { try $0.data(as: TwitterUser.self) }
        
            .eraseToAnyPublisher()
    }
    
    func collectionUsers(updateFields: [String: Any], for id: String) -> AnyPublisher<Bool, Error> {
        db.collection(usersPath).document(id).updateData(updateFields)
            .map { _ in true }
            .eraseToAnyPublisher()
    }
    
    func collectionTweets(dispatch tweet: Tweet) -> AnyPublisher<Bool, Error> {
        db.collection(tweetsPath).document(tweet.id).setData(from: tweet)
            .map { _ in true }
            .eraseToAnyPublisher()
    }
    
    func collectionTweets(retreiveTweet forUserId: String) -> AnyPublisher<[Tweet], Error> {
        db.collection(tweetsPath).whereField("authorId", isEqualTo: forUserId)
            .getDocuments()
            .tryMap(\.documents)
            .tryMap { snapshots in
                try snapshots.map({
                  try  $0.data(as: Tweet.self) })
        }
            .eraseToAnyPublisher()
    }
}
