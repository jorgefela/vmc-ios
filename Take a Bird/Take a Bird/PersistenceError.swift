//
//  PersistenceError.swift
//  Take a Bird
//
//  Created by macbook3 on 9/5/17.
//  Copyright © 2017 Hispano Soluciones, C.A. All rights reserved.
//

import Foundation

enum PersistenceError: Error {
    case managedObjectContextNotFound
    case couldNotSaveObject
    case objectNotFound
}
