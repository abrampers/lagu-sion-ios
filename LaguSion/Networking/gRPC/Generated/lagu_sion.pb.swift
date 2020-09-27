// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: LaguSion/Networking/gRPC/protobuf/lagu_sion.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

public enum Lagusion_SortOptions: SwiftProtobuf.Enum {
  public typealias RawValue = Int
  case number // = 0
  case alphabet // = 1
  case UNRECOGNIZED(Int)

  public init() {
    self = .number
  }

  public init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .number
    case 1: self = .alphabet
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  public var rawValue: Int {
    switch self {
    case .number: return 0
    case .alphabet: return 1
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Lagusion_SortOptions: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  public static var allCases: [Lagusion_SortOptions] = [
    .number,
    .alphabet,
  ]
}

#endif  // swift(>=4.2)

public struct Lagusion_UUID {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var value: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Lagusion_Verse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var id: Lagusion_UUID {
    get {return _id ?? Lagusion_UUID()}
    set {_id = newValue}
  }
  /// Returns true if `id` has been explicitly set.
  public var hasID: Bool {return self._id != nil}
  /// Clears the value of `id`. Subsequent reads from it will return its default value.
  public mutating func clearID() {self._id = nil}

  public var contents: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _id: Lagusion_UUID? = nil
}

public struct Lagusion_Book {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var id: UInt32 = 0

  public var shortName: String = String()

  public var longName: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Lagusion_Song {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var id: Lagusion_UUID {
    get {return _id ?? Lagusion_UUID()}
    set {_id = newValue}
  }
  /// Returns true if `id` has been explicitly set.
  public var hasID: Bool {return self._id != nil}
  /// Clears the value of `id`. Subsequent reads from it will return its default value.
  public mutating func clearID() {self._id = nil}

  public var number: UInt32 = 0

  public var title: String = String()

  public var verses: [Lagusion_Verse] = []

  public var reff: Lagusion_Verse {
    get {return _reff ?? Lagusion_Verse()}
    set {_reff = newValue}
  }
  /// Returns true if `reff` has been explicitly set.
  public var hasReff: Bool {return self._reff != nil}
  /// Clears the value of `reff`. Subsequent reads from it will return its default value.
  public mutating func clearReff() {self._reff = nil}

  public var book: Lagusion_Book {
    get {return _book ?? Lagusion_Book()}
    set {_book = newValue}
  }
  /// Returns true if `book` has been explicitly set.
  public var hasBook: Bool {return self._book != nil}
  /// Clears the value of `book`. Subsequent reads from it will return its default value.
  public mutating func clearBook() {self._book = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _id: Lagusion_UUID? = nil
  fileprivate var _reff: Lagusion_Verse? = nil
  fileprivate var _book: Lagusion_Book? = nil
}

public struct Lagusion_ListSongRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var bookID: UInt32 = 0

  public var sortOptions: Lagusion_SortOptions = .number

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Lagusion_ListSongResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var songs: [Lagusion_Song] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "lagusion"

extension Lagusion_SortOptions: SwiftProtobuf._ProtoNameProviding {
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "NUMBER"),
    1: .same(proto: "ALPHABET"),
  ]
}

extension Lagusion_UUID: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".UUID"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "value"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.value)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.value.isEmpty {
      try visitor.visitSingularStringField(value: self.value, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Lagusion_UUID, rhs: Lagusion_UUID) -> Bool {
    if lhs.value != rhs.value {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Lagusion_Verse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Verse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "contents"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._id)
      case 2: try decoder.decodeSingularStringField(value: &self.contents)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._id {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if !self.contents.isEmpty {
      try visitor.visitSingularStringField(value: self.contents, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Lagusion_Verse, rhs: Lagusion_Verse) -> Bool {
    if lhs._id != rhs._id {return false}
    if lhs.contents != rhs.contents {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Lagusion_Book: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Book"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .standard(proto: "short_name"),
    3: .standard(proto: "long_name"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularUInt32Field(value: &self.id)
      case 2: try decoder.decodeSingularStringField(value: &self.shortName)
      case 3: try decoder.decodeSingularStringField(value: &self.longName)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.id != 0 {
      try visitor.visitSingularUInt32Field(value: self.id, fieldNumber: 1)
    }
    if !self.shortName.isEmpty {
      try visitor.visitSingularStringField(value: self.shortName, fieldNumber: 2)
    }
    if !self.longName.isEmpty {
      try visitor.visitSingularStringField(value: self.longName, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Lagusion_Book, rhs: Lagusion_Book) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.shortName != rhs.shortName {return false}
    if lhs.longName != rhs.longName {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Lagusion_Song: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Song"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "number"),
    3: .same(proto: "title"),
    4: .same(proto: "verses"),
    5: .same(proto: "reff"),
    6: .same(proto: "book"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._id)
      case 2: try decoder.decodeSingularUInt32Field(value: &self.number)
      case 3: try decoder.decodeSingularStringField(value: &self.title)
      case 4: try decoder.decodeRepeatedMessageField(value: &self.verses)
      case 5: try decoder.decodeSingularMessageField(value: &self._reff)
      case 6: try decoder.decodeSingularMessageField(value: &self._book)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._id {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if self.number != 0 {
      try visitor.visitSingularUInt32Field(value: self.number, fieldNumber: 2)
    }
    if !self.title.isEmpty {
      try visitor.visitSingularStringField(value: self.title, fieldNumber: 3)
    }
    if !self.verses.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.verses, fieldNumber: 4)
    }
    if let v = self._reff {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    }
    if let v = self._book {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Lagusion_Song, rhs: Lagusion_Song) -> Bool {
    if lhs._id != rhs._id {return false}
    if lhs.number != rhs.number {return false}
    if lhs.title != rhs.title {return false}
    if lhs.verses != rhs.verses {return false}
    if lhs._reff != rhs._reff {return false}
    if lhs._book != rhs._book {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Lagusion_ListSongRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ListSongRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "book_id"),
    2: .standard(proto: "sort_options"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularUInt32Field(value: &self.bookID)
      case 2: try decoder.decodeSingularEnumField(value: &self.sortOptions)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.bookID != 0 {
      try visitor.visitSingularUInt32Field(value: self.bookID, fieldNumber: 1)
    }
    if self.sortOptions != .number {
      try visitor.visitSingularEnumField(value: self.sortOptions, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Lagusion_ListSongRequest, rhs: Lagusion_ListSongRequest) -> Bool {
    if lhs.bookID != rhs.bookID {return false}
    if lhs.sortOptions != rhs.sortOptions {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Lagusion_ListSongResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ListSongResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "songs"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedMessageField(value: &self.songs)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.songs.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.songs, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Lagusion_ListSongResponse, rhs: Lagusion_ListSongResponse) -> Bool {
    if lhs.songs != rhs.songs {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
