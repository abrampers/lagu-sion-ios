//
//  SongView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 21/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct Song: Equatable, Identifiable {
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: UUID
    var isFavorite: Bool
    var number: Int
    var title: String
    var verses: [Verse]
    var reff: Verse?
    var isLaguSion: Bool
}

struct Verse {
    var contents: [String]
}

enum SongAction {
    case heartTapped(Song)
    case removeFromFavorites(Song)
    case addToFavorites(Song)
}

struct SongEnvironment {
    
}

let songReducer = Reducer<Song, SongAction, SongEnvironment> { state, action, environment in
    switch action {
    case .heartTapped(let song):
        state.isFavorite.toggle()
        if state.isFavorite {
            return Effect(value: SongAction.addToFavorites(song))
        } else {
            return Effect(value: SongAction.removeFromFavorites(song))
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

private struct VersesView: View {
    let verses: [Verse]
    let reff: Verse?
    
    var body: some View {
        ForEach(0..<verses.count) { i in
            Text("\(i + 1)")
                .font(.system(.headline))
            ForEach(0..<self.verses[i].contents.count) { (j) in
                Text(self.verses[i].contents[j])
            }
            Spacer()
            Unwrap(self.reff) { (reff) in
                ForEach(0..<reff.contents.count) { (k) in
                    Text(reff.contents[k])
                }
            }
            Spacer()
        }
    }
}

struct SongView: View {
    let store: Store<Song, SongAction>
    let enableFavoriteButton: Bool
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .center, spacing: 10) {
                    Spacer()
                    TitleView(title: viewStore.title)
                    Spacer()
                    VersesView(verses: viewStore.verses, reff: viewStore.reff)
                    Spacer()
                }
            }
            .navigationBarTitle("\(viewStore.isLaguSion ? "LS" : "LSEL") no. \(viewStore.number)")
            .navigationBarItems(
                trailing: Button(action: { viewStore.send(.heartTapped(viewStore.state)) }) {
                    Image(systemName: viewStore.isFavorite ? "heart.fill" : "heart")
                }
                .disabled(!self.enableFavoriteButton)
            )
        }
    }
}

struct SongTabView: View {
    let store: Store<Song, SongAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            HStack {
                Text("\(viewStore.number)")
                Text(viewStore.title)
            }
        }
    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongView(
            store: Store(
                initialState: Song(
                    id: UUID(),
                    isFavorite: false,
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
                    ], isLaguSion: true
                ),
                reducer: songReducer,
                environment: SongEnvironment()),
            enableFavoriteButton: true
        )
    }
}
