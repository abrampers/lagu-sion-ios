// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: lagu_sion.proto
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

enum Lagusion_SongBook: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case all // = 0
  case laguSion // = 1
  case laguSionEdisiLengkap // = 2
  case UNRECOGNIZED(Int)

  init() {
    self = .all
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .all
    case 1: self = .laguSion
    case 2: self = .laguSionEdisiLengkap
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .all: return 0
    case .laguSion: return 1
    case .laguSionEdisiLengkap: return 2
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Lagusion_SongBook: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Lagusion_SongBook] = [
    .all,
    .laguSion,
    .laguSionEdisiLengkap,
  ]
}

#endif  // swift(>=4.2)

struct Lagusion_UUID {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var value: Data = SwiftProtobuf.Internal.emptyData

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Lagusion_Verse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var contents: [String] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Lagusion_Song {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: Lagusion_UUID {
    get {return _id ?? Lagusion_UUID()}
    set {_id = newValue}
  }
  /// Returns true if `id` has been explicitly set.
  var hasID: Bool {return self._id != nil}
  /// Clears the value of `id`. Subsequent reads from it will return its default value.
  mutating func clearID() {self._id = nil}

  var number: Int32 = 0

  var title: String = String()

  var verses: [Lagusion_Verse] = []

  var reff: Lagusion_Verse {
    get {return _reff ?? Lagusion_Verse()}
    set {_reff = newValue}
  }
  /// Returns true if `reff` has been explicitly set.
  var hasReff: Bool {return self._reff != nil}
  /// Clears the value of `reff`. Subsequent reads from it will return its default value.
  mutating func clearReff() {self._reff = nil}

  var songBook: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _id: Lagusion_UUID? = nil
  fileprivate var _reff: Lagusion_Verse? = nil
}

struct Lagusion_ListSongsRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var songBook: Lagusion_SongBook = .all

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Lagusion_ListSongResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var songs: Lagusion_Song {
    get {return _songs ?? Lagusion_Song()}
    set {_songs = newValue}
  }
  /// Returns true if `songs` has been explicitly set.
  var hasSongs: Bool {return self._songs != nil}
  /// Clears the value of `songs`. Subsequent reads from it will return its default value.
  mutating func clearSongs() {self._songs = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _songs: Lagusion_Song? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "lagusion"

extension Lagusion_SongBook: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "ALL"),
    1: .same(proto: "LAGU_SION"),
    2: .same(proto: "LAGU_SION_EDISI_LENGKAP"),
  ]
}

extension Lagusion_UUID: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".UUID"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "value"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularBytesField(value: &self.value)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.value.isEmpty {
      try visitor.visitSingularBytesField(value: self.value, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Lagusion_UUID, rhs: Lagusion_UUID) -> Bool {
    if lhs.value != rhs.value {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Lagusion_Verse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Verse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "contents"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedStringField(value: &self.contents)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.contents.isEmpty {
      try visitor.visitRepeatedStringField(value: self.contents, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Lagusion_Verse, rhs: Lagusion_Verse) -> Bool {
    if lhs.contents != rhs.contents {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Lagusion_Song: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Song"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "number"),
    3: .same(proto: "title"),
    4: .same(proto: "verses"),
    5: .same(proto: "reff"),
    6: .standard(proto: "song_book"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._id)
      case 2: try decoder.decodeSingularInt32Field(value: &self.number)
      case 3: try decoder.decodeSingularStringField(value: &self.title)
      case 4: try decoder.decodeRepeatedMessageField(value: &self.verses)
      case 5: try decoder.decodeSingularMessageField(value: &self._reff)
      case 6: try decoder.decodeSingularStringField(value: &self.songBook)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._id {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if self.number != 0 {
      try visitor.visitSingularInt32Field(value: self.number, fieldNumber: 2)
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
    if !self.songBook.isEmpty {
      try visitor.visitSingularStringField(value: self.songBook, fieldNumber: 6)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Lagusion_Song, rhs: Lagusion_Song) -> Bool {
    if lhs._id != rhs._id {return false}
    if lhs.number != rhs.number {return false}
    if lhs.title != rhs.title {return false}
    if lhs.verses != rhs.verses {return false}
    if lhs._reff != rhs._reff {return false}
    if lhs.songBook != rhs.songBook {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Lagusion_ListSongsRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".ListSongsRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "song_book"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularEnumField(value: &self.songBook)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.songBook != .all {
      try visitor.visitSingularEnumField(value: self.songBook, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Lagusion_ListSongsRequest, rhs: Lagusion_ListSongsRequest) -> Bool {
    if lhs.songBook != rhs.songBook {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Lagusion_ListSongResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".ListSongResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "songs"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._songs)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._songs {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Lagusion_ListSongResponse, rhs: Lagusion_ListSongResponse) -> Bool {
    if lhs._songs != rhs._songs {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}