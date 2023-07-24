//
//  NetworkManager.swift
//  gos
//
//  Created by Баэль Рыспеков on 25/4/23.
//

import Foundation



enum Constans {
    enum URLPaths {
        static let baseURL = URL(
            string: "https://dummyjson.com/docs/products"
        )!
    }
}

struct NetworkService {

    let session = URLSession.shared
    let decoder = JSONDecoder()
 

    func fetchProducts(
        completion: @escaping (Result<[Product], Error>) -> Void )
    {
        let url = URL(string: "https://dummyjson.com/products")

        let request = URLRequest(url: url!)
        
        session.dataTask(with: request) { data, response, error in
            guard let data else {
                return
            }
            do {
                let data: ProductResponse = try decode(data: data)
                completion(
                    .success(
                        data.products
                    )
                )
            } catch {
                completion(
                    .failure(
                        error
                    )
                )
            }

        }.resume()
    }
    
    private func decode<T: Decodable>(data: Data) throws -> T {
      try  decoder.decode(
        T.self,
        from: data
      )
    }
}
