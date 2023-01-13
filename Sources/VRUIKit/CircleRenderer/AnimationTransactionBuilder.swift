//
//  AnimationTransactionBuilder.swift
//  SOL
//
//  Created by Виталий Рамазанов on 20.12.2022.
//  Copyright © 2022 SOL. All rights reserved.
//

import UIKit

public protocol BuildsAnimationTransaction {
	func transaction(body: (() -> Void)?, completion: (() -> Void)?)
}

public final class AnimationTransactionBuilder: BuildsAnimationTransaction {
	
	private let transactionMetaType: CATransaction.Type
	
	public init(transactionMetaType: CATransaction.Type = CATransaction.self) {
		self.transactionMetaType = transactionMetaType
	}
	
	public func transaction(body: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
		transactionMetaType.begin()
		transactionMetaType.setCompletionBlock(completion)
		body?()
		transactionMetaType.commit()
	}
}
