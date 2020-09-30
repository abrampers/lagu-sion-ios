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
    
    public let id: UUID
    public let number: Int
    public let title: String
    public let verses: [Verse]
    public let reff: Verse?
    public let songBook: SongBook
    
    private var _isFavorite: Bool
    public var isFavorite: Bool {
        get {
            _isFavorite
        }
        set {
            _isFavorite = newValue
        }
    }
    
    public init(id: UUID, number: Int, title: String, verses: [Verse], reff: Verse? = nil, songBook: SongBook) {
        self.id = id
        self.number = number
        self.title = title
        self.verses = verses
        self.reff = reff
        self.songBook = songBook
        
        // MARK: TODO get isFavorite data locally
        self._isFavorite = false
    }
    
    public init(pbSong: Lagusion_Song) {
        self.id = UUID(uuidString: pbSong.id.value)!
        self.number = Int(pbSong.number)
        self.title = pbSong.title
        self.verses = pbSong.verses.map { Verse(pbVerse: $0) }
        self.reff = Verse(pbVerse: pbSong.reff)
        self.songBook = SongBook.proto(pbSongBook: pbSong.book)
        
        // MARK: TODO get isFavorite data locally
        self._isFavorite = false
    }
}


