//
//  File.swift
//  gos
//
//  Created by Баэль Рыспеков on 29/4/23.
//

import Foundation



class FavouriteModel {
    private weak var controller: FavouriteController!
    
    private var userDefaults = UserDefaults.standard
    
    private  var products: [Product] = []
    
    init(controller: FavouriteController) {
        self.controller = controller
    }
 
    
    func remove (by index: Int) {
        if let favourites = userDefaults.object(forKey: "favourites") as? Data  {
            let savedFavourites = try? JSONDecoder().decode([Product].self, from: favourites)
            products = savedFavourites!
        }
        
        if products.indices.contains(index) {
            products.remove(at: index)
            let encodedData = try? JSONEncoder().encode(products)
            userDefaults.set(encodedData, forKey: "favourites")
        }
      
        
    }
    
}
