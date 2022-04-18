//
//  ViewController.swift
//  werdd
//
//  Created by Jake Grant on 3/9/22.
//

import UIKit

class ViewController: UIViewController {
	
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
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .backgroundColor

		words.sort { $0.name < $1.name }
		
		getRandomWord()
		addSubViews()
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
	}
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
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
extension ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedWord = words[indexPath.row]
		
		wordView.update(word: selectedWord)
	}
}
