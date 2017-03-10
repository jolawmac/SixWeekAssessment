//
//  NameController.swift
//  SixWeeksChallenge
//
//  Created by Josh "Stud Muffin" McDonald on 3/10/17.
//  Copyright © 2017 Josh McDonald. All rights reserved.
//

import Foundation
import CoreData

class NameController {
    
    // MARK: - Properties
    
    static let sharedController = NameController()
    
    var names: [Name] {
        let request: NSFetchRequest<Name> = Name.fetchRequest()
        let moc = CoreDataStack.context
        do {
            let result = try moc.fetch(request)
            return result
        } catch {
            return []
        }
    }
    
    var sections: Int {
        let count = names.count / 2
        return names.count % 2 == 0 ? count : count + 1
    }
    
    let namesPerSection = 2
    
    // Mark: - Crud Functions
    
    func addNames(name: String) -> Name {
        let newPerson = Name(name: name)
        saveToPersistentStorage()
        return newPerson
    }
    
    func deleteNames(name: Name) {
        let moc = CoreDataStack.context
        moc.delete(name)
        saveToPersistentStorage()
    }
    
    func saveToPersistentStorage() {
        do {
            try CoreDataStack.context.save()
        } catch {
            NSLog("Error saving to core data \(error)")
        }
        
    }
    
}

// MARK: - Extention on Array that shuffles names in sections

extension Array {
    mutating func randomizer() {
        for index in stride(from: count - 1 , through: 1, by: -1) {
            let random = Int(arc4random_uniform(UInt32(index+1)))
            if index != random {
                swap(&self[index], &self[random])
            }
        }
    }
}
