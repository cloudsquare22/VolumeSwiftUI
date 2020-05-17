//
//  MusicData.swift
//  VolumeSwiftUI
//
//  Created by Shin Inaba on 2020/05/16.
//  Copyright © 2020 shi-n. All rights reserved.
//

import SwiftUI
import MediaPlayer

final class MusicData: ObservableObject {
    @Published var volume: Double
    @Published var albumName = "-"
    @Published var artistName = "-"
    @Published var persistentid = "-"
    @Published var albumVolume: Double = 0

    var player: MPMusicPlayerController! = MPMusicPlayerController.systemMusicPlayer
    let userDefaults = UserDefaults.standard

    init() {
        volume = Double(AVAudioSession.sharedInstance().outputVolume)
        print("nowVolume:\(volume)")
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(MusicData.changeMusic(_:)), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: player)
        player.beginGeneratingPlaybackNotifications()
        setNowPlaying()
        loadVolume()
    }

    @objc func changeMusic(_ notification:Notification?) {
        print(#function)
        setNowPlaying()
        loadVolume()
    }
    
    func getVolume() {
        print(#function)
        volume = Double(AVAudioSession.sharedInstance().outputVolume)
        print("nowVolume:\(volume)")
    }
    
    func setSystemVolume() {
        print(#function)
        player.setValue(Float(volume), forKey: "volume")
    }
    
    func setNowPlaying() {
        print(#function)
        albumName = "-"
        artistName = "-"
        persistentid = "-"

        if let now : MPMediaItem = player.nowPlayingItem {
            if let name = now.albumTitle {
                albumName = name
            }

            if let name = now.albumArtist {
                artistName = name
            }
            else if let name = now.artist {
                artistName = name
            }
            persistentid = String(now.albumPersistentID)
        }
    }
    
    func saveVolume() {
        print(#function)
        if persistentid != "-" {
            let saveVolume : Float = Float(volume)
            userDefaults.set(saveVolume, forKey: persistentid)
            print("save volume:\(persistentid):\(volume)")
            albumVolume = Double(saveVolume)
        }
    }
    
    func loadVolume() {
        print(#function)
        if persistentid != "-" {
            albumVolume = Double(userDefaults.float(forKey: persistentid))
        }
        print("load volume:\(albumVolume)")
    }
    
    func setVolume() {
        print(#function)
        if albumVolume != 0 {
            volume = albumVolume
            setSystemVolume()
        }
    }
}
