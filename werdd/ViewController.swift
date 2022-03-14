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
		label.textColor = .gapNavy
		return label
	}()
	
	let wordView: UIView = {
		let view = UIView()
		view.backgroundColor = .gapBlue
		view.layer.cornerRadius = 30
		return view
	}()
	
	let wordHStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.alignment = .firstBaseline
		stack.distribution = .fillProportionally
		stack.spacing = 8
		return stack
	}()
	
	let wordVStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.alignment = .leading
		stack.distribution = .fill
		stack.spacing = 6
		return stack
	}()
	
	var wordLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "PlayfairDisplay-Bold", size: 24)
		label.text = "a"
		label.textColor = .gapNavy
		return label
	}()
	
	var partOfSpeechLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "PlayfairDisplay-Italic", size: 16)
		label.text = "a"
		label.textColor = .gapNavy
		return label
	}()
	
	let buttonVStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.alignment = .trailing
		stack.distribution = .fill
		return stack
	}()
	
	let randomWordButton: UIButton = {
		let button = UIButton()
//		button.translatesAutoresizingMaskIntoConstraints = false
		
		let symbolConfig = UIImage.SymbolConfiguration(pointSize: 30)
		let buttonImage = UIImage(systemName: "arrow.clockwise.circle", withConfiguration: symbolConfig)
		button.setImage(buttonImage, for: .normal)
		
		button.tintColor = .gapWhite
		button.addTarget(self, action: #selector(randomButtonPressed), for: .touchUpInside)
		return button
	}()
	
	var definitionLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "PlayfairDisplay-Regular", size: 18)
		
		// creating justified attributed string
		let definition = "a"
		let justifiedStyle: NSMutableParagraphStyle = NSMutableParagraphStyle.init()
		justifiedStyle.alignment = .justified
		let attributes = [NSAttributedString.Key.paragraphStyle: justifiedStyle]
		let justifiedString = NSAttributedString.init(string: definition, attributes: attributes)
		
		label.attributedText = justifiedString
		label.textColor = .gapNavy
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 0
		return label
	}()
	
	// MARK: - Properties
	var currentWord = Word(word: "onomatopaeia",
						   partOfSpeech: "noun",
						   definition: "the naming of a thing or action by a vocal imitation of the sound associated with it (such as buzz, hiss)")
	
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
		view.backgroundColor = .gapWhite
		
		updateWord()
		addSubViews()
	}

	// MARK: - UI Setup
	func updateWord() {
		wordLabel.text = currentWord.word
		partOfSpeechLabel.text = currentWord.partOfSpeech
		
		// creating justified attributed string
		let definition = currentWord.definition
		let justifiedStyle: NSMutableParagraphStyle = NSMutableParagraphStyle.init()
		justifiedStyle.alignment = .justified
		let attributes = [NSAttributedString.Key.paragraphStyle: justifiedStyle]
		let justifiedString = NSAttributedString.init(string: definition, attributes: attributes)
		
		definitionLabel.attributedText = justifiedString
	}
	
	func addSubViews() {
		view.addSubview(titleLabel)
		view.addSubview(wordView)
		
		wordHStackView.addArrangedSubview(wordLabel)
		wordHStackView.addArrangedSubview(partOfSpeechLabel)
		
		buttonVStack.addArrangedSubview(randomWordButton)
		
		wordVStackView.addArrangedSubview(wordHStackView)
		wordVStackView.addArrangedSubview(definitionLabel)
		wordVStackView.addArrangedSubview(buttonVStack)

		wordView.addSubview(wordVStackView)
		
		titleLabel.activate(constraints: [
			titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
		])
		
		wordView.activate(constraints: [
			wordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			wordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			wordView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
			wordView.heightAnchor.constraint(equalTo: wordVStackView.heightAnchor, constant: 40)
		])
		
		wordHStackView.activate(constraints: [
			wordHStackView.topAnchor.constraint(equalTo: wordView.topAnchor, constant: 16),
			wordHStackView.leadingAnchor.constraint(equalTo: wordView.leadingAnchor, constant: 20)
		])
		
		definitionLabel.activate(constraints: [
			definitionLabel.widthAnchor.constraint(equalTo: wordView.widthAnchor, constant: -40)
		])
		
		buttonVStack.activate(constraints: [
			buttonVStack.widthAnchor.constraint(equalTo: wordView.widthAnchor, constant: -40)
		])
	}
	
	@objc func randomButtonPressed() {
		print("button pressed")
	}
}

