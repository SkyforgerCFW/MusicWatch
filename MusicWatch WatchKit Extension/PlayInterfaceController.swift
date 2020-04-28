//
//  PlayInterfaceController.swift
//  MusicWatch WatchKit Extension
//
//  Created by Goxy on 28/04/2020.
//  Copyright © 2020 Goxy. All rights reserved.
//

import WatchKit
import AVFoundation


class PlayInterfaceController: WKInterfaceController {
    var soundPlayer = SoundPlaying()
//    var playing: Bool = false
    @IBOutlet var songName: WKInterfaceLabel!
    var name: String = ""
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        name = context as? String ?? "No song playing"
        songName.setText(name)
        soundPlayer.setSession(named: name)
        soundPlayer.playPause()
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func playPauseBtn() {
        soundPlayer.playPause()
    }
    
    @IBAction func seekBackwardBtn() {
        soundPlayer.seekBackward()
    }
    
    @IBAction func seekForwardBtn() {
        soundPlayer.seekForward()
    }
}
