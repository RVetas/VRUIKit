//
//  CirclesRenderer.swift
//  SOL
//
//  Created by Виталий Рамазанов on 20.12.2022.
//  Copyright © 2022 SOL. All rights reserved.
//

import UIKit

public struct CircleRenderRequest {
	public let view: UIView
	public let centerPoint: CGPoint
	public let startSize: CGSize
	public let targetSize: CGSize
	
	public init(view: UIView, centerPoint: CGPoint, startSize: CGSize, targetSize: CGSize) {
		self.view = view
		self.centerPoint = centerPoint
		self.startSize = startSize
		self.targetSize = targetSize
	}
}

public protocol RendersCircles {
	func drawAnimatedCircle(
		request: CircleRenderRequest,
		intermediateAction: (() -> Void)?,
		completion: (() -> Void)?
	)
}

public final class CirclesRenderer: RendersCircles {
	private let pathBuilder: BuildsPath
	private let animationBuilder: BuildsAnimation
	private let transactionBuilder: BuildsAnimationTransaction
	
	public init(
		pathBuilder: BuildsPath = PathBuilder(),
		animationBuilder: BuildsAnimation = AnimationBuilder(),
		transactionBuilder: BuildsAnimationTransaction = AnimationTransactionBuilder()
	) {
		self.pathBuilder = pathBuilder
		self.animationBuilder = animationBuilder
		self.transactionBuilder = transactionBuilder
	}
	
	public func drawAnimatedCircle(
		request: CircleRenderRequest,
		intermediateAction: (() -> Void)?,
		completion: (() -> Void)?
	) {
		let startPath = pathBuilder.circlePath(
			centerPoint: request.centerPoint,
			size: request.startSize,
			cornerRadius: request.startSize.width / 2
		)
		let targetPath = pathBuilder.circlePath(
			centerPoint: request.centerPoint,
			size: request.targetSize,
			cornerRadius: request.targetSize.width / 2
		)
		let circleLayer = CAShapeLayer()
		circleLayer.path = startPath.cgPath
		request.view.layer.addSublayer(circleLayer)

		transactionBuilder.transaction(
			body: { [weak self] in
				guard let self else { return }
				circleLayer.add(
					self.animationBuilder.pathAnimation(
						fromPath: startPath.cgPath,
						toPath: targetPath.cgPath,
						duration: 0.5,
						timingFunction: CAMediaTimingFunction(name: .easeIn),
						beginTime: nil
					),
					forKey: "VR.circle.path.animation"
				)
			},
			completion: { [weak self] in
				guard let self else { return }
				intermediateAction?()
				self.drawAnimatedMask(
					circleLayer: circleLayer,
					startPath: startPath,
					targetPath: targetPath,
					completion: completion
				)
			}
		)
	}
	
	private func drawAnimatedMask(
		circleLayer: CAShapeLayer,
		startPath: UIBezierPath,
		targetPath: UIBezierPath,
		completion: (() -> Void)? = nil
	) {
		// Создаем путь, с которого маска должна начинаться
		let startMaskPath = pathBuilder.combinedPath(
			firstPath: targetPath.cgPath,
			secondPath: startPath
		)
		// Создаём путь, которым маска должна заканчиваться
		let targetMaskPath = pathBuilder.combinedPath(
			firstPath: targetPath.cgPath,
			secondPath: targetPath
		)
		// Создаём маску
		let mask = CAShapeLayer()
		mask.path = startMaskPath.cgPath
		mask.fillRule = .evenOdd

		transactionBuilder.transaction(
			body: { [weak self] in
				guard let self else { return }
				circleLayer.mask = mask
				mask.add(
					self.animationBuilder.pathAnimation(
						fromPath: startMaskPath.cgPath,
						toPath: targetMaskPath.cgPath,
						duration: 0.5,
						timingFunction: CAMediaTimingFunction(name: .easeOut),
						beginTime: CACurrentMediaTime()
					),
					forKey: "VR.mask.path.animation"
				)
			},
			completion: { [weak circleLayer] in
				completion?()
				circleLayer?.removeFromSuperlayer()
				circleLayer?.mask = nil
			}
		)
	}
}
