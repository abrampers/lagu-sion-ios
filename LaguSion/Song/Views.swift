//
//  Views.swift
//  Song
//
//  Created by Abram Situmorang on 31/07/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Common
import ComposableArchitecture
import SwiftUI

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
            .navigationBarTitle(Text("\(viewStore.songBook.prefix) no. \(viewStore.number)"))
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
                    id: UUID(),
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
