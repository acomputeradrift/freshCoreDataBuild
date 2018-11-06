//
//  FIRFireStoreManager.swift
//  freshCoreDataBuild
//
//  Created by Jamie on 2018-11-06.
//  Copyright © 2018 Jamie. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class FIRFireStoreManager {
    
    private init(){}
    static let shared = FIRFireStoreManager()
    
    let categoryRef = Firestore.firestore().collection("Categories")
    
//    func configure() {
//        FirebaseApp.configure()
//    }
    
    func create(categoryName: String){
        categoryRef.addDocument(data: ["name" : "\(categoryName)"])
    }
    
    func read() {
        categoryRef.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            for document in snapshot.documents{
                 print(document.data())
            }
        }
    }
    func update(){
        
    }
    func delete(){
        
    }
}
