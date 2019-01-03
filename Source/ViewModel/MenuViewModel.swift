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

  var showAlertView = PublishSubject<AlertViewModel>()

  var showAlert: ((AlertViewModel) -> Void)?

  private let alertViewModel = AlertViewModel(title: "Bad Internet Connection",
                                              message: "Please reload the application")

  // тут будуть всякі змінні для нагляданння

  private let userDefaultsServive: UserDefaultsService

  init(userDefaultsServive: UserDefaultsService) {
    self.userDefaultsServive = userDefaultsServive
    //observingDownloadStatus()
  }

   func observingDownloadStatus() {
    userDefaultsServive.checkDownloadStatus { [weak self] downloadStatus in
      guard let strongSelf = self else {return}
      switch downloadStatus {
      case .success(_):
        strongSelf.startAnimating.onCompleted()
      case .failure(let error):
          strongSelf.startAnimating.onCompleted()
          strongSelf.showAlertView.onNext(strongSelf.alertViewModel) // не працює
          // show alert for user with button to execute observingDownloadStatus()
      }
    }
  }

  func showAlert(_ alertViewModel: AlertViewModel, inViewController: UIViewController) { //замість Router
    let alert = UIAlertController(title: alertViewModel.title,
                                  message: alertViewModel.message,
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    inViewController.present(alert, animated: true, completion: nil)
  }
}
