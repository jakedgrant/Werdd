//
//  SpinnerViewController.swift
//  werdd
//
//  Created by Jake Grant on 4/23/22.
//

import UIKit

class SpinnerViewController: UIViewController {
	
	let spinner = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	override func loadView() {
		super.loadView()
		
		view.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
		
		view.addSubview(spinner)
		
		spinner.activate(constraints: [
			spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
		
		spinner.startAnimating()
	}
}
