//
//  MenuViewController.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 12/29/18.
//  Copyright © 2018 Yurii Tsymbala. All rights reserved.
//

import UIKit
import CoreData

class MenuViewController: UIViewController {
  @IBOutlet private weak var scoresStackView: UIStackView!
  @IBOutlet private weak var coinLabel: UILabel!
  @IBOutlet private weak var coinImageView: UIImageView!
  @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
  @IBOutlet private weak var stickerPackpickerView: UIPickerView!
  @IBOutlet private weak var stickerPackLabel: UILabel!
  @IBOutlet private weak var levelsCollectionView: UICollectionView!
  private var viewModel: MenuViewModel!
  private let levelCollectionViewCellId = "LevelCollectionViewCell"

  convenience init(viewModel: MenuViewModel) {
    self.init()
    self.viewModel = viewModel
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    observeViewModel()
  }

  private func observeViewModel() {
  // має наглядатись чи крутитись/зупинятись індикатору, презентати алерти
  }

  private func startAnimating() {
    activityIndicatorView.isHidden = false
    activityIndicatorView.startAnimating()
    scoresStackView.isUserInteractionEnabled = false
    stickerPackpickerView.isUserInteractionEnabled = false
    levelsCollectionView.isUserInteractionEnabled = false
    //userIteraction всіх юайних елементів вирубати.deactivate = true
  }

  private func stopAnimating() {
    activityIndicatorView.stopAnimating()
    activityIndicatorView.isHidden = true
    scoresStackView.isUserInteractionEnabled = true
    stickerPackpickerView.isUserInteractionEnabled = true
    levelsCollectionView.isUserInteractionEnabled = true
    //userIteraction всіх юайних елементів включити
    // showAlert()     print("Succesfully downloaded images")
  }

  private func setupView() {
    setupCollectionView()
    activityIndicatorView.isHidden = true
  }

  private func setupCollectionView() {
    levelsCollectionView.delegate = self
    levelsCollectionView.dataSource = self
    let levelCellNib = UINib(nibName: levelCollectionViewCellId, bundle: nil)
    levelsCollectionView.register(levelCellNib, forCellWithReuseIdentifier: levelCollectionViewCellId)
  }
}

extension MenuViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = levelsCollectionView.dequeueReusableCell(withReuseIdentifier: levelCollectionViewCellId, for: indexPath) as! LevelCollectionViewCell
    return cell
  }

}
extension MenuViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  }
}
