//
//  ContentView.swift
//  VolumeSwiftUI
//
//  Created by Shin Inaba on 2020/05/16.
//  Copyright © 2020 shi-n. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var musicData: MusicData

    var body: some View {
        ZStack {
            Color("jccolor")
                .edgesIgnoringSafeArea(.all)
            VStack {
                if musicData.albumVolume != 0 {
                    Text(String(format: "%.2f", musicData.albumVolume))
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(8.0)
                }
                else {
                    Text("No save data.")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(8.0)
                }
                HStack {
                    Spacer()
                    Button(action: {
                        self.musicData.setVolume()
                    }) {
                        Text("Set")
                    }
                    Image(systemName: "arrow.down")
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "arrow.up")
                        .foregroundColor(.white)
                    Button(action: {
                        self.musicData.saveVolume()
                    }) {
                        Text("Save")
                    }
                    Spacer()
                }
                .padding(8.0)
                Text(String(format: "%.2f", musicData.volume))
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(8.0)
                Slider(value: $musicData.volume, in: 0.01...1.00, step: 0.01, onEditingChanged: {_ in
                    self.musicData.setSystemVolume()
                })
                    .padding(8.0)
                Text(musicData.albumName)
                    .foregroundColor(.white)
                    .padding(8.0)
                Text(musicData.artistName)
                    .foregroundColor(.white)
                    .padding(8.0)
                Text(musicData.persistentid)
                    .foregroundColor(.white)
                    .padding(8.0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MusicData())
    }
}