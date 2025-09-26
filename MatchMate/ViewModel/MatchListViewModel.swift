//
//  MatchListViewModel.swift
//  MatchMate
//
//  Created by Prakash on 25/09/25.
//

import SwiftUI

@Observable
class MatchListViewModel{
    var usersList : [User] = []
    var isLoading : Bool = false // responsible to show loader at center of the page at inital loading
    var isPaginationLoading = false // responsible to show loader at the end of the list for pagination
    var errorMessage: String? = nil
    var showError = false
    
    //MARK: Network/LocalDB operation
    // Inital function to decide either load data from Local database or network call
    func loadInitialData()async {
        // First try to load data from local DB
        usersList = UserLocalData.shared.loadUsersFromCoreData()
        
        if usersList.isEmpty {
            // Network call if data is not present in local db
            await fetchUsersData()
        }
    }
    
    func fetchUsersData(isPagination : Bool = false)async{
        // When pagination is enable no need to show loader at full screen
        if isPagination {
            isLoading = false
            isPaginationLoading = true
        }else {
            isLoading = true
            isPaginationLoading = true
        }
        
        
        do {
            let data = try await NetworkService.shared.getUsersList()
            // update data on main thread
            DispatchQueue.main.async {[weak self] in
                guard let self else {return}
                usersList.append(contentsOf: processUserData(for: data))
                isPaginationLoading = false
                isLoading = false
            }
            
        }catch {
            // show respective network error message
            if let networkError = error as? NetworkError {
                errorMessage = networkError.errorDescription
                isPaginationLoading = false // disable pagination in case of error so that user can re-try
            } else {
                errorMessage = NetworkError.unknownError.errorDescription
                isPaginationLoading = false // disable pagination in case of error so that user can re-try
            }
            showError = true
        }
    }
    
    // func processUserData to convert Api response RandomUserModel to [User] model
    func processUserData(for data : RandomUserResponseModel) -> [User] {
        var userData : [User] = []
        data.results.forEach { item in
            userData.append(User(id : UUID().uuidString, fullName: item.nameToDisplay, address: item.locationToDisplay, imageUrlStr: item.picture.large))
        }
        UserLocalData.shared.saveUsersToCoreData(userData) // save new data in local db
        return userData
    }
    
    //MARK: User button action
    // func handleUserAction responsible to update the match status in local variable and local db
    func handleUserAction(user: User, status: MatchStatus) {
        UserLocalData.shared.updateUserStatus(userId: user.id, status: status.rawValue) // update data in local db
        
        if let index = usersList.firstIndex(where: { $0.id == user.id }) {
            usersList[index].matchStatus = status // update data in local variable to update UI
        }
    }

   
}
