//
//  MainModel.swift
//  gos
//
//  Created by Баэль Рыспеков on 25/4/23.
//

import Foundation
import UIKit
struct ProductResponse: Codable {
    var products: [Product]
}

struct Product: Codable {
    var id: Int
    var title: String
    var description: String
    var price: Int
    var thumbnail: String
}

class MainModel {
    private weak var controller: MainController!
    
    private var networkManager = NetworkManager()
    
    private var products: [Product] = []
    
    private var filteredProducts: [Product] = []
    
    private var searching:Bool = false
    
    init(controller: MainController) {
        self.controller = controller
    }
    
    func fetchProducts() {
        networkManager.fetchProducts { result in
            self.products = result.products
            self.controller.collectionViewReloaded()
        }
    }
    
    
    func search (searchingText: String) {
        if searchingText.isEmpty {
            searching = false
        }else {
            print("eroro")
            searching = true
            filteredProducts = products.filter { thing in
                return "\(thing.title.lowercased())".contains(searchingText.lowercased())
            }
            self.controller.collectionViewReloaded()
        }
    }
    
    
    func getProducts() -> [Product] {
        if searching {
            return filteredProducts
        }else {
            return products
        }
    }
   
    
    
}
