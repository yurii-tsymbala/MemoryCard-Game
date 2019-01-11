//
//  CardCollectionViewCell.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 1/3/19.
//  Copyright © 2019 Yurii Tsymbala. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
  @IBOutlet private weak var photoCard: UIImageView!
  @IBOutlet private weak var backgroundCard: UIImageView!

  var viewModel: CardCellViewModel! {
    didSet{
      setupView()
    }
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    setupView()
  }

  private func setupView() {
    backgroundCard.isHidden = true  // забрати потім
    DispatchQueue.main.async { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.photoCard.image = strongSelf.viewModel.cardImageData
    }
  }

  // MARK: - CardCell methods

  func flip() {
    UIView.transition(from: backgroundCard,
                      to: photoCard,
                      duration: 0.3,
                      options: [.transitionFlipFromLeft, .showHideTransitionViews])
  }

  func flipback() {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) { [weak self] in
      guard let strongSelf = self else { return }
      UIView.transition(from: strongSelf.photoCard,
                        to: strongSelf.backgroundCard,
                        duration: 0.3,
                        options: [.transitionFlipFromRight, .showHideTransitionViews])
    }
  }

  func remove() {
    UIView.animate(withDuration: 0.5,
                   delay: 0.5,
                   options: .curveEaseOut,
                   animations: { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.photoCard.alpha = 0
                    strongSelf.backgroundCard.alpha = 0
    })
  }
}

