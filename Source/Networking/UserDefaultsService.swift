//
//  UserDefaultsService.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 12/29/18.
//  Copyright © 2018 Yurii Tsymbala. All rights reserved.
//

import Foundation

final class UserDefaultsService {
  private let userDefaults = UserDefaults.standard
  public let downloadService: DownloadService

  private enum Keys: String {
    case keyAppInstalled
  }

  public var isAppInstalled: Bool {
    get {
      let isAppInstalled = userDefaults.bool(forKey: Keys.keyAppInstalled.rawValue)
      return isAppInstalled
    }
    set(appState) {
      userDefaults.set(appState, forKey: Keys.keyAppInstalled.rawValue)
      userDefaults.synchronize()
    }
  }

  init(downloadService: DownloadService) {
    self.downloadService = downloadService
    //checkAppState()
  }

//  private func checkAppState() {
//    if !isAppInstalled {
//      downloadService.checkTheDownload { [weak self] downloadResult in
//        guard let strongSelf = self else { return }
//        switch downloadResult {
//        case .success(_):
//          strongSelf.isAppInstalled = true
//        case .failure(_):
//          print("Check the Internet Connection and relaunch the App")
//          strongSelf.isAppInstalled = false
//        }
//      }
//    }
//  }
}
