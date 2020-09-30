//
//  LaguSionError.swift
//  DataSource
//
//  Created by Abram Perdanaputra on 30/09/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

public final class LaguSionError: Error {
    public let code: Code
    public let message: String?
    
    public init(code: Code, message: String?) {
        self.code = code
        self.message = message
    }
}

extension LaguSionError {
    public enum Code {
        case grpcError
        case unknownError
    }
}

extension LaguSionError: Equatable {
    public static func == (lhs: LaguSionError, rhs: LaguSionError) -> Bool {
        return lhs.code == rhs.code && lhs.message == rhs.message
    }
}
