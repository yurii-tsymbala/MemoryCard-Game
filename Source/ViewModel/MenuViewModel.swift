//
//  MenuViewModel.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 12/29/18.
//  Copyright © 2018 Yurii Tsymbala. All rights reserved.
//

import UIKit
import CoreData

class MenuViewModel {

  // тут будуть всякі змінні для нагляданння

  private let userDefaultsServive: UserDefaultsService

  init(userDefaultsServive: UserDefaultsService) {
    self.userDefaultsServive = userDefaultsServive
    observingDownloadStatus()
  }

  private func observingDownloadStatus() {
    userDefaultsServive.checkDownloadStatus { downloadStatus in
      switch downloadStatus {
      case .success(let isDownloaded):
        print("Success!")
        print(isDownloaded)  // виключити крутіння індикатора + додати привітальний текст
      case .failure(let error):
        print(error)     // виключити крутіння індикатор + додати текст щоб перезавантажити картинки
      }
    }
  }
}
