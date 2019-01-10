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
  private let cellMagrings: CGFloat = 5
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
    viewModel.generateCardsForLevel()
  }

  private func observeViewModel() {
    viewModel.reloadData
      .subscribe(onNext: { [weak self] in
        guard let strongSelf = self else { return }
        DispatchQueue.main.async {
          strongSelf.cardCollectionView.reloadData()
        }
      }).disposed(by: disposeBag)
  }

  private func setupView() {
    view.backgroundColor = UIColor.Backgrounds.mainYellow
    cardCollectionView.backgroundColor = UIColor.Backgrounds.mainYellow
    menuButton.backgroundColor = UIColor.Backgrounds.darkOrange
    menuButton.layer.borderWidth = CGFloat.Design.buttonBorderWidth / 4
    timerLabel.backgroundColor = UIColor.Backgrounds.mediumOrange
    timerLabel.layer.borderWidth = CGFloat.Design.buttonBorderWidth / 4
    flipCountLabel.backgroundColor = UIColor.Backgrounds.lightOrange
    flipCountLabel.layer.borderWidth = CGFloat.Design.buttonBorderWidth / 4
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
    return viewModel.numberOfCells
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: cardCollectionViewCellId, for: indexPath)
    if let cardCell = cell as? CardCollectionViewCell {
     cardCell.viewModel = viewModel.getCellViewModel(at: indexPath.row)
    }
    return cell
  }
}

extension GameViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

  }

}
extension GameViewController: UICollectionViewDelegateFlowLayout {

 private func cellsRowAndColomn() -> (cellInRow: Int, cellInColomn: Int) {
    var cellInRow = Int(floor(sqrt(Double(viewModel.level.cardsNumber)!)))
    while (Int(viewModel.level.cardsNumber)! % cellInRow != 0) {
      cellInRow -= 1
      if (cellInRow == 1) {
        break
      }
    }
    let cellInColomn = Int(viewModel.level.cardsNumber)!  / cellInRow
    return (cellInRow, cellInColomn)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let screenWidth = collectionView.frame.width
    let screenHeight = collectionView.frame.height
    let cell = cellsRowAndColomn()
    if (screenWidth < screenHeight) {
      return CGSize(width: screenWidth / CGFloat(cell.cellInRow) - cellMagrings,
                    height: screenHeight/CGFloat(cell.cellInColomn) - cellMagrings)
    } else {
      return CGSize(width: screenWidth / CGFloat(cell.cellInColomn) - cellMagrings,
                    height: screenHeight / CGFloat(cell.cellInRow) - cellMagrings)
    }
  }
}
