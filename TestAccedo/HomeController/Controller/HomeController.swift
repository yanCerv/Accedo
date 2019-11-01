//
//  HomeController.swift
//  TestAccedo
//
//  Created by MacBook Pro on 29/10/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    let network = NetworkHomeController()
    let refreshControl = UIRefreshControl()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ComicCell.self, forCellReuseIdentifier: ComicCell.id)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()

    var characters = [Characters]()
    var isPaginated = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9097761512, green: 0.9097753167, blue: 0.9140068293, alpha: 1)
        setupViews()
        getCharacters()
        setupNavigation()
        setupRefreshControl()
    }
    
    @objc private func handleRefresh() {
        ApiKeys.offSet = 1
        getCharacters()
    }
    
    private func getCharacters() {
        network.getCharacter(feed: .getCharacters) { [weak self] (result) in
            self?.refreshControl.endRefreshing()
            switch result {
            case .error(let error):
                print(error)
                self?.showAlert(title: "Error", message: "Error ocurred try again or more later", style: .alert)
            case .success(let resources):
                self?.characters = resources?.data.results ?? []
                self?.updateData()
            }
        }
    }
    
    private func loadMoreCharacters() {
        network.getCharacter(feed: .getCharacters) { [weak self] (result) in
            switch result {
            case .error(let error):
                print(error)
                self?.showAlert(title: "Error", message: "Error ocurred try again or more later", style: .alert)
            case .success(let resources):
                self?.characters += resources?.data.results ?? []
                let all = self?.characters.filterDuplicate { ( $0 )}
                self?.characters = all ?? []
                self?.updateData()
                self?.isPaginated = false
            }
        }
    }
    
    func updateData() {
        let sum = ApiKeys.offSet + 9
        ApiKeys.offSet = sum
        tableView.reloadData()
        activityIndicatorView.stopAnimating()
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    private func setupNavigation() {
        navigationItem.title = "Heroes"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.87179178, green: 0.4060242474, blue: 0.3600872755, alpha: 1)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalToConstant: 100).isActive = true

        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}


// MARK: Delegates for tableView
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ComicCell.id, for: indexPath) as? ComicCell else { return UITableViewCell() }
        cell.characters = characters[indexPath.row]
        
        // pagination
        if indexPath.item == characters.count - 1 && !isPaginated {
            isPaginated = true
            loadMoreCharacters()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        let details = DetailController(character: character)
        UserDefaults.standard.set(character.id, forKey: "characterId")
        navigationController?.pushViewController(details, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.getFloatValue(phone: 400, iPad: 800)
    }
}
