//
//  LevelCollectionViewCell.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 1/2/19.
//  Copyright © 2019 Yurii Tsymbala. All rights reserved.
//

import UIKit

class LevelCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var levelScoreLabel: UILabel!

  @IBOutlet weak var levelTimeLabel: UILabel!

  @IBOutlet weak var levelCardsAmountLabel: UILabel!

  @IBOutlet weak var levelCardImageView: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
