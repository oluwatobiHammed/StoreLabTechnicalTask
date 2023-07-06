//
//  UserManager.swift
//  MovieExplorer
//
//  Created by Oluwatobi Oladipupo on 12/06/2023.
//

import Foundation

class UserManager {
    func setLikedImage(_ imageId: [String]) {
        let encodedData = try? JSONEncoder().encode(imageId)
        UserDefaults.standard.set(encodedData, forKey: "addFavoiteImage")
        
    }


    func readLikedImage() ->  [String] {
        guard let savedData = UserDefaults.standard.object(forKey:  "addFavoiteImage") as? Data, let liked = try? [String].decode(data: savedData) else { return []}
        
        return liked
    }
}
