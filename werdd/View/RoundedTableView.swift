//
//  RoundedTableView.swift
//  werdd
//
//  Created by Jake Grant on 3/24/22.
//

import UIKit

class RoundedTableView: UITableView {
	let cornerRadius = 34.0

//	let table = UITableView()
//
//	var dataSource: UITableViewDataSource?
//	var delegate: UITableViewDelegate?
	
	// MARK: - Initializers
	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		layer.cornerRadius = self.cornerRadius
		// only apply corner radius to top-left and top-right corners
		layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
//	func setUpUI() {
//
//		addSubview(table)
//		table.activate(constraints: [
//			table.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
//			table.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//			table.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//			table.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
//		])
//	}
}
