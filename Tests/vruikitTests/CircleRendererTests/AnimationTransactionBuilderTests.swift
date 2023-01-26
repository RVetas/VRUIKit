//
//  AnimationTransactionBuilderTests.swift
//  
//
//  Created by Виталий Рамазанов on 13.01.2023.
//

import UIKit
import XCTest
@testable import VRUIKit

final class AnimationTransactionBuilderTests: XCTestCase {
	func testTransaction() {
		// given
		let builder = AnimationTransactionBuilder(transactionMetaType: CATransactionMock.self)
		var bodyCounter = 0
		var completionCounter = 0
		let completionBlock: (() -> Void)? = { completionCounter += 1}
		// when
		builder.transaction(body: { bodyCounter += 1 }, completion: completionBlock)
		CATransactionMock.setCompletionBlockBlock?()
		// then
		XCTAssertEqual(bodyCounter, 1)
		XCTAssertEqual(completionCounter, 1)
		XCTAssertEqual(CATransactionMock.beginWasCalled, 1)
		XCTAssertEqual(CATransactionMock.setCompletionBlockWasCalled, 1)
		XCTAssertEqual(CATransactionMock.commitWasCalled, 1)
	}
}
