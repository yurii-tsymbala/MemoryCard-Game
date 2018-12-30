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
  }
}
