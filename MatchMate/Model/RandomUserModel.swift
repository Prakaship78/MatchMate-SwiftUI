//
//  Untitled.swift
//  MatchMate
//
//  Created by Prakash on 25/09/25.
//

// All the struct responsible to map data from api response
struct RandomUserResponseModel : Decodable {
    let results : [RandomUserModel]
}

struct RandomUserModel : Decodable {
    
    let name : UserNameModel
    let picture : PictureModel
    let location : LocationModel
    
    //computed property to create a name which needs to be shown at view
    var nameToDisplay : String {
        name.first + " " + name.last
    }
    // computed property to create location which needs to be shown at view
    var locationToDisplay : String {
        "\(location.street.number)" + ", " + location.street.name + ", " + location.city
    }
    
}

struct UserNameModel : Decodable {
    let first : String
    let last : String
}

struct PictureModel : Decodable {
    let large : String
}

struct LocationModel : Decodable {
    let street : StreetModel
    let city : String
}

struct StreetModel : Decodable {
    let number : Int
    let name : String
}

