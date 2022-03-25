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
		label.font = UIFont(name: "PlayfairDisplay-Bold", size: 48)
		label.text = "Werdd."
		label.textColor = .titleColor
		return label
	}()
	
	let wordView: HeroWordView = {
		let view = HeroWordView()
		return view
	}()
	
	let randomWordButton: SymbolButton = {
		let button = SymbolButton(systemName: "arrow.clockwise.circle")
		button.tintColor = .gapWhite
		return button
	}()
	
	lazy var wordTable: RoundedTableView = {
		let table = RoundedTableView()
		table.backgroundColor = .gapRed
		table.dataSource = self
		table.delegate = self
		table.register(UITableViewCell.self, forCellReuseIdentifier: "WordCell")
		return table
	}()
	
	// MARK: - Properties
	var words: [Word] = [
		Word(name: "onomatopaeia", partOfSpeech: "noun", definition: "the naming of a thing or action by a vocal imitation of the sound associated with it (such as buzz, hiss)"),
		Word(name: "penultimate", partOfSpeech: "adjective", definition: "last but one in a series of things; second last"),
		Word(name: "defenestrate", partOfSpeech: "verb", definition: "throw (someone) out of a window"),
		Word(name: "switch", partOfSpeech: "verb", definition: "change the position, direction, or focus of"),
		Word(name: "pontificate", partOfSpeech: "verb", definition: "express one's opinions in a way considered annoyingly pompous and dogmatic"),
		Word(name: "detergent", partOfSpeech: "noun", definition: "a water-soluble cleansing agent which combines with impurities and dirt to make them more soluble, and differs from soap in not forming a scum with the salts in hard water"),
		Word(name: "bacon", partOfSpeech: "noun", definition: "cured meat from the sides and belly of a pig, having distinct strips of fat and typically served in thin slices"),
		Word(name: "jambalaya", partOfSpeech: "noun", definition: "a Cajun dish of rice with shrimp, chicken, and vegetables"),
		Word(name: "diode", partOfSpeech: "noun", definition: "a semiconductor device with two terminals, typically allowing the flow of current in one direction only"),
		Word(name: "algorithm", partOfSpeech: "noun", definition: "a process or set of rules to be followed in calculations or other problem-solving operations, especially by a computer")
	]

	// MARK: - UI Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .backgroundColor
		
		randomWordButton.addTarget(self, action: #selector(getRandomWord), for: .touchUpInside)
		
		getRandomWord()
		addSubViews()
	}

	// MARK: - UI Setup
	func addSubViews() {
		
		view.addSubview(titleLabel)
		titleLabel.activate(constraints: [
			titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
		])
		
		view.addSubview(wordView)
		wordView.activate(constraints: [
			wordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			wordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			wordView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
			wordView.heightAnchor.constraint(equalToConstant: 240)
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
	
	@objc private func getRandomWord() {
		wordView.update(word: words.randomElement()!)
	}
}


extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		words.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell") else {
			return UITableViewCell()
		}
		
		let word = words[indexPath.row]
		
		var content = cell.defaultContentConfiguration()
		
		let attributesName: [NSAttributedString.Key: Any] = [
			.font: UIFont(name: "PlayfairDisplay-Regular", size: 18),
			.foregroundColor: UIColor.gapNavy
		]
		let attributedWordName = NSAttributedString(string: word.name, attributes: attributesName)
		content.attributedText = attributedWordName
		
		let attributesDefinition: [NSAttributedString.Key: Any] = [
			.font: UIFont(name: "PlayfairDisplay-Regular", size: 12),
			.foregroundColor: UIColor.gapNavy
		]
		let attributedWordDefinition = NSAttributedString(string: word.definition, attributes: attributesDefinition)
		content.secondaryAttributedText = attributedWordDefinition
		content.secondaryTextProperties.numberOfLines = 1
		content.secondaryTextProperties.lineBreakMode = .byTruncatingTail
		
		cell.contentConfiguration = content
	
		return cell
	}
}

extension ViewController: UITableViewDelegate { }
