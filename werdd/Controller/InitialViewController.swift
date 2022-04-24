//
//  ViewController.swift
//  werdd
//
//  Created by Jake Grant on 3/9/22.
//

import UIKit

class InitialViewController: UIViewController {
	
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
			withAction: getRandomWord)
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
	var words = Words().words

	// MARK: - UI Lifecycle
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .backgroundColor

		words.sort { $0.word < $1.word }
		
		getRandomWord()
		addSubViews()
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
	private func getRandomWord() {
		self.wordView.update(word: self.words.randomElement()!)
		
		guard let randomWordUrl = URL(string: "https://wordsapiv1.p.rapidapi.com/words/?random=true") else {
			print("Invalid URL")
			return
		}
		
		var urlRequest = URLRequest(url: randomWordUrl)
		urlRequest.httpMethod = "GET"
		urlRequest.setValue("wordsapiv1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
		urlRequest.setValue("cfcd8bc8b6msh1a6358eed3f279ap1a6b17jsn9ea864732992", forHTTPHeaderField: "X-RapidAPI-Key")
		
		URLSession.shared.dataTask(with: urlRequest) { data, response, error in
			guard let data = data, error == nil else {
				print("There was an error: \(error?.localizedDescription ?? "unknown error")")
				return
			}
			
			do {
				let words = try JSONDecoder().decode([Word].self, from: data)
				print(words)
			}
			catch {
				print("Failed to convert \(error.localizedDescription)")
			}
		}.resume()
	}
	
	@objc func presentRandomWordDetail() {
		let wordDetailVC = WordDetailViewController(word: words.randomElement()!)
		navigationController?.pushViewController(wordDetailVC, animated: true)
	}
	
	private func presentWordDetail(for word: Word) {
		var showWord = word
		showWord.synonym = "eject" // TODO: remove this
		showWord.antonym = "welcome"
		showWord.example = "Yet the zeal and speed of his defenestration should give us some discomfort."
		let wordDetailVC = WordDetailViewController(word: showWord)
		navigationController?.pushViewController(wordDetailVC, animated: true)
	}
}

// MARK: - UITableViewDataSource
extension InitialViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		words.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: WordTableViewCell.wordCellIdentifier, for: indexPath) as? WordTableViewCell else {
			return UITableViewCell()
		}
		
		let word = words[indexPath.row]
		cell.update(word: word)
	
		return cell
	}
}

// MARK: - UITableViewDelegate
extension InitialViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedWord = words[indexPath.row]
		
		presentWordDetail(for: selectedWord)
	}
}
