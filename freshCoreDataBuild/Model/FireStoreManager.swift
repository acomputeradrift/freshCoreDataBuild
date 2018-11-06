//
//  FireStoreManager.swift
//  freshCoreDataBuild
//
//  Created by Jamie on 2018-11-06.
//  Copyright © 2018 Jamie. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class FireStoreManager {
    
    private init(){}
    static let shared = FireStoreManager()
    
    let categoryRef = Firestore.firestore().collection("Categories")
    
    func configure() {
        FirebaseApp.configure()
    }
    
    func create(){
        
    }
    func read(){
        
    }
    func update(){
        
    }
    func delete(){
        
    }
}
