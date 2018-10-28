//
//  FullScreenCell.swift
//  MultiPagedController
//
//  Created by Baby on 10/28/18.
//

import UIKit

final class FullScreenCell: UICollectionViewCell, NibInstantiatable, ReusableCell {

	@IBOutlet weak private var containerView: UIView!

	override func layoutSubviews() {
		super.layoutSubviews()
		containerView.subviews.first?.frame = containerView.bounds
	}

	func addOnContainer(_ subview: UIView) {
		containerView.addSubview(subview)
	}
}
