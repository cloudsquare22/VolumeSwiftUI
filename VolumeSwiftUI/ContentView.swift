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

    @Environment(\.scenePhase) private var scenePhase

    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

    let width = UIScreen.main.bounds.width

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                if musicData.albumVolume != 0 {
                    Text(String(format: "Save data : %.2f", musicData.albumVolume))
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
                        Text("Load")
                            .font(.largeTitle)
                        Image(systemName: "arrow.turn.right.down")
                            .font(.largeTitle)
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                    Button(action: {
                        self.musicData.saveVolume()
                    }) {
                        Image(systemName: "arrow.turn.left.up")
                            .font(.largeTitle)
                        Text("Save")
                            .font(.largeTitle)
                    }
                    .buttonStyle(.borderedProminent)
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
                .padding(EdgeInsets(top: 4.0, leading: 0.0, bottom: 4.0, trailing: 0.0))
                makeUIKitMPVolumeView()
                    .frame(width: width * 0.9, height: 50, alignment: .center)
                VStack {
                    Text(musicData.albumName)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 4.0, leading: 8.0, bottom: 4.0, trailing: 8.0))
                    Text(musicData.artistName)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                    Text(musicData.persistentid)
                        .foregroundColor(.white)
                        .padding(8.0)
                }
                Spacer()
            }
            VStack(spacing: -4.0) {
                Spacer()
                Text("Volume \(version)")
                    .font(.title3)
                    .foregroundColor(.white)
                HStack {
                    Spacer()
                    Image("cloudsquare")
                    Text("©️ 2020-2023 cloudsquare.jp")
                        .font(.footnote)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .padding(32.0)
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color("jccolor"))
        .onChange(of: scenePhase, perform: { value in
               switch(value) {
               case .active:
                   print("active")
                   self.musicData.loadVolume()
               case .background:
                   print("background")
               case .inactive:
                   print("inactive")
               @unknown default:
                   print("default")
               }
           })
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
