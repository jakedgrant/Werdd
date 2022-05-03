//
//  SearchBarHeaderView.swift
//  werdd
//
//  Created by Jake Grant on 4/25/22.
//

import UIKit

class SearchBarHeaderView: UITableViewHeaderFooterView {
	static let reuseIdentifier = "SearchBarHeaderView"
	
	var buttonAction: (() -> Void)? 
	
	// MARK: - UI Properties
	let searchTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Search words"
		textField.tintColor = .gapNavy
		textField.clearsOnBeginEditing = true
		textField.font = UIFont.playfairDisplayFont(.regular, size: 16)
		textField.textColor = .gapNavy
		textField.keyboardType = .alphabet
		textField.borderStyle = .roundedRect
		textField.backgroundColor = .gapYellow
		return textField
	}()
	
	let searchButton: UIButton = {
		let button = UIButton(configuration: .filled())
		button.setTitle("Search", for: .normal)
		button.tintColor = .gapRed
		return button
	}()
	
	private let bottomLineView: UIView = {
		let view = UIView()
		view.backgroundColor = .gapNavy
		return view
	}()
	
	// MARK: - Initializers
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		
		searchButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
		setUpUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - UI Setup
	private func setUpUI() {
		contentView.backgroundColor = .gapLightYellow
		
		contentView.addSubview(searchTextField)
		searchTextField.activate(constraints: [
			searchTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
			searchTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
			searchTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -120),
			searchTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
		])
		
		contentView.addSubview(searchButton)
		searchButton.activate(constraints: [
			searchButton.topAnchor.constraint(equalTo: searchTextField.topAnchor),
			searchButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 8),
			searchButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
			searchButton.heightAnchor.constraint(equalTo: searchTextField.heightAnchor)
		])
		
		contentView.addSubview(bottomLineView)
		bottomLineView.activate(constraints: [
			bottomLineView.leadingAnchor.constraint(equalTo: searchTextField.leadingAnchor, constant: -6),
			bottomLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			bottomLineView.trailingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 6),
			bottomLineView.heightAnchor.constraint(equalToConstant: 1)
		])
	}

	@objc func buttonPressed() {
		buttonAction?()
	}
}
