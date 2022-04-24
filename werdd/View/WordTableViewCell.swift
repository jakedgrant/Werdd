//
//  WordTableViewCell.swift
//  werdd
//
//  Created by Jake Grant on 4/1/22.
//

import UIKit

class WordTableViewCell: UITableViewCell {
	static let wordCellIdentifier = "WordTableViewCell"

	// MARK: - UIProperties
	private let wordHStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.alignment = .firstBaseline
		stack.distribution = .fillProportionally
		stack.spacing = 6
		return stack
	}()
	
	private let wordLabel: UILabel = {
		let label = UILabel()
		label.font = .playfairDisplayFont(.bold, size: 16)
		label.textColor = .gapNavy
		return label
	}()
	
	private let partOfSpeechLabel: UILabel = {
		let label = UILabel()
		label.font = .playfairDisplayFont(.italic, size: 12)
		label.textColor = .gapNavy
		return label
	}()
	
	private let definitionLabel: UILabel = {
		let label = UILabel()
		label.font = .playfairDisplayFont(.regular, size: 14)
		label.textColor = .gapNavy
		label.lineBreakMode = .byTruncatingTail
		label.numberOfLines = 1
		return label
	}()
	
	private let cardView: RoundedUIView = {
		let view = RoundedUIView()
		view.backgroundColor = .gapYellow
		return view
	}()
	
	private let selectedContainerView = UIView()
	
	private let selectedView: RoundedUIView = {
		let view = RoundedUIView()
		view.layer.borderWidth = 4
		view.layer.borderColor = UIColor.gapYellow.cgColor
		return view
	}()
	
	// MARK: - Initializers
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setUpUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setUpUI() {		
		backgroundColor = .gapLightYellow
		
//		selectedView.cornerRadius = 40
//		selectedView.makeCornersRounded()
//		selectedContainerView.addSubview(selectedView)
//		selectedView.activate(constraints: [
//			selectedView.topAnchor.constraint(equalTo: selectedContainerView.topAnchor, constant: 3),
//			selectedView.leadingAnchor.constraint(equalTo: selectedContainerView.leadingAnchor, constant: 12),
//			selectedView.trailingAnchor.constraint(equalTo: selectedContainerView.trailingAnchor, constant: -12),
//			selectedView.bottomAnchor.constraint(equalTo: selectedContainerView.bottomAnchor, constant: -3),
//		])
		
		// Set background if selected
//		let backgroundView = RoundedUIView()
//		backgroundView.backgroundColor = .gapYellow
		selectedBackgroundView = selectedContainerView
		
		wordHStack.addArrangedSubview(wordLabel)
		wordHStack.addArrangedSubview(partOfSpeechLabel)
		
		cardView.addSubview(wordHStack)
		cardView.addSubview(definitionLabel)
		
		contentView.addSubview(cardView)
		
		cardView.activate(constraints: [
			cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
		])
		
		wordHStack.activate(constraints: [
			wordHStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
			wordHStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24)
		])
		
		definitionLabel.activate(constraints: [
			definitionLabel.topAnchor.constraint(equalTo: wordHStack.bottomAnchor, constant: 4),
			definitionLabel.leadingAnchor.constraint(equalTo: wordHStack.leadingAnchor),
			definitionLabel.widthAnchor.constraint(equalTo: cardView.widthAnchor, constant: -48),
			definitionLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16)
		])
	}
	
	func update(word: Word) {
		wordLabel.text = word.word
		partOfSpeechLabel.text = word.results?.first?.partOfSpeech?.rawValue
		definitionLabel.text = word.results?.first?.definition
	}
	
//	override func setSelected(_ selected: Bool, animated: Bool) {
//		super.setSelected(selected, animated: true)
//	}
}
