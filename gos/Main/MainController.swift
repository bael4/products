//
//  MainController.swift
//  gos
//
//  Created by Баэль Рыспеков on 25/4/23.
//

import Foundation


class MainController {
    private weak var view: ViewController!
    
    private var model: MainModel?
    
    init(view: ViewController) {
        self.view = view
        self.model = MainModel(controller: self)
    }
    
    func fetchProducts() {
        model?.fetchProducts()
    }
    
    func getProducts() -> [Product] {
        let products = model?.getProducts()
        return products!
    }
    
    func collectionViewReloaded() {
        view.reloadProductsCollectionView()
    }
    
    func serch (text: String) {
        model?.search(searchingText: text )
    }
    
    func dataToSave(index: Int) {
        model?.saveProduct(by: index)
    }
//    
//    func removeData(index: Int) {
//        model?.removeProduct(by: index)
//    }
    

}
