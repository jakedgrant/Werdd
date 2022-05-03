//
//  FavoritesViewController.swift
//  werdd
//
//  Created by Jake Grant on 5/2/22.
//

import UIKit

class FavoritesViewController: UIViewController {
	private let navTitle = "Favorites"
	private var favoriteWords = [Word]()
	
	lazy var wordTable: UITableView = {
		let table = UITableView()
		table.backgroundColor = .backgroundColor
		table.dataSource = self
		table.delegate = self
		table.register(WordTableViewCell.self, forCellReuseIdentifier: WordTableViewCell.reuseIdentifier)
		table.separatorStyle = .none
		return table
	}()
	
	override func loadView() {
		super.loadView()
		
		navigationItem.title = navTitle
		navigationController?.navigationBar.prefersLargeTitles = true
		
		view.backgroundColor = .backgroundColor
		
		setUpUI()
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	private func setUpUI() {
		view.addSubview(wordTable)
		wordTable.activate(constraints: [
			wordTable.topAnchor.constraint(equalTo: view.topAnchor),
			wordTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			wordTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			wordTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	private func presentWordDetail(for word: String, with result: WordResult) {
		let wordDetailVC = WordDetailViewController(word: word, result: result)
		navigationController?.pushViewController(wordDetailVC, animated: true)
	}
}

extension FavoritesViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		favoriteWords.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
}

extension FavoritesViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let word = favoriteWords[indexPath.row]
		presentWordDetail(for: word.word, with: (word.results?.first)!)
	}
}
