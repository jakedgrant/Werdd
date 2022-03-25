//
//  UIView+Extension.swift
//  werdd
//
//  Created by Jake Grant on 3/14/22.
//

import UIKit

extension UIView {
	func activate(constraints: [NSLayoutConstraint]) {
		self.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(constraints)
	}
	
	func addGradientLayer(with colors: UIColor...) {
		
		let gradientLayer = CAGradientLayer()
		let cgColors = colors.map { $0.cgColor }
		gradientLayer.colors = cgColors
		
		gradientLayer.frame = bounds
		gradientLayer.cornerRadius = layer.cornerRadius		
		
		layer.insertSublayer(gradientLayer, at: 0)
	}
}
