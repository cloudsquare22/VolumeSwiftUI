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
    
    @Binding var volume: Float
    
    let view: MPVolumeView = MPVolumeView()
    
    func makeUIView(context: Context) -> MPVolumeView {
        view.setVolumeThumbImage(UIImage(named: "volume"), for: .normal)

        if let uislider = getUISlider() {
            volume = uislider.value
            uislider.addTarget(context.coordinator,
                               action: #selector(Coordinator.updateVolume(sender:)),
                               for: .valueChanged)
        }
        return view
    }
   
    func updateUIView(_ uiView: MPVolumeView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func getVolume() -> Float {
        var volume: Float = 0.0
        if let uislider = getUISlider() {
            print(uislider.value)
            volume = uislider.value
        }
        return volume
    }
    
    func getUISlider() -> UISlider? {
        var uislider: UISlider? = nil
        for subview in view.subviews {
            if let slider = subview as? UISlider {
                uislider = slider
            }
        }
        return uislider
    }
    
    class Coordinator {
        var parent: UIKitMPVolumeView
        
        init(_ parent: UIKitMPVolumeView) {
            self.parent = parent
        }
        
        @objc func updateVolume(sender: UISlider) {
            print(#function)
            parent.volume = sender.value
            print(parent.volume)
        }
    }
    
}
