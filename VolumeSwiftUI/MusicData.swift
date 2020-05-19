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
    @Published var albumName = "-"
    @Published var artistName = "-"
    @Published var persistentid = "-"
    @Published var albumVolume: Float = 0

    var player: MPMusicPlayerController! = MPMusicPlayerController.systemMusicPlayer
    let userDefaults = UserDefaults.standard

    let volumeView = UIKitMPVolumeView()

    init() {
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
    
    func setSystemVolume() {
        print(#function)
        if albumVolume != 0 {
            player.setValue(albumVolume, forKey: "volume")
        }
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
            let saveVolume : Float = volumeView.getVolume()
            userDefaults.set(saveVolume, forKey: persistentid)
            print("save volume:\(persistentid):\(saveVolume)")
            albumVolume = saveVolume
        }
    }
    
    func loadVolume() {
        print(#function)
        if persistentid != "-" {
            albumVolume = userDefaults.float(forKey: persistentid)
        }
        print("load volume:\(albumVolume)")
    }
    
    func setVolume() {
        print(#function)
        if albumVolume != 0 {
            setSystemVolume()
        }
    }
}
