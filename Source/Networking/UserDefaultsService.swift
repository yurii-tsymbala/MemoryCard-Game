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
  private let downloadService: DownloadService

  private enum Keys: String {
    case keyAppInstalled
  }

  private var isDownloadCompleted: Bool {
    get {
      let isAppInstalled = userDefaults.bool(forKey: Keys.keyAppInstalled.rawValue)
      return isAppInstalled
    }
    set(appState) {
      userDefaults.set(appState, forKey: Keys.keyAppInstalled.rawValue)
      userDefaults.synchronize()
    }
  }

  func checkDownloadStatus(completion: @escaping (Result<Bool, Error>) -> Void) { // провіряти цю функцію кожен раз при загрузці вюмодельки
    if !isDownloadCompleted {
      downloadService.confirmTheDownload { [weak self] downloadServiceResult in
        guard let strongSelf = self else { return }
        switch downloadServiceResult {
        case .success(let isDownloadCompleted):
          strongSelf.isDownloadCompleted = true
          completion(Result.success(isDownloadCompleted))     // віддаємо сигнал про успішне скачування, щоб презентути алерт
        case .failure(let error):
          strongSelf.isDownloadCompleted = false
          completion(Result.failure(error))  // віддаємо помилку з повідомленням вюмодельці шоб презентнути алерт
        }
      }
    }
  }

  init(downloadService: DownloadService) {
    self.downloadService = downloadService
  }
}
