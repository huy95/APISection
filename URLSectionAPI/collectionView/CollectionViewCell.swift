//
//  CollectionViewCell.swift
//  URLSectionAPI
//
//  Created by Huy on 5/28/20.
//  Copyright © 2020 Huy. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionViewCell: UICollectionViewCell {
    
    var datas: Item? {
      didSet {
        if let data = datas {
          nameLabel.text = data.trackName
          bookImageView.kf.setImage(with: URL(string: data.artworkUrl100 ?? ""))
            
        }
      }
    }
    var nameLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.numberOfLines = 0
      label.font = UIFont(name: "", size: 14)
      return label
    }()
    
    var bookImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.image = UIImage(contentsOfFile: "")
      return imageView
    }()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      self.layer.borderWidth = 1
      self.layer.borderColor = UIColor.black.cgColor
      
      addComponent()
      setupLayout()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    func addComponent() {
      self.addSubview(bookImageView)
      self.addSubview(nameLabel)
    }
    
    func setupLayout() {
      bookImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
      bookImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
      bookImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
      bookImageView.heightAnchor.constraint(equalTo: bookImageView.widthAnchor, multiplier: 1).isActive = true
    
      nameLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 8).isActive = true
      nameLabel.leadingAnchor.constraint(equalTo: bookImageView.leadingAnchor).isActive = true
      nameLabel.trailingAnchor.constraint(equalTo: bookImageView.trailingAnchor).isActive = true
      nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
    
}
