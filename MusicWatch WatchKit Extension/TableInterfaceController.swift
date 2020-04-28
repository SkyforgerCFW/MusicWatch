//
//  TableInterfaceController.swift
//  MusicWatch WatchKit Extension
//
//  Created by Goxy on 28/04/2020.
//  Copyright © 2020 Goxy. All rights reserved.
//

import WatchKit
import AVFoundation

class TableInterfaceController: WKInterfaceController {
    @IBOutlet var table: WKInterfaceTable!
//    var soundPlayer: AVAudioPlayer?
//    var playing: Bool = false
    
    let sounds = (Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? [] + (Bundle.main.urls(forResourcesWithExtension: "m4a", subdirectory: nil) ?? []))?.map { $0.deletingPathExtension().lastPathComponent }.sorted() ?? []
    //let test = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: "Audio")?.map { $0.deletingPathExtension().lastPathComponent }.sorted()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        table.setNumberOfRows(sounds.count, withRowType: "Row")
        for(index, sound) in sounds.enumerated() {
            guard let row = table.rowController(at: index) as? SoundRow else { continue }
            row.label.setText(sound)
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
//        setSession(named: sounds[rowIndex])
//        playSound(named: sounds[rowIndex])
        pushController(withName: "PlayInterfaceController", context: sounds[rowIndex])
    }
}
