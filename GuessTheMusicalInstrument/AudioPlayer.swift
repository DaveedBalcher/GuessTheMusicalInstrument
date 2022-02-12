//
//  AudioPlayer.swift
//  GuessTheMusicalInstrument
//
//  Created by David Balcher on 2/9/22.
//

import UIKit
import AVFoundation

struct AudioTrack {
    var name: String
    var fileType: String = "wav"
//    var index: Int?
}



class AudioQueue {
    
    var audioTracks: [AudioTrack] = [
        AudioTrack(name: "SadTrombone")
    ]
    
    var queue: [AVAudioPlayer?] = []

    
    static let shared: AudioQueue = {
        let instance = AudioQueue()
        instance.setupAudioQueue()
        return instance
    }()
    
    
    func setupAudioQueue() {
        for track in audioTracks {
            
            // setup with resource
//                let path = Bundle.main.path(forResource: track.name, ofType: track.fileType) {
//                if let player = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path), fileTypeHint: track.fileType) {
            
            // setup with dataAsset
            if let asset = NSDataAsset(name:track.name) {
                if let player = try? AVAudioPlayer(data: asset.data, fileTypeHint: track.fileType) {
                    queue.append(player)
                    break
                } else {
                    // Error - initilizing player
                    print("Error - AudioQueue:  init AVAudioPlayer")
                }
            } else {
                // Error - initilizing Bundle from local audio resource
                print("Error - AudioQueue: initilizing Bundle from local audio resource")
            }
            queue.append(nil)
        }
    }
    
    func playSadTombone() {
        
        if let player = queue[0] {
            player.prepareToPlay()
            player.play()
        }
    }

}


