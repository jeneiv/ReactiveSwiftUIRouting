//
//  ReactiveSwiftUIRoutingApp.swift
//  ReactiveSwiftUIRouting
//
//  Created by Viktor Jenei on 2023. 12. 17..
//

import SwiftUI

@main
struct ReactiveSwiftUIRoutingApp: App {
    @Environment(\.scenePhase) private var scenePhase
    let applicationRoute = ApplicationRoute.load()

    var body: some Scene {
        WindowGroup {
            ApplicationContainerView()
                .environmentObject(applicationRoute)
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .background {
                applicationRoute.save()
            }
        }
    }
}
