//
//  AnimationBuilderTests.swift
//  
//
//  Created by Виталий Рамазанов on 13.01.2023.
//

import UIKit
import XCTest
@testable import VRUIKit

final class AnimationBuilderTests: XCTestCase {
	func testPathAnimation() {
		// when
		let result = AnimationBuilder().pathAnimation(
			fromPath: TestData.fromPath,
			toPath: TestData.toPath,
			duration: TestData.duration,
			timingFunction: TestData.timingFunction,
			beginTime: TestData.beginTime
		)
		// then
		XCTAssertEqual(result.keyPath, TestData.expectedAnimation.keyPath)
		XCTAssertEqual(result.fromValue as! CGPath, TestData.expectedAnimation.fromValue as! CGPath)
		XCTAssertEqual(result.toValue as! CGPath, TestData.expectedAnimation.toValue as! CGPath)
		XCTAssertEqual(result.duration, TestData.expectedAnimation.duration)
		XCTAssertEqual(result.beginTime, TestData.expectedAnimation.beginTime)
		XCTAssertEqual(result.fillMode, TestData.expectedAnimation.fillMode)
		XCTAssertEqual(result.isRemovedOnCompletion, TestData.expectedAnimation.isRemovedOnCompletion)
		XCTAssertEqual(result.timingFunction, TestData.expectedAnimation.timingFunction)
		
	}
}

private extension AnimationBuilderTests {
	enum TestData {
		static let fromRect = CGRect(x: 10, y: 10, width: 20, height: 20)
		static let fromPath = CGPath(rect: fromRect, transform: nil)
		
		static let toRect = CGRect(x: 20, y: 20, width: 30, height: 30)
		static let toPath = CGPath(rect: toRect, transform: nil)
		
		static let duration: CFTimeInterval = 1
		static let timingFunction = CAMediaTimingFunction(name: .easeIn)
		static let beginTime: CFTimeInterval = 1
		
		static let expectedAnimation = {
			let animation = CABasicAnimation(keyPath: "path")
			animation.fromValue = fromPath
			animation.toValue = toPath
			animation.duration = duration
			animation.beginTime = beginTime
			animation.fillMode = .forwards
			animation.isRemovedOnCompletion = false
			animation.timingFunction = timingFunction
			return animation
		}()
	}
}
