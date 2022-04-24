//
//  WordDetailViewController.swift
//  werdd
//
//  Created by Jake Grant on 4/17/22.
//

import UIKit

class WordDetailViewController: UIViewController {
	var word: Word
	
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
	
	// definition
	lazy var definitionView: WordDetailView = {
		let detail = WordDetailView(
			partOfSpeech: word.partOfSpeech,
			content: word.definition,
			detailType: .definition)

		return detail
	}()
	
	// synonyms
	lazy var synonymView: WordDetailView = {
		let detail = WordDetailView(
			content: word.synonym,
			detailType: .synonym)
		return detail
	}()
	
	// antonyms
	lazy var antonymView: WordDetailView = {
		let detail = WordDetailView(
			content: word.antonym,
			detailType: .antonym)
		return detail
	}()
	
	// example
	lazy var exampleView: WordDetailView = {
		let detail = WordDetailView(
			content: word.example,
			detailType: .example)
		return detail
	}()
	
	// MARK - Initializer
	init(word: Word) {
		self.word = word
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK - View Lifecycle
	override func loadView() {
		super.loadView()
		
		navigationItem.title = word.word
		navigationController?.navigationBar.prefersLargeTitles = true
		
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
		
		stackView.addArrangedSubview(definitionView)
		stackView.addArrangedSubview(synonymView)
		stackView.addArrangedSubview(antonymView)
		stackView.addArrangedSubview(exampleView)
		
		scrollView.addSubview(stackView)
		
		stackView.activate(constraints: [
			stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
			stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
			stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40)
		])
	}
}
