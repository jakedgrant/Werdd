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
}
