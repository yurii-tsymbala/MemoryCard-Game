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

  private let userDefaultsServive: UserDefaultsService
  let pickerViewModel: PickerViewModel
  private let alertViewModel = AlertViewModel(title: "Bad Internet Connection",
                                              message: "Please reload the application")

  // тут будуть всякі змінні для нагляданння
  var startAnimating = PublishSubject<Void>()
  var showAlertView = PublishSubject<AlertViewModel>()
  var startGame = PublishSubject<GameViewModel>()
  //var showAlert: ((AlertViewModel) -> Void)?

  init(userDefaultsServive: UserDefaultsService,
       pickerViewModel: PickerViewModel) {
    self.userDefaultsServive = userDefaultsServive
    self.pickerViewModel = pickerViewModel
  }

  func observingDownloadStatus() {
    userDefaultsServive.checkDownloadStatus { [weak self] downloadStatus in
      guard let strongSelf = self else {return}
      switch downloadStatus {
      case .success(_):
        strongSelf.startAnimating.onCompleted()
      case .failure(_):
        strongSelf.startAnimating.onCompleted()
        strongSelf.showAlertView.onNext(strongSelf.alertViewModel) // не працює
        // show alert for user with button to execute observingDownloadStatus()
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

  func showAlert(_ alertViewModel: AlertViewModel, inViewController: UIViewController) {
    let alert = UIAlertController(title: alertViewModel.title,
                                  message: alertViewModel.message,
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    inViewController.present(alert, animated: true, completion: nil)
  }
}
