//
//  ViewController.swift
//  werdd
//
//  Created by Jake Grant on 3/9/22.
//

import UIKit

class InitialViewController: UIViewController {
	var currentWord: Word? {
		didSet {
			if let word = currentWord {
				wordView.update(word: word)
			}
		}
	}
	
	var searchWord: Word?
	
	// MARK: - UIKit Controls
	let titleLabel: UILabel = {
		let label = UILabel()
		label.font = .playfairDisplayFont(.bold, size: 48)
		label.text = "Werdd."
		label.textColor = .titleColor
		return label
	}()
	
	let wordView: HeroWordView = {
		let view = HeroWordView()
		return view
	}()
	
	lazy var randomWordButton: SymbolButton = {
		let button = SymbolButton(
			systemName: "arrow.clockwise.circle",
			withAction: randomWordRequested)
		button.animation = {
			let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
			   rotation.toValue = NSNumber(value: Double.pi * 2)
			   rotation.duration = 0.3
			   
			button.layer.add(rotation, forKey: "rotationAnimation")
		   }
		button.tintColor = .gapWhite
		return button
	}()
	
	lazy var wordTable: RoundedTableView = {
		let table = RoundedTableView()
		table.backgroundColor = .gapLightYellow
		table.dataSource = self
		table.delegate = self
		table.register(WordTableViewCell.self, forCellReuseIdentifier: WordTableViewCell.wordCellIdentifier)
		table.separatorStyle = .none
		return table
	}()
	
	// MARK: - Properties
	var words = [Word(word: "thing",
					  results: [WordResult(
						definition: "this is a thingy thing thing",
						partOfSpeech: .verb,
						synonyms: nil,
						antonyms: nil,
						examples: nil)])]

	// MARK: - UI Lifecycle
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .backgroundColor

		words.sort { $0.word < $1.word }
		
		addSubViews()
		randomWordRequested()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		
		navigationController?.setNavigationBarHidden(false, animated: true)
	}

	// MARK: - UI Setup
	private func addSubViews() {
		
		view.addSubview(titleLabel)
		titleLabel.activate(constraints: [
			titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
		])
		
		view.addSubview(wordView)
		wordView.activate(constraints: [
			wordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			wordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			wordView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
			wordView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
		])
		
		view.addSubview(randomWordButton)
		randomWordButton.activate(constraints: [
			randomWordButton.trailingAnchor.constraint(equalTo: wordView.trailingAnchor, constant: -16),
			randomWordButton.bottomAnchor.constraint(equalTo: wordView.bottomAnchor, constant: -16)
		])
		
		view.addSubview(wordTable)
		wordTable.activate(constraints: [
			wordTable.topAnchor.constraint(equalTo: wordView.bottomAnchor, constant: 40),
			wordTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			wordTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			wordTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	// MARK: - Actions
	private func randomWordRequested() {
		fetchRandomWord { word, error in
			if let error = error {
				print(error.localizedDescription)
			}
			
			DispatchQueue.main.async { [weak self] in
				self?.currentWord = word
				self?.searchWord = word
				self?.wordTable.reloadData()
				self?.removeSpinner()
			}
		}
	}
	
	private func fetchRandomWord(completion: @escaping (Word?, Error?) -> Void) {
		guard let randomWordUrl = URL(string: "https://wordsapiv1.p.rapidapi.com/words/?random=true") else {
			print("Invalid URL")
			return
		}
		
		var urlRequest = URLRequest(url: randomWordUrl)
		urlRequest.httpMethod = "GET"
		urlRequest.allHTTPHeaderFields = [
			"X-RapidAPI-Host": "wordsapiv1.p.rapidapi.com",
			"X-RapidAPI-Key": Secrets.wordApiKey
		]
		
		addSpinner()
		
		URLSession.shared.dataTask(with: urlRequest) { data, response, error in
			guard let data = data, error == nil else {
				completion(nil, error)
				return
			}
			
			do {
				let word = try JSONDecoder().decode(Word.self, from: data)
				completion(word, error)
				print(word)
			}
			catch {
				print("Failed to convert \(error.localizedDescription)")
				completion(nil, error)
			}
		}.resume()
	}
	
	private func presentWordDetail(for word: String, with result: WordResult) {
		let wordDetailVC = WordDetailViewController(word: word, result: result)
		navigationController?.pushViewController(wordDetailVC, animated: true)
	}
}

// MARK: - UITableViewDataSource
extension InitialViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		searchWord?.results?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: WordTableViewCell.wordCellIdentifier, for: indexPath) as? WordTableViewCell else {
			return UITableViewCell()
		}
		
		if let word = searchWord?.word, let results = searchWord?.results {
			let result = results[indexPath.row]
			
			cell.update(word: word, result: result)
			return cell
		} else {
			return UITableViewCell()
		}
	}
}

// MARK: - UITableViewDelegate
extension InitialViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let word = searchWord?.word, let result = searchWord?.results?[indexPath.row] {
			presentWordDetail(for: word, with: result)
		}
	}
	
// MARK: - Spinner
	func addSpinner() {
		let child = SpinnerViewController()
		
		addChild(child)
		child.view.frame = view.frame
		view.addSubview(child.view)
		child.didMove(toParent: self)
	}
	
	func removeSpinner() {
		
		let child = children.first as? SpinnerViewController
		if let child = child {
			child.willMove(toParent: nil)
			child.view?.removeFromSuperview()
			child.removeFromParent()
		}
	}
}
