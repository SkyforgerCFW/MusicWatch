//
//  CustomInterfaceController.swift
//  MusicWatch WatchKit Extension
//
//  Created by Goxy on 28/04/2020.
//  Copyright © 2020 Goxy. All rights reserved.
//

import WatchKit
import AVFoundation


class CustomInterfaceController: WKInterfaceController {
    let saveURL = FileManager.default.getDocumentsDirectory().appendingPathComponent("recording.wav")
    var soundPlayer: AVAudioPlayer?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
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

    @IBAction func recordBtn() {
        presentAudioRecorderController(withOutputURL: saveURL, preset: .narrowBandSpeech) { success, error in
            if success { print("Saved successfully!") }
            else { print(error?.localizedDescription ?? "Unknown error") }
        }
    }
    
    @IBAction func playBtn() {
        guard FileManager.default.fileExists(atPath: saveURL.path) else { return }
        
        try? soundPlayer = AVAudioPlayer(contentsOf: saveURL)
        soundPlayer?.play()
    }
}
