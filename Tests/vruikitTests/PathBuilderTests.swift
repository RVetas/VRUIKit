//
//  PathBuilderTests.swift
//  
//
//  Created by Виталий Рамазанов on 13.01.2023.
//

import XCTest
import UIKit
import Foundation
import SnapshotTesting

@testable import VRUIKit

final class PathBuilderTests: XCTestCase {
	func testCirclePath() {
		// when
		let result = PathBuilder().circlePath(
			centerPoint: TestData.CirclePath.centerPoint,
			size: TestData.CirclePath.size,
			cornerRadius: TestData.CirclePath.cornerRadius
		)
		// then
		XCTAssertEqual(result, TestData.CirclePath.expectedResult)
	}
	
	func testCombinedPath() {
		// when
		let result = PathBuilder().combinedPath(
			firstPath: TestData.CombinedPath.firstPath,
			secondPath: TestData.CombinedPath.secondPath
		)
		// then
		XCTAssertEqual(result, TestData.CombinedPath.expectedResult)
	}
}

private extension PathBuilderTests {
	enum TestData {
		enum CirclePath {
			static let centerPoint = CGPoint(x: 100, y: 100)
			static let size = CGSize(width: 30, height: 30)
			static let cornerRadius: CGFloat = 5
			
			static let expectedResult = UIBezierPath(
				roundedRect: CGRect(
					origin: CGPoint(
						x: 85,
						y: 85
					),
					size: size
				),
				cornerRadius: cornerRadius
			)
		}
		
		enum CombinedPath {
			static let firstPath = CGPath(ellipseIn: CGRect(x: 15, y: 15, width: 20, height: 20), transform: nil)
			static let secondPath = UIBezierPath()
			
			static let expectedResult = {
				let path = UIBezierPath(cgPath: firstPath)
				path.append(secondPath)
				return path
			}()
		}
	}
}
