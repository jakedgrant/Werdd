//
//  RoundedUIView.swift
//  werdd
//
//  Created by Jake Grant on 3/18/22.
//

import UIKit

class RoundedUIView: UIView, RoundableView{
	var cornerRadius: CGFloat = 34.0

	// MARK: - Initializers
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		makeCornersRounded()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

protocol RoundableView: AnyObject {
	var cornerRadius: CGFloat { get set }
	func makeCornersRounded()
}

extension RoundableView where Self: UIView {	
	func makeCornersRounded() {
		layer.cornerRadius = cornerRadius
		layer.masksToBounds = true
	}
}
