//
//  FileManager-DocumentsDirectory.swift
//  MusicWatch
//
//  Created by Goxy on 28/04/2020.
//  Copyright © 2020 Goxy. All rights reserved.
//

import Foundation

extension FileManager {
    public func getDocumentsDirectory() -> URL {
        let paths = urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
