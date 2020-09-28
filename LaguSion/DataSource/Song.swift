//
//  Song.swift
//  Datasource
//
//  Created by Abram Situmorang on 27/09/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Foundation
import Networking

public struct Song: Equatable, Identifiable {
    public static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id
    }
    
    private var _id: UUID
    private var _isFavorite: Bool
    private var _number: Int
    private var _title: String
    private var _verses: [Verse]
    private var _reff: Verse?
    private var _songBook: SongBook
    
    public var id: UUID {
        get {
            return _id
        }
    }
    
    public var isFavorite: Bool {
        get {
            return _isFavorite
        }
        set {
            _isFavorite = newValue
        }
    }
    
    public var songBook: SongBook {
        get {
            return _songBook
        }
    }
    
    public var title: String {
        get {
            return _title
        }
    }
    
    public var verses: [Verse] {
        get {
            return _verses
        }
    }
    
    public var number: Int {
        get {
            return _number
        }
    }
    
    public var reff: Verse? {
        get {
            return _reff
        }
    }
    
    public init(id: UUID, number: Int, title: String, verses: [Verse], reff: Verse? = nil, songBook: SongBook) {
        self._id = id
        self._isFavorite = false
        self._number = number
        self._title = title
        self._verses = verses
        self._reff = reff
        self._songBook = songBook
    }
    
    public init(pbSong: Lagusion_Song) {
        self._id = UUID(uuidString: pbSong.id.value)!
        self._number = Int(pbSong.number)
        self._title = pbSong.title
        self._verses = pbSong.verses.map { Verse(pbVerse: $0) }
        self._reff = Verse(pbVerse: pbSong.reff)
        self._songBook = SongBook.proto(pbSongBook: pbSong.book)
        
        // MARK: TODO get isFavorite data locally
        self._isFavorite = false
    }
}


