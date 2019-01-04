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
  private(set) var cardCells: [CardCollectionCellViewModel] = []

  init(level:Level) {
    self.level = level
    generateCardsForLevel(level: level)
  }

  func generateCardsForLevel(level: Level) {
    print("CARDS GENERATED")// з downloadService функція буде
    // тут має згенеруватись масив cardCells: [CardCollectionCellViewModel] = []
  }
}
