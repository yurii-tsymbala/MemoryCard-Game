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
    backgroundCard.isHidden = true
    DispatchQueue.main.async { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.photoCard.image = strongSelf.viewModel.cardImageData
    }
  }
}
