//
//  SceneDelegate.swift
//  LaguSion
//
//  Created by Abram Situmorang on 10/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import CombineGRPC
import GRPC
import Networking
import NIO
import Song

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let eventLoopGroup: EventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let channel: ClientConnection = ClientConnection
            .insecure(group: eventLoopGroup)
            .connect(host: Constants.laguSionHost, port: Constants.laguSionPort)
        let contentView = RootView(store: Store(
            initialState: AppState(
                songs: []
//                songs: [
//                    Song(
//                        id: 1,
//                        number: 1,
//                        title: "Di Hadapan Hadirat-Mu",
//                        verses: [
//                            Verse(contents: [
//                                "Di hadapan hadirat-Mu",
//                                "Kami umat-Mu menyembah",
//                                "Mengakui Engkau Tuhan",
//                                "Allah kekal, Maha kuasa"
//                            ]),
//                            Verse(contents: [
//                                "Dari debu dan tanahlah",
//                                "kita dijadikan Tuhan",
//                                "Dan bila tersesat kita",
//                                "Tuhan tak akan tinggalkan",
//                            ]),
//                            Verse(contents: [
//                                "Kuasa serta kasih Allah",
//                                "Memenuhi seg’nap dunia",
//                                "Tetap teguhlah firman-Nya",
//                                "Hingga penuh hadirat-Nya",
//                            ]),
//                            Verse(contents: [
//                                "Di pintu Surga yang suci",
//                                "menyanyi beribu lidah",
//                                "Pada Tuhan kita puji",
//                                "Sekarang dan selamanya",
//                            ])
//                        ], songBook: .laguSion
//                    ),
//                    Song(
//                        id: 2,
//                        number: 2,
//                        title: "Hai Seg'nap Ciptaan Tuhan",
//                        verses: [
//                            Verse(contents: [
//                                "Hai seg’nap ciptaan Tuhan",
//                                "Nyanyikan lagu pujian",
//                                "Puji Tuhan, Haleluya",
//                                "Pancaran sinar mentari",
//                                "Cahaya bulan berseri"
//                            ]),
//                            Verse(contents: [
//                                "Desiran angin menghembus",
//                                "Awan bergulung menembus",
//                                "Puji Tuhan, Haleluya",
//                                "Di kala fajar merekah",
//                                "Dan waktu senja nyanyilah"
//                            ]),
//                            Verse(contents: [
//                                "Aliran air yang jernih",
//                                "Menyanyikan lagu kasih",
//                                "Puji Tuhan, Haleluya",
//                                "Bagai api yang membara",
//                                "Dan menghangatkan udara"
//                            ]),
//                            Verse(contents: [
//                                "Sembah sujudlah pada-Nya",
//                                "Datang dan t’rima berkat-Nya",
//                                "Puji Tuhan, Haleluya",
//                                "Puji Bapa dan Putra-Nya",
//                                "Puji Roh Kudus, serta-Nya"
//                            ]),
//                        ],
//                        reff: Verse(contents: [
//                            "Puji Tuhan, Puji Tuhan",
//                            "Haleluya, haleluya, haleluya"
//                        ]),
//                        songBook: .laguSion),
//                    Song(id: 3, number: 3, title: "No 3", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
//                    Song(id: 4, number: 4, title: "No 4", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
//                    Song(id: 5, number: 5, title: "No 5", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
//                    Song(id: 6, number: 6, title: "No 6", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
//                    Song(id: 7, number: 7, title: "No 7", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
//                    Song(id: 8, number: 8, title: "No 8", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion),
//                    Song(id: 9, number: 9, title: "No 9", verses: [Verse(contents: ["HAHA"])], songBook: .laguSion)
//                ]
            ),
            reducer: appReducer,
            environment: AppEnvironment(
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                    grpc: GRPCExecutor(),
                    laguSionClient: Lagusion_LaguSionServiceClient(channel: channel)
                )
            )
        )
            .onAppear(perform: setupAppearance)
        
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    private func setupAppearance() {
        // TODO: Move that to SwiftUI once implemented
        UITableView.appearance().backgroundColor = .systemBackground
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

