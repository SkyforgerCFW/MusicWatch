//
//  SoundPlaying.swift
//  MusicWatch WatchKit Extension
//
//  Created by Goxy on 28/04/2020.
//  Copyright © 2020 Goxy. All rights reserved.
//

import AVFoundation

class SoundPlaying: NSObject, AVAudioPlayerDelegate {
    var soundPlayer: AVAudioPlayer?
    var playing: Bool = false
    
    func setSession(named url: URL) {
//        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") ?? Bundle.main.url(forResource: name, withExtension: "m4a") else {
//            fatalError("Unable to find sound file \(name)")
//        }
        let url = url
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        try? AVAudioSession.sharedInstance().setActive(true)
        try? soundPlayer = AVAudioPlayer(contentsOf: url)
        soundPlayer?.delegate = self
    }
//    func playSound() {
//        soundPlayer?.play()
//    }
//
//    func pauseSound() {
//        soundPlayer?.pause()
//    }
    
    func playPause() {
        if(playing == true) {
            soundPlayer?.pause()
            playing = false
        }
        else {
            soundPlayer?.play()
            playing = true
        }
    }
    
    @objc func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playing = false
        //PlayInterfaceController.stopTimer(<#T##self: PlayInterfaceController##PlayInterfaceController#>)
    }
    
    func seekBackward() {
        soundPlayer?.currentTime -= 10
    }
    
    func seekForward() {
        soundPlayer?.currentTime += 10
    }
    
    func length() -> Float {
        return Float(soundPlayer?.duration ?? 0)
    }
    
    func currTime() -> Float {
        return Float(soundPlayer?.currentTime ?? 0)
    }
}
