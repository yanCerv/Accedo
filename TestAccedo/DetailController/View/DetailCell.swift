//
//  DetailCell.swift
//  TestAccedo
//
//  Created by MacBook Pro on 31/10/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit
import SDWebImage

class DetailCell: UICollectionViewCell {
    
    var comic: Comic? {
        didSet {
            guard let comic = comic else { return }
            let url = URL(string: comic.thumbnail.path + "." + comic.thumbnail.imgExtension)!
            characterImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            characterImage.sd_setImage(with: url)
        }
    }
    
    let characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    static var id: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(characterImage)
        characterImage.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        characterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        characterImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        characterImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant:  -5).isActive = true
        
    }
    required init?(coder: NSCoder) {
        fatalError("Error init Coder")
    }
}
