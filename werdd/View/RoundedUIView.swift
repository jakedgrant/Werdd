//
//  RoundedUIView.swift
//  werdd
//
//  Created by Jake Grant on 3/18/22.
//

import UIKit

class RoundedUIView: UIView {
	let cornerRadius = 34.0

	// MARK: - Initializers
	override init(frame: CGRect) {
		super.init(frame: frame)
		layer.cornerRadius = self.cornerRadius
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
