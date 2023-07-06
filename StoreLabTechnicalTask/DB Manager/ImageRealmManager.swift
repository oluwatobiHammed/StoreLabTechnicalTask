//
//  MovieRealmManager.swift
//  MovieExplorer
//
//  Created by Oluwatobi Oladipupo on 09/06/2023.
//

import Foundation
import  RealmSwift

class ImageRealmManager {
    
    static let shared = ImageRealmManager()
    static let SCHEMA_VERSION: UInt64 = 12
    
    lazy var config: Realm.Configuration = {
        let config = Realm.Configuration(schemaVersion: ImageRealmManager.SCHEMA_VERSION, deleteRealmIfMigrationNeeded: true)
        return config
    }()
    
    
    lazy var realm = try? Realm(configuration: config)
    
    func deleteDatabase() {
        try? realm?.write({
            realm?.deleteAll()
        })
    }
    
    func deleteObject(realmObject : Object, isCascading: Bool = false) {
        try? realm?.write ({
            guard !realmObject.isInvalidated else { return }
            realm?.delete(realmObject)
        })
    }
    
    func updateOrSave(realmObject: [Object]) {
        try? realm?.write ({
            //guard !realmObject.isInvalidated else { return }
            realm?.add(realmObject, update: .all)
        })
    }
    
    func fetchObjects(type: Object.Type) -> Results<Object>? {
        return realm?.objects(type)
    }
    
    func fetchOverviewActivities(id: Bool) -> [ImageModel]? {
        
        let checkInExPredicate = NSPredicate(format: "key != %@", id)
        let predicateAnd = NSCompoundPredicate(type: .and, subpredicates: [checkInExPredicate])
        if let result = fetchObjects(type: ImageModel.self, withPredicate: predicateAnd), !result.isInvalidated {
            return (Array(result) as? [ImageModel])
        }
        return nil
        
    }

    func fetchObjects(type: Object.Type, withPredicate predicate: NSPredicate? = nil) -> Results<Object>? {
        if let predicate = predicate {
            return realm?.objects(type).filter(predicate)
        } else {
            return realm?.objects(type)
        }
    }
    
    func clearImages() {
        DispatchQueue.main.async { [self] in
            clearObject(type: ImageModel.self, isCascading: false)
        }
    }
    
    func clearFavoriteImages() {
        DispatchQueue.main.async { [self] in
            clearObject(type: ImageModel.self, isCascading: false)
        }
    }
    
    func clearObject(type: Object.Type, isCascading: Bool = false) {
        try? realm?.write ({
            if let result = realm?.objects(type.self) {
                guard !result.isInvalidated || result.first != nil else { return }
                realm?.delete(result)
            }
        })
    }
    
}


extension ImageRealmManager {
    
    
    var images : [ImageModel]? {
        
        let result = fetchObjects(type: ImageModel.self)
        if let result, !result.isInvalidated,  result.count > 0 {
            return Array(result)  as? [ImageModel]
        }
        return nil
        
    }
    

}
