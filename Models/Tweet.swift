//
//  Tweet.swift
//  Twitter Clone
//
//  Created by Vladlens Kukjans on 31/03/2023.
//

import Foundation

struct Tweet: Codable, Identifiable {
    var id = UUID().uuidString
    let author: TwitterUser
    let tweetContent: String
    var likeCount: Int
    var likers: [String]
    let isReply: Bool
    let parentReference: String?
    
    
}
