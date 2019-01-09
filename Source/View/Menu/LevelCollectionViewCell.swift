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

  override func prepareForReuse() {
    super.prepareForReuse()
    setupView()
  }

  func setupView() {
    cellDesign(cell: self)
    levelCardImageView.contentMode = .scaleAspectFit
    levelCardImageView.image = UIImage(named: "card")
    levelCardsAmountLabel.text = viewModel.levelCardsNumber
    levelTimeLabel.text = "Best Time : \(viewModel.levelTime) sec"
    levelScoreLabel.text = "Best Score : \(viewModel.leveScore) tries"
  }

  private func cellDesign(cell: UICollectionViewCell) {
    cell.backgroundColor = #colorLiteral(red: 0.9313516021, green: 0.8973634243, blue: 0.3806837201, alpha: 1)
    cell.layer.cornerRadius = CGFloat.Design.CornerRadius
    cell.layer.borderWidth = CGFloat.Design.BorderWidth
    cell.alpha = 0
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
    UIView.animate(withDuration: 0.6, animations: { () -> Void in
      cell.alpha = 1
      cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
    })
  }

}
