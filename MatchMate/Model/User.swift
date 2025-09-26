//
//  User.swift
//  MatchMate
//
//  Created by Prakash on 25/09/25.
//

import Foundation

// enum to handle user actions
enum MatchStatus : String, Codable{
    case accepted // user click on Tick mark
    case declined // user click on X mark
    case none // default case to show Tick/X mark
}

//responsible to show data in view
struct User : Identifiable {
    let id : String // to differentiate in ListView
    let fullName : String
    let address : String
    let imageUrlStr : String
    var matchStatus : MatchStatus = .none
}
