//
//  DetailController.swift
//  TestAccedo
//
//  Created by MacBook Pro on 29/10/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit
import SDWebImage

class DetailController: UIViewController {
    let network = NetworkDetail()
    let character: Characters
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.alwaysBounceVertical = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: UIDevice.getFloatValue(phone: 18, iPad: 22))
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.delegate = self
        collection.dataSource = self
        collection.register(DetailCell.self, forCellWithReuseIdentifier: DetailCell.id)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let noFoundLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.boldSystemFont(ofSize: UIDevice.getFloatValue(phone: 20, iPad: 24))
        label.numberOfLines = 1
        label.text = "No Comics Found"
        label.isHidden = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var comics = [Comic]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupNavigationItems()
        getDetails()
    }
    
    init(character: Characters) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error Init Coder")
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Details"
        
        navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func getDetails() {
        ApiKeys.offSet = 1
        let dispachGroup = DispatchGroup()
        dispachGroup.enter()
        network.getDetails(feed: .getDetails) { [weak self] (result) in
            dispachGroup.leave()
            switch result {
            case .error(let error):
                print(error.localizedDescription)
            case .success(let resources):
                self?.comics = resources?.data.results ?? []
                if self?.comics.count == 0 {
                    self?.noFoundLabel.isHidden = false
                } else {
                    self?.noFoundLabel.isHidden = true
                }
            }
        }
        
        dispachGroup.notify(queue: .main) { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(characterImage)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(collectionView)
        
        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: UIDevice.getFloatValue(phone: 60, iPad: 100)).isActive = true
        
        characterImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        characterImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        characterImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        characterImage.heightAnchor.constraint(equalToConstant: UIDevice.getFloatValue(phone: 350, iPad: 700)).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: UIDevice.getFloatValue(phone: 280, iPad: 350)).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -25).isActive = true
        
        collectionView.addSubview(noFoundLabel)
        
        noFoundLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        noFoundLabel.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
        noFoundLabel.widthAnchor.constraint(equalToConstant: UIDevice.getFloatValue(phone: 300, iPad: 350)).isActive = true
        noFoundLabel.heightAnchor.constraint(equalToConstant: UIDevice.getFloatValue(phone: 100, iPad: 150)).isActive = true
        
        let url = URL(string: character.thumbnail.path + "." + character.thumbnail.imgExtension)!
        characterImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        characterImage.sd_setImage(with: url)
        nameLabel.text = character.name
        if character.description == "" {
            descriptionLabel.text = "No Description"
        } else {
            descriptionLabel.text = character.description
        }
    }
}


extension DetailController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.id, for: indexPath) as? DetailCell else { return UICollectionViewCell() }
        cell.comic = comics[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIDevice.getFloatValue(phone: 140, iPad: 200), height: UIDevice.getFloatValue(phone: 270, iPad: 340))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
