//
//  FavouriteController.swift
//  gos
//
//  Created by Баэль Рыспеков on 29/4/23.
//

import Foundation


class FavouriteController {
    private weak var view: FavouriteViewController!
    private var model: FavouriteModel?
    
    
    init(view: FavouriteViewController) {
        self.view = view
        self.model = FavouriteModel(controller: self)
    }
    
    func removeByIndex (by index: Int) {
        model?.remove(by: index)
    }
}
