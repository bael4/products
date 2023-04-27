//
//  FavouriteViewController.swift
//  gos
//
//  Created by Баэль Рыспеков on 25/4/23.
//

import Foundation
import UIKit
import SnapKit

class FavouriteViewController: UIViewController {
    
    private let userDefaults = UserDefaults.standard
    
    private lazy var favouritesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseId)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .cyan
        return view
    }()
    
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let favourites = userDefaults.object(forKey: "favourites") as? Data  {
            let savedFavourites = try? JSONDecoder().decode([Product].self, from: favourites)
            print(savedFavourites!)
            products = savedFavourites!
            DispatchQueue.main.async {
                self.favouritesCollectionView.reloadData()
            }
        }
       
    }
    
    func setupSubViews () {
        view.addSubview(favouritesCollectionView)
        
        favouritesCollectionView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
//            favouritesCollectionView.reloadData()
        }
    }
}


extension FavouriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell
//        cell.delegate = self
        cell.indexPath = indexPath
        cell.fill(product: (products[indexPath.row]))
        return cell
    }
}

extension FavouriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 20, height: 290)
    }
}
        

