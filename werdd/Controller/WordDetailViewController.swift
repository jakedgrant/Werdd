//
//  WordDetailViewController.swift
//  werdd
//
//  Created by Jake Grant on 4/17/22.
//

import UIKit

class WordDetailViewController: UIViewController {
	var word: String
	var result: WordResult
	
	let scrollView: UIScrollView = {
		let view = UIScrollView()
		return view
	}()
	
	let stackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.spacing = 30
		return stack
	}()
	
	lazy var faveButton: SymbolButton = {
		let button = SymbolButton(
			systemName: "heart.text.square.fill",
			titleText: nil,
			withAction: addWordToFavorites)
		
		button.tintColor = .gapRed
		return button
	}()
	
	// definition
	lazy var definitionView: WordDetailView = {
		let detail = WordDetailView(
			content: result.definition,
			detailType: .definition)

		return detail
	}()
	
	// synonyms
	lazy var synonymView: WordDetailView = {
		let detail = WordDetailView(
			content: result.synonyms?.joined(separator: " | "),
			detailType: .synonym)
		return detail
	}()
	
	// antonyms
	lazy var antonymView: WordDetailView = {
		let detail = WordDetailView(
			content: result.antonyms?.joined(separator: " | "),
			detailType: .antonym)
		return detail
	}()
	
	// example
	lazy var exampleView: WordDetailView = {
		let detail = WordDetailView(
			content: result.examples?.joined(separator: " | "),
			detailType: .example)
		return detail
	}()
	
	// MARK - Initializer
	init(word: String, result: WordResult) {
		self.word = word
		self.result = result
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK - View Lifecycle
	override func loadView() {
		super.loadView()
		
		navigationItem.title = word
		navigationController?.navigationBar.prefersLargeTitles = true
		
		
		let buttonItem = UIBarButtonItem.init(customView: faveButton)
		
		navigationItem.rightBarButtonItem = buttonItem
		
		view.backgroundColor = .backgroundColor
		
		setUpUI()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		
		definitionView.updateLabels()
		synonymView.updateLabels()
		antonymView.updateLabels()
		exampleView.updateLabels()
    }
	
	private func setUpUI() {
		view.addSubview(scrollView)
		
		scrollView.activate(constraints: [
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
		if result.definition != nil {
			stackView.addArrangedSubview(definitionView)
		}
		
		if result.synonyms != nil {
			stackView.addArrangedSubview(synonymView)
		}
		
		if result.antonyms != nil {
			stackView.addArrangedSubview(antonymView)
		}
		
		if result.examples != nil {
			stackView.addArrangedSubview(exampleView)
		}
		
		scrollView.addSubview(stackView)
		
		stackView.activate(constraints: [
			stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
			stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
			stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40)
		])
	}
	
	private func addWordToFavorites() {
		print("button pressed")
	}
}
