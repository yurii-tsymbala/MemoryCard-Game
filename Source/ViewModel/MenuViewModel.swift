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

  private var cellViewModels : [LevelCellViewModel] {
    return defaultLevelSetup()
  }

  var startAnimating = PublishSubject<Void>()
  var showAlertView = PublishSubject<AlertViewModel>()
  var startGame = PublishSubject<GameViewModel>()

  var numberOfCells: Int {
    return cellViewModels.count
  }

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
    startGame.onNext(GameViewModel(level: Level(cardsNumber: cellViewModels[index].levelCardsNumber,
                                                stickerPackName: pickerViewModel.currentStickerPackName.value)))
  }

  func getCellViewModel(at index: Int) -> LevelCellViewModel {
    return cellViewModels[index]
  }

  private func defaultLevelSetup() -> [LevelCellViewModel] {
    return [LevelCellViewModel(levelCardsNumber: "4"),
            LevelCellViewModel(levelCardsNumber: "8"),
            LevelCellViewModel(levelCardsNumber: "12"),
            LevelCellViewModel(levelCardsNumber: "16"),
            LevelCellViewModel(levelCardsNumber: "20"),
            LevelCellViewModel(levelCardsNumber: "24"),
            LevelCellViewModel(levelCardsNumber: "28"),
            LevelCellViewModel(levelCardsNumber: "32")
    ]
  }
}
