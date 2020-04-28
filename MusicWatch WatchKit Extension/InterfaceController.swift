//
//  InterfaceController.swift
//  MusicWatch WatchKit Extension
//
//  Created by Goxy on 28/04/2020.
//  Copyright © 2020 Goxy. All rights reserved.
//

import WatchKit
import AVFoundation


class InterfaceController: WKInterfaceController {
    var soundPlayer = SoundPlaying()
//    var playing: Bool = false

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

    @IBAction func playSound1() {
        pushController(withName: "PlayInterfaceController", context: "Pikachu")
    }
    
    @IBAction func playSound2() {
        pushController(withName: "PlayInterfaceController", context: "Eevee")
    }
    
    @IBAction func playSound3() {
        pushController(withName: "PlayInterfaceController", context: "Squirtle")
    }
    
    @IBAction func playSound4() {
        pushController(withName: "PlayInterfaceController", context: "Bulbasaur")
    }
}
