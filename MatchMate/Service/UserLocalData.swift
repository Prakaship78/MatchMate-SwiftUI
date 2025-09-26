//
//  UsersRepository.swift
//  MatchMate
//
//  Created by Prakash on 26/09/25.
//

import CoreData

// Helper class to save, update, fetch data from local db
final class UserLocalData {
    let context = CoreDataManager.shared.context
    
    static let shared = UserLocalData()
    
    // Load users from core data
    func loadUsersFromCoreData() -> [User] {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        do {
            let savedUsers = try context.fetch(fetchRequest)
            return savedUsers.map { entity in
                User(id : entity.id ?? UUID().uuidString,fullName: entity.fullName ?? "", address: entity.address ?? "", imageUrlStr: entity.imageUrlStr ?? "", matchStatus: MatchStatus(rawValue: entity.status ?? "") ?? .none)
            }
        } catch {
            print("Failed to fetch users: \(error.localizedDescription)")
            return []
        }
    }
    
    // save data to core data
    func saveUsersToCoreData(_ users: [User]) {
        let context = CoreDataManager.shared.context
        
        for user in users {
            // Check if user already exists
            let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", user.id)
            
            if let existing = try? context.fetch(fetchRequest), existing.isEmpty == false {
                continue
            }
            
            let newUser = UserEntity(context: context)
            newUser.id = user.id
            newUser.fullName = user.fullName
            newUser.address = user.address
            newUser.imageUrlStr = user.imageUrlStr
            newUser.status = "" // default
        }
        
        CoreDataManager.shared.save()
    }
    
    // Update user data
    func updateUserStatus(userId: String, status: String) {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", userId)
        
        if let users = try? context.fetch(fetchRequest), let user = users.first {
            user.status = status
            CoreDataManager.shared.save()
        }
    }
}
