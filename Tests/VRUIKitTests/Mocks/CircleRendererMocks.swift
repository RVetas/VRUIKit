//
//  CircleRendererMocks.swift
//  
//
//  Created by Виталий Рамазанов on 13.01.2023.
//

import UIKit
import VRUIKit

final class CATransactionMock: CATransaction {
	
	// MARK: - begin
	
	private(set) static var beginWasCalled = 0
	
	override static func begin() {
		beginWasCalled += 1
	}
	
	// MARK: - setCompletionBlock
	
	private(set) static var setCompletionBlockWasCalled = 0
	private(set) static var setCompletionBlockBlock: (() -> Void)?
	
	override static func setCompletionBlock(_ block: (() -> Void)?) {
		setCompletionBlockWasCalled += 1
		setCompletionBlockBlock = block
	}
	
	// MARK: - commit
	
	private(set) static var commitWasCalled = 0
	
	override static func commit() {
		commitWasCalled += 1
	}
	
	// MARK: - reset
	
	static func reset() {
		beginWasCalled = 0
		
		setCompletionBlockWasCalled = 0
		setCompletionBlockBlock = nil
		
		commitWasCalled = 0
	}
}

final class BuildsAnimationTransactionMock: BuildsAnimationTransaction {
	
	// MARK: - transaction
	
	private(set) var transactionWasCalled = 0
	private(set) var transactionBody: (() -> Void)?
	private(set) var transactionCompletion: (() -> Void)?
	
	public func transaction(body: (() -> Void)?, completion: (() -> Void)?) {
		transactionWasCalled += 1
		transactionBody = body
		transactionCompletion = completion
	}
}


final class BuildsAnimationMock: BuildsAnimation {
	
	// MARK: - pathAnimation
	
	private(set) var pathAnimationWasCalled = 0
	private(set) var pathAnimationFromPath: CGPath!
	private(set) var pathAnimationToPath: CGPath!
	private(set) var pathAnimationDuration: CFTimeInterval!
	private(set) var pathAnimationTimingFunction: CAMediaTimingFunction?
	private(set) var pathAnimationBeginTime: CFTimeInterval?
	var pathAnimationStub: CABasicAnimation!
	
	func pathAnimation(
		fromPath: CGPath,
		toPath: CGPath,
		duration: CFTimeInterval,
		timingFunction: CAMediaTimingFunction?,
		beginTime: CFTimeInterval?
	) -> CABasicAnimation {
		pathAnimationWasCalled += 1
		pathAnimationFromPath = fromPath
		pathAnimationToPath = toPath
		pathAnimationDuration = duration
		pathAnimationTimingFunction = timingFunction
		pathAnimationBeginTime = beginTime
		
		return pathAnimationStub
	}
}

final class BuildsPathMock: BuildsPath {
	
	// MARK: - circlePath
	
	private(set) var circlePathWasCalled = 0
	private(set) var circlePathCenterPoint: [CGPoint] = []
	private(set) var circlePathSize: [CGSize] = []
	private(set) var circlePathCornerRadius: [CGFloat] = []
	var circlePathStub: UIBezierPath!
	
	func circlePath(centerPoint: CGPoint, size: CGSize, cornerRadius: CGFloat) -> UIBezierPath {
		circlePathWasCalled += 1
		circlePathCenterPoint.append(centerPoint)
		circlePathSize.append(size)
		circlePathCornerRadius.append(cornerRadius)
		
		return circlePathStub
	}
	
	// MARK: - combinedPath
	
	private(set) var combinedPathWasCalled = 0
	private(set) var combinedPathFirstPath: [CGPath] = []
	private(set) var combinedPathSecondPath: [UIBezierPath] = []
	var combinedPathStub: UIBezierPath!
	
	func combinedPath(firstPath: CGPath, secondPath: UIBezierPath) -> UIBezierPath {
		combinedPathWasCalled += 1
		combinedPathFirstPath.append(firstPath)
		combinedPathSecondPath.append(secondPath)
		
		return combinedPathStub
	}
}

final class HandlerMock {
	var counter = 0
	
	func action() {
		counter += 1
	}
}
