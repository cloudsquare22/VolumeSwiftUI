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

    var volumeView: UIKitMPVolumeView? = nil

    init() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: .MPMusicPlayerControllerNowPlayingItemDidChange, object: self.player, queue: nil, using: { notification in
            print("change item")
            self.setNowPlaying()
            self.loadVolume()
        })
        player.beginGeneratingPlaybackNotifications()
        setNowPlaying()
        loadVolume()
    }
    
    func setSystemVolume() {
        print(#function)
        if albumVolume != 0 {
            player.setValue(albumVolume, forKey: "volume")
        }
    }

    func setSystemVolume(volume: Float) {
        print(#function)
        player.setValue(volume, forKey: "volume")
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
            if let vv = volumeView {
                let saveVolume = vv.getVolume()
                userDefaults.set(saveVolume, forKey: persistentid)
                print("save volume:\(persistentid):\(saveVolume)")
                albumVolume = saveVolume
            }
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
