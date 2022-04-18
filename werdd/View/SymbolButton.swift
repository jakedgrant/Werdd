//
//  WordButton.swift
//  werdd
//
//  Created by Jake Grant on 3/17/22.
//

import UIKit

class SymbolButton: UIButton {
	var systemName: String
	var titleText: String?
	var buttonAction: (() -> Void)?
	var animation: (() -> Void)?
	
	init(systemName: String,
		 titleText: String? = nil,
		 withAction action: (() -> Void)?) {
		self.systemName = systemName
		self.titleText = titleText
		self.buttonAction = action
		super.init(frame: .zero)
		
		self.setTitle(titleText, for: .normal)
		setUpUI()
		
		addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setUpUI() {
		
		let symbolConfig = UIImage.SymbolConfiguration(pointSize: 30)
		let buttonImage = UIImage(systemName: systemName, withConfiguration: symbolConfig)
		setImage(buttonImage, for: .normal)
	}
	
	@objc func buttonPressed() {
		buttonAction?()
		animation?()
	}
}
