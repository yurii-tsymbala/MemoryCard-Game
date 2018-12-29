//
//  MenuViewModel.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 12/29/18.
//  Copyright © 2018 Yurii Tsymbala. All rights reserved.
//

import Foundation


class MenuViewModel {

  private let userDefaultsServive: UserDefaultsService

  init(userDefaultsServive: UserDefaultsService) {
    self.userDefaultsServive = userDefaultsServive
  }
  
  func checkAppState(completion: @escaping (_ appState: Bool) -> Void ) {
    if !userDefaultsServive.isAppInstalled {
      userDefaultsServive.downloadService.checkTheDownload { [weak self] downloadResult in
        guard let strongSelf = self else { return }
        switch downloadResult {
        case .success(_):
          strongSelf.userDefaultsServive.isAppInstalled = true
          completion(true)
        case .failure(_):
          completion(false)
          strongSelf.userDefaultsServive.isAppInstalled = false
        }
      }
    }
  }

  // показувати алерт якшо нема інтернету - шоб викачались зображення в кордату
}
