//
//  VolumeSwiftUIApp.swift
//  VolumeSwiftUI
//
//  Created by Shin Inaba on 2022/01/10.
//  Copyright © 2022 shi-n. All rights reserved.
//

import SwiftUI

@main
struct VolumeSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(MusicData())
        }
    }
}
