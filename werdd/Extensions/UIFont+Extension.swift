//
//  UIFont+Extension.swift
//  werdd
//
//  Created by Jake Grant on 3/28/22.
//

import UIKit

extension UIFont {
	enum PlayfairDisplayWeight {
		case regular
		case bold
		case italic
	}
	
	static func playfairDisplayFont(_ weight: PlayfairDisplayWeight, size: CGFloat) -> UIFont {
		var fontName: String
		switch weight {
		case .regular:
			fontName = "PlayfairDisplay-Regular"
		case .bold:
			fontName = "PlayfairDisplay-Bold"
		case .italic:
			fontName = "PlayfairDisplay-Italic"
		}
		
		guard let font = UIFont(name: fontName, size: size) else { return UIFont.systemFont(ofSize: size) }
		return font
	}
}
