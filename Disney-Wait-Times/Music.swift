//
//  Music.swift
//  Disney-Wait-Times
//
//  Created by Zach Howes on 8/3/23.
//

import Foundation
import AVKit
final class AudioManager {
    static let shared = AudioManager()
    var player = AVPlayer()

    func Start () {
        let url = URL(string:"https://19013.live.streamtheworld.com/SP_R3956254_SC")
        
        do {
            player =  AVPlayer(url: url!)
            player.volume = 0.6
            player.play()
        }
    }
    
    func Stop () {
        
        do {
            player.pause()
        }
        
    }
}
