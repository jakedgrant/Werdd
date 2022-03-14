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
		stack.distribution = .fillProportionally
		stack.spacing = 6
		return stack
	}()
	
	let wordLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "PlayfairDisplay-Bold", size: 24)
		label.text = "onomatopaeia"
		label.textColor = .gapNavy
		return label
	}()
	
	let partOfSpeechLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "PlayfairDisplay-Italic", size: 16)
		label.text = "noun"
		label.textColor = .gapNavy
		return label
	}()
	
	let definitionLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "PlayfairDisplay-Regular", size: 18)
		
		// creating justified attributed string
		let definition = "the naming of a thing or action by a vocal imitation of the sound associated with it (such as buzz, hiss)"
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

	// MARK: - UI Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .gapWhite
		
		addSubViews()
	}

	// MARK: - UI Setup
	func addSubViews() {
		view.addSubview(titleLabel)
		view.addSubview(wordView)
		
		wordHStackView.addArrangedSubview(wordLabel)
		wordHStackView.addArrangedSubview(partOfSpeechLabel)
		
		wordVStackView.addArrangedSubview(wordHStackView)
		wordVStackView.addArrangedSubview(definitionLabel)

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
	}
}

