//
//  FileManagerExtenion.swift
//  ProgrammaticFlashCardApp
//
//  Created by Brendon Crowe on 3/22/23.
//

import Foundation

extension FileManager {
    public static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    public static func pathToDocumentsDirectory(with filename: String) -> URL {
      return getDocumentsDirectory().appendingPathComponent(filename)
    }
  }
