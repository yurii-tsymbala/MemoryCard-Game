//
//  PickerViewModel.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 1/3/19.
//  Copyright © 2019 Yurii Tsymbala. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PickerViewModel {

  var currentStickerPackName = BehaviorRelay<StickerPack>(value: .cars)

  let stickerPacksArray = [UIImage(named: "Cars")!,
                           UIImage(named: "Food")!,
                           UIImage(named: "Pockemons")!]

  var numberOfRowsForPicker: Int {
    return stickerPacksArray.count
  }

  var viewSizeForRow: CGFloat {
    return 100.0
  }

  func setupViewForRow(indexOfTheRow row: Int) -> UIView {
    let pickerImageView = UIImageView()
    pickerImageView.contentMode = .scaleAspectFit
    pickerImageView.image = stickerPacksArray[row]
    return pickerImageView
  }

  func sendInfoToLabel(indexOfTheRow row: Int) {
    switch row {
    case 0:
      currentStickerPackName.accept(.cars)
    case 1:
      currentStickerPackName.accept(.food)
    case 2:
      currentStickerPackName.accept(.pockemons)
    default:
      currentStickerPackName.accept(.cars)
    }
  }
}
