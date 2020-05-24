//
//  SceneDelegate.swift
//  LaguSion
//
//  Created by Abram Situmorang on 10/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import ComposableArchitecture
import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Get the managed object context from the shared persistent container.
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
        // Add `@Environment(\.managedObjectContext)` in the views that will need the context.
//        let contentView = RootView().environment(\.managedObjectContext, context)
        
        let contentView = RootView(store: Store(
                initialState: AppState(
                    songs: [
                        Song(
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
                            ]
                        ),
                        Song(id: UUID(), isFavorite: false, number: 2, title: "No 2", verses: [Verse(contents: ["HAHA"])]),
                        Song(id: UUID(), isFavorite: false, number: 3, title: "No 3", verses: [Verse(contents: ["HAHA"])]),
                        Song(id: UUID(), isFavorite: false, number: 4, title: "No 4", verses: [Verse(contents: ["HAHA"])]),
                        Song(id: UUID(), isFavorite: false, number: 5, title: "No 5", verses: [Verse(contents: ["HAHA"])]),
                        Song(id: UUID(), isFavorite: false, number: 6, title: "No 6", verses: [Verse(contents: ["HAHA"])]),
                        Song(id: UUID(), isFavorite: false, number: 7, title: "No 7", verses: [Verse(contents: ["HAHA"])]),
                        Song(id: UUID(), isFavorite: false, number: 8, title: "No 8", verses: [Verse(contents: ["HAHA"])]),
                        Song(id: UUID(), isFavorite: false, number: 9, title: "No 9", verses: [Verse(contents: ["HAHA"])])
                    ]
                ),
                reducer: appReducer,
                environment: AppEnvironment()
            )
        )


        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
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

