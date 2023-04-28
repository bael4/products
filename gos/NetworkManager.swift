//
//  NetworkManager.swift
//  gos
//
//  Created by Баэль Рыспеков on 25/4/23.
//

import Foundation

class NetworkManager {
    let session = URLSession.shared
    
    func fetchProducts(completion: @escaping (ProductResponse) -> ()) {
        let url = URL(string: "https://dummyjson.com/products")
        
        let request = URLRequest(url: url!)
        
        session.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            let statusCode = response as! HTTPURLResponse
            do {
                let result = try JSONDecoder().decode(ProductResponse.self, from: data)
//                print(result)
                completion(result)
                print(statusCode.statusCode)
//                print(result.products[0])
            } catch  {
                //completion(ProductResponse(products: []))
                print(error)
            }
        }
        .resume()
    }
    
}
