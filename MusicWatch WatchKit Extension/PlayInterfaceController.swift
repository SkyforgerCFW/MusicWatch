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
    @IBOutlet var slider: WKInterfaceSlider!
    @IBOutlet var progressBar: WKInterfaceGroup!
    var duration: Float = 0.0
//    var timer: Timer = Timer(timeInterval: 1, repeats: true, block:{ _ in progressUpdate()})
    //let displayLink = CADisplayLink(target: self, selector: #selector(update))
    //var playbackSlider = WKInterfaceSlider()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let song = context as! URL
        songName.setText(song.lastPathComponent)
        soundPlayer.setSession(named: song)
        soundPlayer.playPause()
        duration = soundPlayer.length()
        //RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in self.progressUpdate() })
        
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
    
    func progressUpdate() {
        progressBar.setRelativeWidth(CGFloat(1 / (duration / soundPlayer.currTime())), withAdjustment: 0.1)
    }
    
    func stopTimer() {
        
    }
}
