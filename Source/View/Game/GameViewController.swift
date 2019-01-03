//
//  GameViewController.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 1/3/19.
//  Copyright © 2019 Yurii Tsymbala. All rights reserved.
//

import UIKit
import CoreData
import RxSwift
import RxCocoa

class GameViewController: UIViewController {
  @IBOutlet private weak var cardCollectionView: UICollectionView!
  @IBOutlet private weak var timerLabel: UILabel!
  @IBOutlet private weak var flipCountLabel: UILabel!
  @IBOutlet private weak var menuButton: UIButton!
  @IBOutlet private weak var gameStackView: UIStackView!
  private let cardCollectionViewCellId = "CardCollectionViewCell"
  private let disposeBag = DisposeBag()
  private var viewModel: GameViewModel!

  convenience init(viewModel: GameViewModel) {
    self.init()
    self.viewModel = viewModel
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    observeViewModel()
  }

  private func observeViewModel() {

  }

  private func setupView() {
    setupCollectionView()
    setupMenuButton()
  }

  private func setupCollectionView() {
    cardCollectionView.delegate = self
    cardCollectionView.dataSource = self
    let cardCellNib = UINib(nibName: cardCollectionViewCellId, bundle: nil)
    cardCollectionView.register(cardCellNib, forCellWithReuseIdentifier: cardCollectionViewCellId)
  }

  private func setupMenuButton() {
    menuButton.addTarget(self, action: #selector(pressedMenuButton), for: .touchUpInside)
  }

  @objc
  private func pressedMenuButton() {

  }


}

extension GameViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    <#code#>
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    <#code#>
  }


}
extension GameViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

  }

}
extension GameViewController: UICollectionViewDelegateFlowLayout {

}
