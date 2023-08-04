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
        let url = URL(string:"https://18093.live.streamtheworld.com/SP_R3956612_SC")
        
        do {
            player =  AVPlayer(url: url!)
            
            player.play()
        }
    }
}
