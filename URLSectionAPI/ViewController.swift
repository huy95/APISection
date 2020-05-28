//
//  ViewController.swift
//  URLSectionAPI
//
//  Created by Huy on 5/28/20.
//  Copyright © 2020 Huy. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate {
    var datas: [Item]?
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collection.backgroundColor = .white
        
        return collection
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        addComponent()
        setupLayout()
        APIdata("")
        searchBar.delegate = self
    }
    func addComponent() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    func  setupLayout(){
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func APIdata(_ name: String) {
        
        let url = String(format: "https://itunes.apple.com/search?term=%@&limit=20", name)
        guard let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let urlRequest = URL(string: urlString) else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse else { return }
            guard let strongSelf = self else { return }
            print(response.statusCode)
            
            if response.statusCode == 200 {
                do {
                    let recieveData = try JSONDecoder().decode(ObjectAPI.self, from: data)
                    DispatchQueue.main.async {
                        strongSelf.datas = recieveData.results
                        strongSelf.collectionView.reloadData()
                    }
                } catch {
                    print("error: \(error)")
                }
            }
        }
        dataTask.resume()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.APIdata(searchText)
    }
    
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.datas = datas?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = ((collectionView.frame.size.width - 4 - 8) / 2)
        return CGSize(width: size, height: size * 3 / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = ViewController2()
        destinationVC.detailData = datas![indexPath.row]
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}



