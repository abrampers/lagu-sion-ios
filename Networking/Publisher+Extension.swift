//
//  Publisher+Extension.swift
//  LaguSion
//
//  Created by Abram Situmorang on 11/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Combine

extension Publisher where Self.Failure == Never {
    public func assignNoRetain<Root>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>, on object: Root) -> AnyCancellable where Root: AnyObject {
        sink { [weak object] (value) in
        object?[keyPath: keyPath] = value
    }
  }
}
