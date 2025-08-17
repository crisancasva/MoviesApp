//
//  UserRepository.swift
//  MoviesApp
//
//  Created by Cristhian Andres Castano Vallejo on 15/08/25.
//

import Foundation
import CoreData

class UserRepository {
    
    // Crear un usuario
    func createUser(username: String, password: String) -> Bool {
        if searchUser(username: username) != nil {
            print("Usuario ya existe")
            return false
        }
        
        let newUser = User(context: CoreDataManager.shared.context)
        newUser.username = username
        newUser.password = password
        CoreDataManager.shared.saveContext()
        return true
    }
    
    // Buscar un usuario por username
    func searchUser(username: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "username == %@", username)
        
        do {
            let result = try CoreDataManager.shared.context.fetch(request)
            return result.first
        } catch {
            print("Error buscando usuario: \(error)")
            return nil
        }
    }
    
   
    func checkLogin(username: String, password: String) -> Bool {
        if let user = searchUser(username: username) {
            return user.password == password
        }
        return false
    }
}
