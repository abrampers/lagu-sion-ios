//
//  Unwrap.swift
//  LaguSion
//
//  Created by Abram Situmorang on 24/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import SwiftUI

struct Unwrap<Value, Content: View>: View {
    private let value: Value?
    private let contentProvider: (Value) -> Content

    init(_ value: Value?,
         @ViewBuilder content: @escaping (Value) -> Content) {
        self.value = value
        self.contentProvider = content
    }

    var body: some View {
        value.map(contentProvider)
    }
}
