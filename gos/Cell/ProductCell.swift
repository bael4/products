//
//  ProductCell.swift
//  gos
//
//  Created by Баэль Рыспеков on 25/4/23.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

protocol ProductActions: AnyObject {
    func favouriteTap(index: Int)
}

class ProductCell: UICollectionViewCell {
    
    static var reuseId = "product_cell"
    
    weak var delegate: ProductActions?
    
    var indexPath: IndexPath?
    
    var isFavourite: Bool = false
    
    let defaults = UserDefaults.standard

    
    private lazy var productImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var productTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.textColor = .black
        view.numberOfLines = 2
        return view
    }()
    
    private lazy var productDescriptionLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let view = UILabel()
        view.textColor = .blue
        view.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return view
    }()
    
    private lazy var favouriteImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "heart")
        view.isUserInteractionEnabled = true
        view.tintColor = .red
        let tap = UITapGestureRecognizer(target: self, action: #selector(favouriteTapped))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 5
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func favouriteTapped() {
        favouriteImageView.image = UIImage(systemName: "heart.fill")
        delegate?.favouriteTap(index: indexPath!.row)
        defaults.set(isFavourite, forKey: "isFavourite")
    }
       
    
    func fill(product: Product) {
        productImageView.kf.setImage(with: URL(string: product.thumbnail))
        productTitleLabel.text = product.title
        productPriceLabel.text = "\(product.price) $"
    }

    
    private func setupSubviews() {
        addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        addSubview(favouriteImageView)
        favouriteImageView.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.height.equalTo(24)
        }
      
        
        addSubview(productTitleLabel)
        productTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(productImageView.snp.bottom).offset(10)
            make.right.equalTo(favouriteImageView.snp.left).offset(-10)
            make.height.equalTo(44)
            
        }
        
        addSubview(productPriceLabel)
        productPriceLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.top.equalTo(productTitleLabel.snp.bottom).offset(5)
        }
    }
}
