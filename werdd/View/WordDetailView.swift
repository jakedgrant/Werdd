//
//  WordDetailView.swift
//  werdd
//
//  Created by Jake Grant on 4/18/22.
//

import UIKit

class WordDetailView: UIView, RoundableView {
	var cornerRadius: CGFloat = 34.0
	var partOfSpeech: Word.PartOfSpeech? = nil
	var content: String?
	var detailType: WordInfoType?
	
	let VStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.spacing = 12
		return stack
	}()
	
	var contentLabel: UILabel = {
		let label = UILabel()
		
		label.font = .playfairDisplayFont(.regular, size: 18)
		
		label.textColor = .gapNavy
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 0
		
		return label
	}()
	
	lazy var detailLabel: UILabel = {
		let label = UILabel()
		label.font = .playfairDisplayFont(.bold, size: 16)
		label.textColor = .gapWhite
		
		return label
	}()
	
	// MARK: - Initializers
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		makeCornersRounded()
		updateLabels()
		setUpUI()
	}
	
	convenience init(partOfSpeech: Word.PartOfSpeech? = nil, content: String?, detailType: WordInfoType?) {
		self.init(frame: .zero)
		
		self.partOfSpeech = partOfSpeech
		self.content = content
		self.detailType = detailType
		
		switch detailType {
		case .definition:
			backgroundColor = .gapBlue
		case .synonym:
			backgroundColor = .gapGreen
		case .antonym:
			backgroundColor = .gapRed
		case .example:
			backgroundColor = .gapYellow
		default:
			backgroundColor = .gapWhite
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func updateLabels() {
		contentLabel.text = content
		detailLabel.text = detailType?.rawValue
	}
	
	private func setUpUI() {
		VStack.addArrangedSubview(contentLabel)
		VStack.addArrangedSubview(detailLabel)
		
		addSubview(VStack)
		
		VStack.activate(constraints: [
			VStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
			VStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
			VStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
		])
		
		contentLabel.activate(constraints: [
			contentLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: -40)
		])
	}
}
