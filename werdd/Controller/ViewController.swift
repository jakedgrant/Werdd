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
	
	// MARK: - Properties
	var currentWord = Word(word: ".", partOfSpeech: ".", definition: ".")
	
	var words: [Word] = [
		Word(word: "onomatopaeia", partOfSpeech: "noun", definition: "the naming of a thing or action by a vocal imitation of the sound associated with it (such as buzz, hiss)"),
		Word(word: "penultimate", partOfSpeech: "adjective", definition: "last but one in a series of things; second last"),
		Word(word: "defenestrate", partOfSpeech: "verb", definition: "throw (someone) out of a window"),
		Word(word: "switch", partOfSpeech: "verb", definition: "change the position, direction, or focus of"),
		Word(word: "pontificate", partOfSpeech: "verb", definition: "express one's opinions in a way considered annoyingly pompous and dogmatic"),
		Word(word: "detergent", partOfSpeech: "noun", definition: "a water-soluble cleansing agent which combines with impurities and dirt to make them more soluble, and differs from soap in not forming a scum with the salts in hard water"),
		Word(word: "bacon", partOfSpeech: "noun", definition: "cured meat from the sides and belly of a pig, having distinct strips of fat and typically served in thin slices"),
		Word(word: "jambalaya", partOfSpeech: "noun", definition: "a Cajun dish of rice with shrimp, chicken, and vegetables"),
		Word(word: "diode", partOfSpeech: "noun", definition: "a semiconductor device with two terminals, typically allowing the flow of current in one direction only"),
		Word(word: "algorithm", partOfSpeech: "noun", definition: "a process or set of rules to be followed in calculations or other problem-solving operations, especially by a computer")
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
			wordView.heightAnchor.constraint(equalToConstant: 200)
		])
		
		view.addSubview(randomWordButton)
		randomWordButton.activate(constraints: [
			randomWordButton.trailingAnchor.constraint(equalTo: wordView.trailingAnchor, constant: -16),
			randomWordButton.bottomAnchor.constraint(equalTo: wordView.bottomAnchor, constant: -16)
		])
	}
	
	@objc private func getRandomWord() {
		currentWord = words.randomElement()!
		wordView.update(word: currentWord)
	}
}

