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
import UIKit

class GameViewModel {
  let level: Level
  private(set) var cellViewModels: [CardCellViewModel] = []
  private let downloadService = DownloadService()
   var firstFlippedCardIndex:IndexPath?
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

  //  func selectCard(atIndex index: Int) {
  //    //    guard index >= 0 && index < tasks.count else {return}
  //    //    let taskDescription = TaskDescriptionViewModel(task: tasks[index])
  //    //    self.showTaskDetail?(taskDescription)
  //  }

  func getCellViewModel(at index: Int) -> CardCellViewModel {
    return cellViewModels[index]
  }


   func checkForMatches(_ secondFlippedCardIndex:IndexPath, cardCollectionView: UICollectionView) {
    let cardOneCell = cardCollectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
    let cardTwoCell = cardCollectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
    let cardOne = cellViewModels[firstFlippedCardIndex!.row]
    let cardTwo = cellViewModels[secondFlippedCardIndex.row]

    if cardOne.cardImageName == cardTwo.cardImageName {
      cardOne.isMatched = true
      cardTwo.isMatched = true
      cardCollectionView.isUserInteractionEnabled = false
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
        cardCollectionView.isUserInteractionEnabled = true
        cardOneCell?.remove()
        cardTwoCell?.remove()
      }
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
        cardOneCell?.removeFromSuperview()
        cardTwoCell?.removeFromSuperview()
        self.checkGameEnded()
      }
    } else {
      //flipCount += 1
      cardOne.isFlipped = false
      cardTwo.isFlipped = false
      cardCollectionView.isUserInteractionEnabled = false
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
        cardCollectionView.isUserInteractionEnabled = true
        cardOneCell?.flipback()
        cardTwoCell?.flipback()
      }
    }
    if cardOneCell == nil {
      cardCollectionView.reloadItems(at: [firstFlippedCardIndex!])
    }
    firstFlippedCardIndex = nil
  }

   func checkGameEnded() {
    var isWon = true
    for cellViewModel in cellViewModels {
      if cellViewModel.isMatched == false {
        isWon = false
        break
      }
    }
    if isWon == true {
      print("You won!")
      //timer?.invalidate()
      //performSegue(withIdentifier: "RecordSegue", sender: self)
    }
  }
}
