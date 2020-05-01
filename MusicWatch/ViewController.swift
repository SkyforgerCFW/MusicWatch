//
//  ViewController.swift
//  MusicWatch
//
//  Created by Goxy on 28/04/2020.
//  Copyright © 2020 Goxy. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        sendSongToWatch(id: sendID)
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    @IBOutlet var tableView: UITableView!
    let documentsURL = FileManager.default.getDocumentsDirectory()
    var music: [URL] = []
    var sendID = 0
    let cellReuseIdentifier = "cell"
    let session = WCSession.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
//        DispatchQueue.main.async {
//            let alert = UIAlertController(title: "mudo", message: FileManager.default.getDocumentsDirectory().absoluteString, preferredStyle: .alert)
//            self.present(alert, animated: true, completion: nil)
//        }
        
        // Do any additional setup after loading the view.
        readSongs()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func readSongs() {
        do {
            music = try FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: [], options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
            music = music.filter{ $0.pathExtension == "mp3" || $0.pathExtension == "m4a" }.sorted(by: { $0.lastPathComponent < $1.lastPathComponent })
        } catch {
            print(error)
        }
    }
    
    @objc func refresh(refreshControl: UIRefreshControl) {
        readSongs()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return music.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)! as UITableViewCell
        
        cell.textLabel?.text = music[indexPath.row].lastPathComponent
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try? FileManager.default.removeItem(at: music[indexPath.row])
            music.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendID = indexPath.row
        let alert = UIAlertController(title: "Send to Watch", message: "Send " + music[indexPath.row].lastPathComponent + " to Apple Watch?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ae", style: .default, handler: { _ in
            if WCSession.isSupported() {
                self.session.delegate = self
                if self.session.activationState == WCSessionActivationState.activated {
                    self.sendSongToWatch(id: self.sendID)
                }
                else { self.session.activate() }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func sendSongToWatch(id: Int) {
        //print(session.watchDirectoryURL ?? "")
        session.transferFile(music[id], metadata: nil)
        print(session.outstandingFileTransfers)
    }
}
