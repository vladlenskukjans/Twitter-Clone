//
//  HomeViewViewModel.swift
//  Twitter Clone
//
//  Created by Vladlens Kukjans on 26/03/2023.
//

import Foundation
import Combine
import FirebaseAuth

final class HomViewViewModel: ObservableObject {
    
    @Published var user: TwitterUser?
    @Published var error: String?
    @Published var tweets: [Tweet] = []
    
    private var subscriptions: Set<AnyCancellable> = []

    
    func retreiveUser() {
        guard let id = Auth.auth().currentUser?.uid else {return}
        DatabaseManager.shared.collectionUser(retreive: id)
            .handleEvents(receiveOutput: { [weak self] users in
                self?.user = users
                self?.fetchTweets()
            })
            .sink { [weak self] complition in
                if case .failure(let error) = complition {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &subscriptions)
    }
    
    func fetchTweets() {
        guard let userID = user?.id else {return}
        DatabaseManager.shared.collectionTweets(retreiveTweet: userID)
            .sink { [weak self] complition in
                if case .failure(let error) = complition {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] retreivedtweets in
                self?.tweets = retreivedtweets
            }
            .store(in: &subscriptions)
    }
    
}
