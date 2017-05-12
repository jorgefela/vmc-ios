//
//  ProfileLocalDataManager.swift
//
//  Created by Hispanos Soluciones on 08/01/17.
//  Copyright © 2017 Hispanos Soluciones C.A. All rights reserved.
//

import Foundation
import RealmSwift

class ProfileLocalDataManager: NSObject {
    
    //TODO: Implement methods to save/read info from local database here (such as Realm)
    //TODO: Methods related to User, Profile, CompanyProfile and similar entities can be implemented here
    
    func saveProfile(_ profile: UserProfile) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(profile, update: true)
        }
    }
    
    
}
