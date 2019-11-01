//
//  ActivityLoaderView.swift
//  TestAccedo
//
//  Created by MacBook Pro on 01/11/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit

class ActivityLoaderView: UIView {
    let indicatorView: UIActivityIndicatorView = {
        let iv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        iv.color = .darkGray
        iv.startAnimating()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    static var id: String {
          return String(describing: self)
      }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        addSubview(indicatorView)
        indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        indicatorView.widthAnchor.constraint(equalToConstant: 20).isActive = true
      }
      required init?(coder: NSCoder) {
          fatalError("Error Init Coder")
      }
}
