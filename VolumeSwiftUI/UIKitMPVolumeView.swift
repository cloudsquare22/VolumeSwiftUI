//
//  UIKitMPVolumeView.swift
//  VolumeSwiftUI
//
//  Created by Shin Inaba on 2020/05/19.
//  Copyright © 2020 shi-n. All rights reserved.
//

import MediaPlayer
import SwiftUI

struct UIKitMPVolumeView: UIViewRepresentable {
    typealias UIViewType = MPVolumeView
    
    let view: MPVolumeView = MPVolumeView()
    
    func makeUIView(context: Context) -> MPVolumeView {
        view.setVolumeThumbImage(UIImage(named: "volume"), for: .normal)
        return view
    }
   
    func updateUIView(_ uiView: MPVolumeView, context: Context) {
    }
    
    func getVolume() -> Float {
        var volume: Float = 0.0
        for subview in view.subviews {
            if let lalala = subview as? UISlider {
                print(lalala.value)
                volume = lalala.value
            }
        }
        return volume
    }
}
