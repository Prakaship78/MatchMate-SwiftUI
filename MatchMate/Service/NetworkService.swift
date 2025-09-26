//
//  NetwrokService.swift
//  MatchMate
//
//  Created by Prakash on 25/09/25.
//

import Foundation

enum NetworkError : String, Error {
    case noInternet
    case invalidURL
    case invalidResponse
    case invalidData
    case unknownError
    
    var errorDescription : String {
        switch self {
        case .noInternet:
            "Please check your internet connection."
        case .invalidURL:
            "Url is not valid"
        case .invalidResponse:
            "Error connecting to server. Please try again later!"
        case .invalidData:
            "Error parsing the data. Please try again later!"
        case .unknownError:
            "Something went wrong"
        }
    }
}

// Network class responsible for api call
final class NetworkService {
    static let shared = NetworkService()
    
    // func getUsersList to fetch list of users
    // by default offset value is 10 , can be changed at function call side
    func getUsersList(offset : Int = 10) async throws -> RandomUserResponseModel {
        let urlString = "\(ApiConstant.baseUrl)?results=\(offset)"
        guard let url = URL(string:urlString,) else {throw NetworkError.invalidURL}
        
        do {
            let (data,response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {throw NetworkError.invalidResponse}
            
            do {
                let decoder = JSONDecoder()
                let usersData = try decoder.decode(RandomUserResponseModel.self, from: data)
                return usersData
            }catch {
                throw NetworkError.invalidData
            }
            
        }
        catch let networkError as URLError where networkError.code == .notConnectedToInternet {
            throw NetworkError.noInternet
        }
        catch {
            throw NetworkError.unknownError
        }
    }
    
    
}
