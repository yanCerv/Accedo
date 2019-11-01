//
//  ComicCell.swift
//  TestAccedo
//
//  Created by MacBook Pro on 29/10/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit
import SDWebImage

class ComicCell: UITableViewCell {
    
    var characters: Characters? {
        didSet {
            guard let character = characters else { return }
            nameLabel.text = character.name
            let url = URL(string: character.thumbnail.path + "." + character.thumbnail.imgExtension)
            characterImage.sd_setImage(with: url)
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: UIDevice.getFloatValue(phone: 18, iPad: 22))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    static var id: String {
        return String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 0.9097761512, green: 0.9097753167, blue: 0.9140068293, alpha: 1)
        selectionStyle = .none
                
        addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(characterImage)
        
        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: UIDevice.getFloatValue(phone: 40, iPad: 80)).isActive = true
        
        characterImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        characterImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        characterImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        characterImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("Error init Coder")
    }
}
