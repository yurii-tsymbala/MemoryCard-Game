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
  private let userDefaultsService: UserDefaultsService
  private let alertViewModel = AlertViewModel(title: "Bad Internet Connection",
                                              message: "Please reload the application")
  let pickerViewModel: PickerViewModel

  var startAnimating = PublishSubject<Void>()
  var showAlertView = PublishSubject<AlertViewModel>()
  var startGame = PublishSubject<GameViewModel>()

  init(userDefaultsServive: UserDefaultsService,
       pickerViewModel: PickerViewModel) {
    self.userDefaultsService = userDefaultsServive
    self.pickerViewModel = pickerViewModel
  }

  func observingDownloadStatus() {
    startAnimating.onNext(())
    userDefaultsService.checkDownloadStatus { [weak self] downloadStatus in
      guard let strongSelf = self else {return}
      switch downloadStatus {
      case .success(_):
        strongSelf.startAnimating.onCompleted()
      case .failure(_):
        strongSelf.startAnimating.onCompleted()
        strongSelf.showAlertView.onNext(strongSelf.alertViewModel)
      }
    }
  }

  func selectLevel(atIndex index: Int) {
    startGame.onNext(GameViewModel(level: Level(cardsNumber: convertIndexToLevel(withIndex: index),
                                                stickerPackName: pickerViewModel.currentStickerPackName.value)))
  }

  private func convertIndexToLevel(withIndex index: Int) -> Int {
    if index == 0 {
      return 4
    } else if index == 1 {
      return 8
    } else {
      let cardsNumber = 4 * index
      return cardsNumber
    }
  }

  //  func getCellViewModel(at index: Int) -> TasksCellViewModel {
  //    return cellViewModels[index]
  //  }

}
