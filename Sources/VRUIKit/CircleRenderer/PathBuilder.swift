//
//  PathHelper.swift
//  SOL
//
//  Created by Виталий Рамазанов on 20.12.2022.
//  Copyright © 2022 SOL. All rights reserved.
//

import UIKit

public protocol BuildsPath {
	func circlePath(centerPoint: CGPoint, size: CGSize, cornerRadius: CGFloat) -> UIBezierPath
	func combinedPath(firstPath: CGPath, secondPath: UIBezierPath) -> UIBezierPath
}

public final class PathBuilder: BuildsPath {
	
	public init() { }
	
	public func circlePath(
		centerPoint: CGPoint,
		size: CGSize,
		cornerRadius: CGFloat
	) -> UIBezierPath {
		UIBezierPath(
			roundedRect: CGRect(
				origin: CGPoint(
					x: centerPoint.x - size.width / 2,
					y: centerPoint.y - size.height / 2
				),
				size: size
			),
			cornerRadius: cornerRadius
		)
	}
	
	public func combinedPath(
		firstPath: CGPath,
		secondPath: UIBezierPath
	) -> UIBezierPath {
		let path = UIBezierPath(cgPath: firstPath)
		path.append(secondPath)
		return path
	}
}
