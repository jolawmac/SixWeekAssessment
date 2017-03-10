//
//  Name+Convenience.swift
//  SixWeeksChallenge
//
//  Created by Josh "Buff Stuff" McDonald on 3/10/17.
//  Copyright © 2017 Josh McDonald. All rights reserved.
//

import Foundation
import CoreData

extension Name {
    convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        }
}
