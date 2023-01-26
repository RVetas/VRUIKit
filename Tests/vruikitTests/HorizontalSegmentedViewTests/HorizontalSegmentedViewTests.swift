//
//  HorizontalSegmentedViewTests.swift
//  
//
//  Created by Виталий Рамазанов on 26.01.2023.
//

import VRUIKit
import SnapshotTesting
import XCTest

final class HorizontalSegmentedViewTests: XCTestCase {
	var view: HorizontalSegmentedView!
	
	override func setUp() {
		view = HorizontalSegmentedView(frame: TestData.frame)
	}
	
	func testAppearanceBlackAndWhite() {
		// when
		view.configure(with: TestData.blackAndWhiteViewModel)
		// then
		assertSnapshot(matching: view, as: .image, record: false)
	}
	
	func testAppearanceColored() {
		// when
		view.configure(with: TestData.coloredViewModel)
		// then
		assertSnapshot(matching: view, as: .image, record: false)
	}
}

private extension HorizontalSegmentedViewTests {
	enum TestData {
		static let frame = CGRect(x: 0, y: 0, width: 200, height: 80)
		static let blackAndWhiteViewModel = HorizontalSegmentedView.ViewModel(
			segments: blackAndWhiteSegments,
			backgroundColor: .black
		)
		
		static let coloredViewModel = HorizontalSegmentedView.ViewModel(
			segments: coloredSegments,
			backgroundColor: .black
		)
		
		static let bigSegment = HorizontalSegmentedView.Segment(
			color: .white,
			heightMultiplier: 1
		)
		
		static let mediumSegment = HorizontalSegmentedView.Segment(
			color: .white,
			heightMultiplier: 0.6
		)
		
		static let smallSegment = HorizontalSegmentedView.Segment(
			color: .white,
			heightMultiplier: 0.2
		)
		
		static let blackAndWhiteSegments = [
			smallSegment,
			bigSegment,
			bigSegment,
			mediumSegment,
			smallSegment,
			smallSegment,
			bigSegment,
			smallSegment,
			mediumSegment,
			bigSegment,
			smallSegment,
			bigSegment,
			mediumSegment,
			bigSegment,
			smallSegment,
			mediumSegment,
			bigSegment,
			smallSegment,
			mediumSegment,
			bigSegment
		]
		
		static let coloredSegments = blackAndWhiteSegments.enumerated().map { idx, element in
			if idx % 3 == 0 {
				return HorizontalSegmentedView.Segment(color: .green, heightMultiplier: element.heightMultiplier)
			} else if idx % 2 == 0 {
				return HorizontalSegmentedView.Segment(color: .red, heightMultiplier: element.heightMultiplier)
			} else {
				return HorizontalSegmentedView.Segment(color: .blue, heightMultiplier: element.heightMultiplier)
			}
		}
	}
}
