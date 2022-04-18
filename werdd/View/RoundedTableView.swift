//
//  RoundedTableView.swift
//  werdd
//
//  Created by Jake Grant on 3/24/22.
//

import UIKit

class RoundedTableView: UITableView, RoundableView {
	var cornerRadius: CGFloat = 34.0
	
	// MARK: - Initializers
	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		makeCornersRounded()
		// only apply corner radius to top-left and top-right corners
		layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
