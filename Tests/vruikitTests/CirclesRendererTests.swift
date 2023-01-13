//
//  CirclesRendererTests.swift
//  
//
//  Created by Виталий Рамазанов on 13.01.2023.
//

import UIKit
import XCTest

@testable import VRUIKit

final class CirclesRendererTests: XCTestCase {
	var pathBuilderMock = BuildsPathMock()
	var animationBuilderMock =  BuildsAnimationMock()
	var transactionBuilderMock = BuildsAnimationTransactionMock()
	
	var intermediateActionMock = HandlerMock()
	var completionMock = HandlerMock()
	
	override func setUp() {
		pathBuilderMock.circlePathStub = TestData.PathBuilder.stub
		pathBuilderMock.combinedPathStub = TestData.PathBuilder.stub
		animationBuilderMock.pathAnimationStub = CABasicAnimation()
	}

	func testDrawAnimatedCircle() {
		// given
		let renderer = CirclesRenderer(
			pathBuilder: pathBuilderMock,
			animationBuilder: animationBuilderMock,
			transactionBuilder: transactionBuilderMock
		)
		// when
		renderer.drawAnimatedCircle(
			request: TestData.request,
			intermediateAction: intermediateActionMock.action,
			completion: completionMock.action
		)
		// then
		XCTAssertEqual(pathBuilderMock.circlePathWasCalled, 2)
		XCTAssertEqual(pathBuilderMock.circlePathCenterPoint, TestData.PathBuilder.expectedCenterPoint)
		XCTAssertEqual(pathBuilderMock.circlePathSize, TestData.PathBuilder.expectedSize)
		XCTAssertEqual(pathBuilderMock.circlePathCornerRadius, TestData.PathBuilder.expectedCornerRadius)
		
		let shapeLayer = TestData.request.view.layer.sublayers!.first as! CAShapeLayer
		XCTAssertEqual(shapeLayer.path,pathBuilderMock.circlePathStub.cgPath)
		
		XCTAssertEqual(transactionBuilderMock.transactionWasCalled, 1)
		
		transactionBuilderMock.transactionBody?()
		XCTAssertEqual(animationBuilderMock.pathAnimationWasCalled, 1)
		XCTAssertEqual(animationBuilderMock.pathAnimationFromPath, TestData.PathBuilder.stub.cgPath)
		XCTAssertEqual(animationBuilderMock.pathAnimationToPath, TestData.PathBuilder.stub.cgPath)
		XCTAssertEqual(animationBuilderMock.pathAnimationDuration, 0.5)
		XCTAssertEqual(animationBuilderMock.pathAnimationTimingFunction, CAMediaTimingFunction(name: .easeIn))
		XCTAssertEqual(animationBuilderMock.pathAnimationBeginTime, nil)
		
		transactionBuilderMock.transactionCompletion?()
		XCTAssertEqual(intermediateActionMock.counter, 1)
		XCTAssertEqual(pathBuilderMock.combinedPathWasCalled, 2)
		XCTAssertEqual(pathBuilderMock.combinedPathFirstPath, [TestData.PathBuilder.stub.cgPath, TestData.PathBuilder.stub.cgPath])
		XCTAssertEqual(pathBuilderMock.combinedPathSecondPath, [TestData.PathBuilder.stub, TestData.PathBuilder.stub])
		
		transactionBuilderMock.transactionBody?()
		XCTAssertEqual(transactionBuilderMock.transactionWasCalled, 2)
		XCTAssertEqual((shapeLayer.mask as! CAShapeLayer).path, TestData.PathBuilder.stub.cgPath)
		XCTAssertEqual((shapeLayer.mask as! CAShapeLayer).fillRule, .evenOdd)
		XCTAssertEqual(animationBuilderMock.pathAnimationWasCalled, 2)
		XCTAssertEqual(animationBuilderMock.pathAnimationFromPath, TestData.PathBuilder.stub.cgPath)
		XCTAssertEqual(animationBuilderMock.pathAnimationToPath, TestData.PathBuilder.stub.cgPath)
		XCTAssertEqual(animationBuilderMock.pathAnimationDuration, 0.5)
		XCTAssertEqual(animationBuilderMock.pathAnimationTimingFunction, CAMediaTimingFunction(name: .easeOut))
		
		transactionBuilderMock.transactionCompletion?()
		XCTAssertEqual(completionMock.counter, 1)
		XCTAssertEqual(TestData.request.view.layer.sublayers, nil)
	}
}

private extension CirclesRendererTests {
	enum TestData {
		static let request = CircleRenderRequest(
			view: UIView(),
			centerPoint: .zero,
			startSize: .zero,
			targetSize: CGSize(width: 10, height: 10)
		)
		
		enum PathBuilder {
			static let stub = UIBezierPath()
			static let expectedCenterPoint = [request.centerPoint, request.centerPoint]
			static let expectedSize = [request.startSize, request.targetSize]
			static let expectedCornerRadius = [request.startSize.width / 2, request.targetSize.width / 2]
		}
	}
}
