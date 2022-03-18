//
//  WordButton.swift
//  werdd
//
//  Created by Jake Grant on 3/17/22.
//

import UIKit

class SymbolButton: UIButton {
	var systemName: String

	init(systemName: String) {
		self.systemName = systemName
		super.init(frame: .zero)
		
		setUpUI()
	}
	
	init(systemName: String, titleLabelText: String) {
		self.systemName = systemName
		super.init(frame: .zero)
		
		self.setTitle(titleLabelText, for: .normal)
		setUpUI()
	}
	
	override init(frame: CGRect) {
		self.systemName = ""
		super.init(frame: frame)
		
		setUpUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setUpUI() {
		
		let symbolConfig = UIImage.SymbolConfiguration(pointSize: 30)
		let buttonImage = UIImage(systemName: systemName, withConfiguration: symbolConfig)
		setImage(buttonImage, for: .normal)
	}
}
