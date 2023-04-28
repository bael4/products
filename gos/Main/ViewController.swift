//
//  ViewController.swift
//  gos
//
//  Created by Баэль Рыспеков on 25/4/23.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
    
    private var controller: MainController?
    
    private lazy var searchTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "поиск"
        view.backgroundColor = .white
        view.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        return view
    }()
    
    private lazy var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseId)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .cyan
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        controller = MainController(view: self)
        setupSubviews()
        view.backgroundColor = .cyan
        controller?.fetchProducts()
    }
    
    @objc func editingChanged(_ sender: UITextField) {
        let search = sender.text ?? ""
        controller?.serch(text: search)
        print(searchTextField.text!)
    }
    
    private func setupSubviews() {
        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(44)
        }
        
        
        view.addSubview(productsCollectionView)
        productsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
    }
    
    func reloadProductsCollectionView() {
        DispatchQueue.main.async {
            self.productsCollectionView.reloadData()
        }
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        controller?.getProducts().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell
        cell.delegate = self
        cell.indexPath = indexPath
        cell.fill(product: (controller?.getProducts()[indexPath.row])!)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 20, height: 290)
    }
}

extension ViewController: ProductActions {
    func removeFavouriteTap(index: Int) {
        controller?.removeData(index: index)
    }
    
    func favouriteTap(index: Int) {
        // вызвать функцию для передачи данных контроллеру и далее модели
        controller?.dataToSave(index: index)
        }
    }
    
