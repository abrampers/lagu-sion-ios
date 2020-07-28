//
//  String+Extension.swift
//  Common
//
//  Created by Abram Situmorang on 28/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Foundation

extension String {
    public var localized: String {
        return NSLocalizedString(self, comment:"")
    }
}
