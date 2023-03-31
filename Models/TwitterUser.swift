//
//  TwitterUser.swift
//  Twitter Clone
//
//  Created by Vladlens Kukjans on 26/03/2023.
//

import Foundation
import Firebase

struct TwitterUser: Codable {
    let id: String
    var displayname: String = ""
    var userName: String = ""
    var followingCount: Int = 0
    var followersCount: Int = 0
    var createdOn: Date = Date()
    var bio: String = ""
    var avatarPath: String = ""
    var isUserOnboarded: Bool = false
  
    init(from user: User) {
        self.id = user.uid
    }
    
}
