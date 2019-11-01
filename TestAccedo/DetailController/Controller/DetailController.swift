//
//  DetailController.swift
//  TestAccedo
//
//  Created by MacBook Pro on 29/10/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    let character: Characters
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(character)
    }
    
    init(character: Characters) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("Error Init Coder")
    }
}
