//
//  ReusableCell.swift
//  MultiPageController
//
//  Created by Baby on 10/28/18.
//  Copyright © 2018 ridge. All rights reserved.
//

import UIKit

protocol ReusableCell {
	static var reuseIdentifier: String { get }
}

extension ReusableCell {
	static var reuseIdentifier: String {
		return String(describing: Self.self)
	}
}

extension UICollectionView {
	func registerCell<C: ReusableCell & NibInstantiatable>(_ cell: C.Type) {
		register(C.nib, forCellWithReuseIdentifier: C.reuseIdentifier)
	}

	func dequeueReusableCell<C: ReusableCell & NibInstantiatable>(_ cell: C.Type, for indexPath: IndexPath) -> C {
		guard let cell = dequeueReusableCell(withReuseIdentifier: C.reuseIdentifier, for: indexPath) as? C else {
			fatalError("Could not dequeue reusable cell with identifier \(C.reuseIdentifier)")
		}
		return cell
	}
}
