//
//  LevelCollectionViewCell.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 1/2/19.
//  Copyright © 2019 Yurii Tsymbala. All rights reserved.
//

import UIKit

class LevelCollectionViewCell: UICollectionViewCell {
  @IBOutlet private weak var levelScoreLabel: UILabel!
  @IBOutlet private weak var levelTimeLabel: UILabel!
  @IBOutlet private weak var levelCardsAmountLabel: UILabel!
  @IBOutlet private weak var levelCardImageView: UIImageView!

  var viewModel: LevelCellViewModel! {
    didSet{
      setupView()
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
   setupView()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    setupView()
  }

  func setupView() {
    levelCardImageView.contentMode = .scaleAspectFit
    levelCardImageView.image = UIImage(named: "card")
    levelCardsAmountLabel.text = viewModel.levelCardsNumber
    levelTimeLabel.text = viewModel.levelTime
    levelScoreLabel.text = viewModel.leveScore
  }

}
