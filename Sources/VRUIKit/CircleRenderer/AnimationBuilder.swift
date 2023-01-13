//
//  AnimationTransactionWorker.swift
//  SOL
//
//  Created by Виталий Рамазанов on 20.12.2022.
//  Copyright © 2022 SOL. All rights reserved.
//

import UIKit

public protocol BuildsAnimation {
	func pathAnimation(
		fromPath: CGPath,
		toPath: CGPath,
		duration: CFTimeInterval,
		timingFunction: CAMediaTimingFunction?,
		beginTime: CFTimeInterval?
	) -> CABasicAnimation
}

public final class AnimationBuilder: BuildsAnimation {
	
	public init() { }
	
	public func pathAnimation(
		fromPath: CGPath,
		toPath: CGPath,
		duration: CFTimeInterval,
		timingFunction: CAMediaTimingFunction? = nil,
		beginTime: CFTimeInterval? = nil
	) -> CABasicAnimation {
		let animation = CABasicAnimation(keyPath: "path")
		animation.fromValue = fromPath
		animation.toValue = toPath
		animation.duration = duration
		beginTime.flatMap { animation.beginTime = $0 }
		animation.fillMode = .forwards
		animation.isRemovedOnCompletion = false
		timingFunction.flatMap { animation.timingFunction = $0 }
		return animation
	}
}
