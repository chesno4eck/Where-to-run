//
//  writeToFile.swift
//  comfort
//
//  Created by Пичугин Дмитрий Сергеевич on 14.06.2018.
//  Copyright © 2018 Алиев Дмитрий. All rights reserved.
//

import Foundation

func writeToFile(value:String?) -> Bool {
    
    guard var _value = value else{ return false}
    
    _value.append("\r\n")
    
    let fileurl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("SbOutput.txt")
    
    let data = _value.data(using: .utf8, allowLossyConversion: false)!
    
    
    if FileManager.default.fileExists(atPath: fileurl.path) {
        if let fileHandle = try? FileHandle(forUpdating: fileurl) {
            fileHandle.seekToEndOfFile()
            fileHandle.write(data)
            fileHandle.closeFile()
            return true
        }
        return false
    } else {
        do {
            try data.write(to: fileurl, options: Data.WritingOptions.atomic)
        } catch {
            return false
        }
    }
    return true
}
