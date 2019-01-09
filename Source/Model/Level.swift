//
//  Level.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 12/29/18.
//  Copyright © 2018 Yurii Tsymbala. All rights reserved.
//

import Foundation

struct Level {
  var cardsNumber: String
  var stickerPackName: StickerPack
}

enum StickerPack: String {
  case cars = "Cars"
  case pockemons = "Pockemons"
  case food = "Food"
}
