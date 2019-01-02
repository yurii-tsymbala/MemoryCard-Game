//
//  MenuViewModel.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 12/29/18.
//  Copyright © 2018 Yurii Tsymbala. All rights reserved.
//

import UIKit
import CoreData
import RxSwift
import RxCocoa

class MenuViewModel {

  var startAnimating = PublishSubject<Void>()

  // тут будуть всякі змінні для нагляданння

  private let userDefaultsServive: UserDefaultsService

  init(userDefaultsServive: UserDefaultsService) {
    self.userDefaultsServive = userDefaultsServive
    observingDownloadStatus()
  }

  private func observingDownloadStatus() {
    userDefaultsServive.checkDownloadStatus { [weak self] downloadStatus in
      guard let strongSelf = self else {return}
      switch downloadStatus {
      case .success(_):
          strongSelf.startAnimating.onCompleted()
      case .failure(let error):
        strongSelf.startAnimating.onCompleted()
        print(error)
        // show alert for user with button to execute observingDownloadStatus()
      }
    }
  }
}
