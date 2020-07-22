//
//  SongView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 21/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import Networking
import SwiftUI

public enum SongBook: CaseIterable, Hashable {
    public var songPrefix: String {
        switch self {
        case .laguSion:
            return "LS"
        case .laguSionEdisiLengkap:
            return "LSEL"
        }
    }
    
    public var proto: Lagusion_SongBook {
        switch self {
        case .laguSion:
            return .laguSion
        case .laguSionEdisiLengkap:
            return .laguSionEdisiLengkap
        }
    }
    
    public var localizedSongPrefix: LocalizedStringKey {
        switch self {
        case .laguSion:
            return "LS"
        case .laguSionEdisiLengkap:
            return "LSEL"
        }
    }
    
    public static func proto(pbSongBook: Lagusion_SongBook) -> SongBook {
        switch pbSongBook {
        case .laguSion:
            return .laguSion
        case .laguSionEdisiLengkap:
            return .laguSionEdisiLengkap
        default:
            // MARK: TODO do some workaround if there's unexpected songbook
            return .laguSion
        }
    }
    
    case laguSion
    case laguSionEdisiLengkap
}

public struct Song: Equatable, Identifiable {
    public static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id
    }
    
    public var id: UInt32
    public var isFavorite: Bool
    var number: Int
    var title: String
    var verses: [Verse]
    var reff: Verse?
    var songBook: SongBook
    
    public init(id: UInt32, number: Int, title: String, verses: [Verse], reff: Verse? = nil, songBook: SongBook) {
        self.id = id
        self.isFavorite = false
        self.number = number
        self.title = title
        self.verses = verses
        self.reff = reff
        self.songBook = songBook
    }
    
    public init(pbSong: Lagusion_Song) {
        self.id = pbSong.id
        self.number = Int(pbSong.number)
        self.title = pbSong.title
        self.verses = pbSong.verses.map { Verse(pbVerse: $0) }
        self.reff = Verse(pbVerse: pbSong.reff)
        self.songBook = SongBook.proto(pbSongBook: pbSong.songBook)
        
        // MARK: TODO get isFavorite data locally
        self.isFavorite = false
    }
}

public struct Verse {
    var contents: [String]
    
    public init(contents: [String]) {
        self.contents = contents
    }
    
    public init(pbVerse: Lagusion_Verse) {
        self.contents = pbVerse.contents
    }
}

public enum SongAction {
    case heartTapped
    case removeFromFavorites(Song)
    case addToFavorites(Song)
}

public struct SongEnvironment {
    public init() {}
}

public let songReducer = Reducer<Song, SongAction, SongEnvironment> { state, action, environment in
    switch action {
    case .heartTapped:
        state.isFavorite.toggle()
        if state.isFavorite {
            return Effect(value: SongAction.addToFavorites(state))
        } else {
            return Effect(value: SongAction.removeFromFavorites(state))
        }
    case .addToFavorites(_), .removeFromFavorites(_):
        return .none
    }
}

private struct TitleView: View {
    let title: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .font(.system(size: 32, weight: .bold, design: .`default`))
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}

private struct VerseView: View {
    let verse: Verse
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            ForEach(0..<self.verse.contents.count) { (j) in
                Text(self.verse.contents[j])
            }
        }
    }
}

public struct SongView: View {
    private let store: Store<Song, SongAction>
    private let enableFavoriteButton: Bool
    
    public init(store: Store<Song, SongAction>, enableFavoriteButton: Bool) {
        self.store = store
        self.enableFavoriteButton = enableFavoriteButton
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .center, spacing: 10) {
                    Spacer()
                    TitleView(title: viewStore.title)
                    Spacer()
                    ForEach(0..<viewStore.verses.count) { i in
                        Text("\(i + 1)")
                            .font(.system(.headline))
                        VerseView(verse: viewStore.verses[i])
                        Unwrap(viewStore.reff) { reff in
                            Spacer()
                            VerseView(verse: reff)
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
            .navigationBarTitle("\(viewStore.songBook.songPrefix) no. \(viewStore.number)")
            .navigationBarItems(
                trailing: Button(action: { viewStore.send(.heartTapped) }) {
                    Image(systemName: viewStore.isFavorite ? "heart.fill" : "heart")
                }
                .disabled(!self.enableFavoriteButton)
            )
        }
    }
}

public struct SongRowView: View {
    private let store: Store<Song, SongAction>
    
    public init(store: Store<Song, SongAction>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            HStack {
                Text("\(viewStore.number)")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                Text(viewStore.title)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
        }
    }
}

internal struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongView(
            store: Store(
                initialState: Song(
                    id: 1,
                    number: 1,
                    title: "Di Hadapan Hadirat-Mu",
                    verses: [
                        Verse(contents: [
                            "Di hadapan hadirat-Mu",
                            "Kami umat-Mu menyembah",
                            "Mengakui Engkau Tuhan",
                            "Allah kekal, Maha kuasa"
                        ]),
                        Verse(contents: [
                            "Dari debu dan tanahlah",
                            "kita dijadikan Tuhan",
                            "Dan bila tersesat kita",
                            "Tuhan tak akan tinggalkan",
                        ]),
                        Verse(contents: [
                            "Kuasa serta kasih Allah",
                            "Memenuhi seg’nap dunia",
                            "Tetap teguhlah firman-Nya",
                            "Hingga penuh hadirat-Nya",
                        ]),
                        Verse(contents: [
                            "Di pintu Surga yang suci",
                            "menyanyi beribu lidah",
                            "Pada Tuhan kita puji",
                            "Sekarang dan selamanya",
                        ])
                    ], songBook: .laguSion
                ),
                reducer: songReducer,
                environment: SongEnvironment()),
            enableFavoriteButton: true
        )
    }
}
