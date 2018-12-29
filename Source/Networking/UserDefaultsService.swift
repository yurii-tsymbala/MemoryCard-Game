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

  private enum Keys: String {
    case keyAppInstalled
  }

  private var isAppInstalled: Bool {
    get {
      let isAppInstalled = userDefaults.bool(forKey: Keys.keyAppInstalled.rawValue)
      return isAppInstalled
    }
    set(appState) {
      userDefaults.set(appState, forKey: Keys.keyAppInstalled.rawValue)
      userDefaults.synchronize()
    }
  }

  private let downloadService: DownloadService

  private func checkAppState() {
    if !isAppInstalled {
      fetchData()
    }
  }

  private func fetchData() {
    //downloadService.fetch { result in

    // }
    // викликати функцію фетчу і в якшо результат позитивний поставити isAppInstalled = true

  }

  init(downloadService: DownloadService) {
    self.downloadService = downloadService
    checkAppState()
  }

}
