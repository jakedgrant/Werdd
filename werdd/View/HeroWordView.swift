//
//  HeroWordView.swift
//  werdd
//
//  Created by Jake Grant on 3/17/22.
//

import UIKit

class HeroWordView: RoundedUIView {
	// MARK: - Properties
	var word: Word?
	
	// MARK: - Views
	private let wordHStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.alignment = .firstBaseline
		stack.distribution = .fillProportionally
		stack.spacing = 8
		return stack
	}()
	
	private let wordVStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.alignment = .leading
		stack.distribution = .fill
		stack.spacing = 6
		return stack
	}()
	
	private let wordLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "PlayfairDisplay-Bold", size: 24)
		label.textColor = .gapNavy
		return label
	}()
	
	private let partOfSpeechLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "PlayfairDisplay-Italic", size: 16)
		label.textColor = .gapNavy
		return label
	}()
	
	private let definitionLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "PlayfairDisplay-Regular", size: 18)
		
		label.textColor = .gapNavy
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 0
		return label
	}()
	
	var gradient: CAGradientLayer = {
		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = [UIColor.gapBlue!.cgColor, UIColor.gapGreen!.cgColor]
		
		return gradientLayer
	}()
	
	// MARK: - Initializers
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setUpUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - View Lifecycle
	override func layoutSubviews() {
		super.layoutSubviews()
		
		// create layer in this view and adjust the gradient layer frame when the View gets laid out
		gradient.frame = bounds
		gradient.cornerRadius = layer.cornerRadius

		if let sublayers = layer.sublayers {
			if !sublayers.contains(gradient) {
				layer.insertSublayer(gradient, at: 0)
			}
		}
	}
	
	// MARK: - UI Setup
	private func setUpUI() {
		
		wordHStackView.addArrangedSubview(wordLabel)
		wordHStackView.addArrangedSubview(partOfSpeechLabel)
		
		wordVStackView.addArrangedSubview(wordHStackView)
		wordVStackView.addArrangedSubview(definitionLabel)
		
		addSubview(wordVStackView)
		
		wordHStackView.activate(constraints: [
			wordHStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
			wordHStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
		])
		
		definitionLabel.activate(constraints: [
			definitionLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: -40)
		])
	}
	
	// MARK: - Actions
	func update(word: Word) {
		
		wordLabel.text = word.name
		partOfSpeechLabel.text = word.partOfSpeech
		
		// creating justified attributed string
		let definition = word.definition
		let justifiedStyle: NSMutableParagraphStyle = NSMutableParagraphStyle.init()
		justifiedStyle.alignment = .justified
		let attributes = [NSAttributedString.Key.paragraphStyle: justifiedStyle]
		let justifiedString = NSAttributedString.init(string: definition, attributes: attributes)
		
		definitionLabel.attributedText = justifiedString
	}
}
