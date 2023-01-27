//
//  HorizontalSegmentedView.swift
//  
//
//  Created by Виталий Рамазанов on 26.01.2023.
//

import UIKit
import SnapKit

public final class HorizontalSegmentedView: UIView {
	
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
		public let spacing: CGFloat
		public let segmentRadius: CGFloat
		
		public init(segments: [Segment], backgroundColor: UIColor, spacing: CGFloat, segmentRadius: CGFloat) {
			self.segments = segments
			self.backgroundColor = backgroundColor
			self.spacing = spacing
			self.segmentRadius = segmentRadius
		}
	}
	
	private lazy var segmentedStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.alignment = .center
		return stackView
	}()
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubviews()
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		super.init(frame: .zero)
		
		addSubviews()
		makeConstraints()
	}
	
	public func configure(with viewModel: ViewModel) {
		backgroundColor = viewModel.backgroundColor
		segmentedStackView.backgroundColor = viewModel.backgroundColor
		segmentedStackView.spacing = viewModel.spacing
		
		segmentedStackView.subviews.forEach { $0.removeFromSuperview() }
		for segment in viewModel.segments {
			let segmentView = UIView()
			segmentView.layer.cornerRadius = viewModel.segmentRadius
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
			$0.edges.equalToSuperview()
		}
	}
}
