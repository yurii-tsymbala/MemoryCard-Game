//
//  GameViewMode.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 1/3/19.
//  Copyright © 2019 Yurii Tsymbala. All rights reserved.
//

import Foundation

class GameViewModel {
  private let level: Level
  private(set) var cellViewModels: [CardCellViewModel] = []

  init(level:Level) {
    self.level = level
    generateCardsForLevel(level: level)
  }

  var numberOfCells: Int {
    return cellViewModels.count
  }

  func generateCardsForLevel(level: Level) {
    print("CARDS GENERATED")// з downloadService функція буде
    // тут має згенеруватись масив cardCells: [CardCellViewModel] = []
    // релоад дата
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
