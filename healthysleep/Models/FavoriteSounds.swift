//
//  Favorites.swift
//  healthysleep
//
//  Created by Mac on 27/06/2021.
//

import Foundation

class FavoriteSounds {
    
    static let shared = FavoriteSounds()
    private let cacheName = "favorite-sound"
    private(set) var favoriteSounds = [String]()
   
    
    init() {
        readData()
    }
    
    private func readData() {
        guard let data =  UserDefaults.standard.array(forKey: cacheName), let favorites = data as? [String] else {
            return
        }
        favoriteSounds = favorites
    }
    
    func add(nameKey: String, completion: @escaping (Bool) -> Void) {
        if favoriteSounds.contains(nameKey) {
            completion(true)
            return
        } else {
            favoriteSounds.append(nameKey)
            UserDefaults.standard.setValue(favoriteSounds, forKey: cacheName)
            completion(true)
            return
        }
        
    }
    
    func delete(nameKey: String, completion: @escaping (Bool) -> Void) {
        if let index = favoriteSounds.firstIndex(of: nameKey) {
            favoriteSounds.remove(at: index)
            UserDefaults.standard.setValue(favoriteSounds, forKey: cacheName)
            completion(true)
            return
        } else {
            completion(true)
            return
        }
    }
    
    func has(with soundName :  String) -> Bool {
        return favoriteSounds.contains(soundName)
    }
    
    func reload () {
        readData()
    }
    
}