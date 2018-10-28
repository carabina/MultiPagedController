//
//  MultipageViewController.swift
//  MultiPageController
//
//  Created by Baby on 10/28/18.
//  Copyright © 2018 ridge. All rights reserved.
//

import UIKit

public final class MultipageViewController: UIViewController, StoryboardInstantiatable {

	// MARK: - Private Outlets

	@IBOutlet weak private var titleLabel: UILabel!
	@IBOutlet weak private var leftButton: UIButton!
	@IBOutlet weak private var rightButton: UIButton!
	@IBOutlet weak private var underlineView: UIView!
	@IBOutlet weak private var collectionView: UICollectionView!
	@IBOutlet weak private var buttonsContainer: UIStackView!

	private var mainTitle: String = ""
	private var viewControllers: [UIViewController] = []

	// MARK: - Parent Methods

	public override func viewDidLoad() {
        super.viewDidLoad()

		adjustAppearence()
		configureAppearence()
    }

	public override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		underlineView.frame.origin.y = buttonsContainer.frame.maxY
	}

	// MARK: - Public Methods

	public func setViewControllers(_ controllers: [UIViewController]) {
		viewControllers = Array(controllers[0..<2])
		adjustAppearence()

		collectionView?.reloadData()
	}

	public func setTitle(_ title: String) {
		mainTitle = title
		adjustAppearence()
	}

	public func scrollToLeftController(animated: Bool = true) {
		collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: animated)
	}

	public func scrollToRightController(animated: Bool = true) {
		collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .right, animated: animated)
	}

	// MARK: - Private Methods

	private func adjustAppearence() {
		titleLabel?.text = mainTitle

		leftButton?.setTitle(viewControllers.first?.title, for: .normal)
		rightButton?.setTitle(viewControllers.last?.title, for: .normal)
	}

	private func adjustScrollView(_ scrollView: UIScrollView) {
		let pageWidth = collectionView.bounds.width

		let cellToSwipe = (scrollView.contentOffset.x / pageWidth) + 0.5
		let newIndex = Int(cellToSwipe)
		collectionView.scrollToItem(at: IndexPath(row: newIndex, section: 0), at: .right, animated: true)
	}

	private func configureAppearence() {
		underlineView.frame = CGRect(origin: CGPoint(x: 0.0, y: buttonsContainer.frame.maxY),
									 size: CGSize(width: view.frame.width / 2, height: underlineView.frame.height))
	}

	// MARK: - Action Handlers

	@IBAction private func actionShowLeftController(_ sender: UIButton) {
		scrollToLeftController()
	}

	@IBAction private func actionShowRightController(_ sender: UIButton) {
		scrollToRightController()
	}
}

// MARK: - UIScrollViewDelegate

extension MultipageViewController {
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		adjustScrollView(scrollView)
	}

	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		adjustScrollView(scrollView)
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offset = scrollView.contentOffset.x >= 2 ? (scrollView.contentOffset.x/2) + buttonsContainer.spacing : 0
		self.underlineView.frame.origin.x = offset
	}
}

// MARK: - UICollectionViewDataSource

extension MultipageViewController: UICollectionViewDataSource {
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewControllers.count
	}

	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(FullScreenCell.self, for: indexPath)
		let controller = viewControllers[indexPath.row]
		cell.addOnContainer(controller.view)

		addChild(controller)
		controller.didMove(toParent: self)

		return cell
	}
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MultipageViewController: UICollectionViewDelegateFlowLayout {
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		let cell = collectionView.cellForItem(at: indexPath)
		cell?.layoutSubviews()
		return collectionView.frame.size
	}
}

public extension StoryboardInstantiatable where Self: MultipageViewController {

	public static func instantiate(withTitle title: String, andControllers controllers: [UIViewController]) -> Self {
		guard let viewController = storyboard.instantiateInitialViewController() as? Self else {
			fatalError("Could not instantiate view controller: \(String(describing: Self.self)) from storyboard.")
		}

		viewController.setTitle(title)
		viewController.setViewControllers(controllers)

		return viewController
	}
}
