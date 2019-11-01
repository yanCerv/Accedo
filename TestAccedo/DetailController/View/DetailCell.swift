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
            titleLabel.text = comic.title
            
            let stringContain = comic.thumbnail.path.contains("image_not_available")
            if stringContain {
                characterImage.image = UIImage(named: "placeholder")
            } else {
                let url = URL(string: comic.thumbnail.path + "." + comic.thumbnail.imgExtension)!
                characterImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                characterImage.sd_setImage(with: url)
            }
            
        }
    }
    
    let characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = NSLineBreakMode.byClipping
        label.backgroundColor = .white
        label.textAlignment = .center
        label.numberOfLines = 4
        label.font = UIFont.systemFont(ofSize: UIDevice.getFloatValue(phone: 12, iPad: 16))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static var id: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(characterImage)
        addSubview(titleLabel)
        
        characterImage.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        characterImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        characterImage.heightAnchor.constraint(equalToConstant: UIDevice.getFloatValue(phone: 200, iPad: 250)).isActive = true
        characterImage.widthAnchor.constraint(equalToConstant: UIDevice.getFloatValue(phone: 120, iPad: 160)).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant:  -5).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("Error init Coder")
    }
}
