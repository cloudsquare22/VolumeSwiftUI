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
    
    @State var volume: Float = 0.5

    let width = UIScreen.main.bounds.width

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
                            .font(.largeTitle)
                    }
                    Image(systemName: "arrow.down")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "arrow.up")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Button(action: {
                        self.musicData.saveVolume()
                    }) {
                        Text("Save")
                            .font(.largeTitle)
                    }
                    Spacer()
                }
                .padding(8.0)
                HStack {
                    Spacer()
                    Button(action: {
                        self.volume = self.volume - 0.01
                        if self.volume < 0.00 {
                            self.volume = 0.00
                        }
                        self.musicData.setSystemVolume(volume: self.volume)
                    }) {
                        Text("-0.01")
                            .font(.largeTitle)
                            .padding(8.0)
                    }
                    Spacer()
                    Text(String(format: "%.2f", volume))
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(8.0)
                    Spacer()
                    Button(action: {
                        self.volume = self.volume + 0.01
                        if 1.00 < self.volume {
                            self.volume = 1.00
                        }
                        self.musicData.setSystemVolume(volume: self.volume)
                    }) {
                        Text("+0.01")
                            .font(.largeTitle)
                            .padding(8.0)
                    }
                    Spacer()
                }
                makeUIKitMPVolumeView()
//                musicData.volumeView
                    .frame(width: width * 0.9, height: 50, alignment: .center)
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
    
    func makeUIKitMPVolumeView() -> UIKitMPVolumeView {
        musicData.volumeView = UIKitMPVolumeView(volume: $volume)
        return musicData.volumeView!
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MusicData())
    }
}
