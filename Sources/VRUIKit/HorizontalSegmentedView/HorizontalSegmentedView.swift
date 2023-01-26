//
//  HorizontalSegmentedView.swift
//  
//
//  Created by Виталий Рамазанов on 26.01.2023.
//

import UIKit
import SnapKit

public final class HorizontalSegmentedView: UIView {

	private enum Configuration {
		static let stackInset: CGFloat = 8
		static let segmentRadius: CGFloat = 4
		static let spacing: CGFloat = 2
	}
	
	public struct Segment {
		public let color: UIColor
		public let heightMultiplier: Double
		
		public init(
			color: UIColor,
			heightMultiplier: CGFloat
		) {
			self.color = color
			self.heightMultiplier = heightMultiplier
		}
	}
	
	public struct ViewModel {
		public let segments: [Segment]
		public let backgroundColor: UIColor
		
		public init(
			segments: [Segment],
			backgroundColor: UIColor
		) {
			self.segments = segments
			self.backgroundColor = backgroundColor
		}
	}
	
	private lazy var segmentedStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.alignment = .center
		stackView.spacing = Configuration.spacing
		return stackView
	}()
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubviews()
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func configure(with viewModel: ViewModel) {
		backgroundColor = viewModel.backgroundColor
		segmentedStackView.backgroundColor = viewModel.backgroundColor
		
		segmentedStackView.subviews.forEach { $0.removeFromSuperview() }
		for segment in viewModel.segments {
			let segmentView = UIView()
			segmentView.layer.cornerRadius = Configuration.segmentRadius
			segmentView.backgroundColor = segment.color
			segmentedStackView.addArrangedSubview(segmentView)
			segmentView.snp.makeConstraints {
				$0.height.equalToSuperview().multipliedBy(segment.heightMultiplier)
			}
		}
	}
}

private extension HorizontalSegmentedView {
	func addSubviews() {
		addSubview(segmentedStackView)
	}
	
	func makeConstraints() {
		segmentedStackView.snp.makeConstraints {
			$0.edges.equalToSuperview().inset(Configuration.stackInset)
		}
	}
}
