//
//  StoryboardInstantiatable.swift
//  MultiPageController
//
//  Created by Baby on 10/28/18.
//  Copyright © 2018 ridge. All rights reserved.
//

import UIKit

public protocol StoryboardInstantiatable {
	static var storyboard: UIStoryboard { get }
	static func instantiateFromStoryboard() -> Self
}

extension StoryboardInstantiatable where Self: UIViewController {
	public static var storyboard: UIStoryboard {
		let bundle = Bundle(for: Self.self)
		let storyboardName = String(describing: Self.self)
		return UIStoryboard(name: storyboardName, bundle: bundle)
	}

	public static func instantiateFromStoryboard() -> Self {
		guard let viewController = storyboard.instantiateInitialViewController() as? Self else {
			fatalError("Could not instantiate view controller: \(String(describing: Self.self)) from storyboard.")
		}

		return viewController
	}
}
