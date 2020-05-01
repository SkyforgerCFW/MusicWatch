//
//  TableInterfaceController.swift
//  MusicWatch WatchKit Extension
//
//  Created by Goxy on 28/04/2020.
//  Copyright © 2020 Goxy. All rights reserved.
//

import WatchKit
import AVFoundation
import WatchConnectivity

class TableInterfaceController: WKInterfaceController, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("watch session activated")
    }
    
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        //print(file)
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
        do {
            try FileManager.default.moveItem(at: file.fileURL, to: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(file.fileURL.lastPathComponent))
        } catch {
            print(error)
        }
        readSongs()
        populateTable()
    }
    
//    func session(_ session: WCSession, didFinish fileTransfer: WCSessionFileTransfer, error: Error?) {
//        if (error != nil) { print(error!) }
//        print("TEST")
//        print(fileTransfer)
//    }
    
    @IBOutlet var table: WKInterfaceTable!
//    var soundPlayer: AVAudioPlayer?
//    var playing: Bool = false
    
    //let sounds = (Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? [] + (Bundle.main.urls(forResourcesWithExtension: "m4a", subdirectory: nil) ?? []))?.map { $0.deletingPathExtension().lastPathComponent }.sorted() ?? []
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    var music: [URL] = []
    //let test = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: "Audio")?.map { $0.deletingPathExtension().lastPathComponent }.sorted()
    let session = WCSession.default
    
    func readSongs() {
        do {
            music = try FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: [], options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
            music = music.filter{ $0.pathExtension == "mp3" || $0.pathExtension == "m4a" }.sorted(by: { $0.lastPathComponent < $1.lastPathComponent })
        } catch {
            print(error)
        }
    }
    
    func populateTable() {
        table.setNumberOfRows(music.count, withRowType: "Row")
        for(index, song) in music.enumerated() {
            guard let row = table.rowController(at: index) as? SoundRow else { continue }
            row.label.setText(song.lastPathComponent)
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        readSongs()
        populateTable()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        session.delegate = self
        if session.activationState != WCSessionActivationState.activated { session.activate()
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
//        setSession(named: sounds[rowIndex])
//        playSound(named: sounds[rowIndex])
        pushController(withName: "PlayInterfaceController", context: music[rowIndex])
    }
}
