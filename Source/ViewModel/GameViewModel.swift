//
//  GameViewMode.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 1/3/19.
//  Copyright © 2019 Yurii Tsymbala. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class GameViewModel {
  let level: Level
  private(set) var cellViewModels: [CardCellViewModel] = []
  private let downloadService = DownloadService()
  var reloadData = PublishSubject<Void>()

  init(level:Level) {
    self.level = level
  }

  var numberOfCells: Int {
    return cellViewModels.count
  }

  func generateCardsForLevel() {
    downloadService.generateCards(forLevel: level) { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .success(let cardCellViewModels):
        strongSelf.cellViewModels.removeAll()
        strongSelf.cellViewModels = cardCellViewModels
        strongSelf.reloadData.onNext(())
      case .failure(let error):
        print(error)
      }
    }
  }

  func selectCard(atIndex index: Int) {
    //    guard index >= 0 && index < tasks.count else {return}
    //    let taskDescription = TaskDescriptionViewModel(task: tasks[index])
    //    self.showTaskDetail?(taskDescription)
  }

  func getCellViewModel(at index: Int) -> CardCellViewModel {
    return cellViewModels[index]
  }
}
