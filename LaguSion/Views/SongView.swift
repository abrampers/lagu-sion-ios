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
    var isLaguSion: Bool
}

struct Verse: Identifiable {
    var id: UUID
    var contents: [String]
    
    init(contents: [String]) {
        self.id = UUID()
        self.contents = contents
    }
}

enum SongAction {
    case heartTapped
}

struct SongEnvironment {
    
}

let songReducer = Reducer<Song, SongAction, SongEnvironment> { state, action, environment in
    switch action {
    case .heartTapped:
        state.isFavorite.toggle()
        return .none
    }
}

struct SongView: View {
    let store: Store<Song, SongAction>
    let enableFavoriteButton: Bool
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .center, spacing: 10) {
                    HStack {
                        Spacer()
                        Text(viewStore.title)
                            .font(.system(size: 32, weight: .bold, design: .`default`))
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    Spacer()
                    ForEach(viewStore.verses) { verse in
                        ForEach(verse.contents) { (line) in
                            Text(line)
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
            .navigationBarTitle("\(viewStore.isLaguSion ? "LS" : "LSEL") no. \(viewStore.number)")
            .navigationBarItems(
                trailing: Button(action: { viewStore.send(.heartTapped) }) {
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
