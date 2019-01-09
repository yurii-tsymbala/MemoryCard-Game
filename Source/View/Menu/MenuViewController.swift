//
//  MenuViewController.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 12/29/18.
//  Copyright © 2018 Yurii Tsymbala. All rights reserved.
//

import UIKit
import CoreData
import RxSwift
import RxCocoa

class MenuViewController: UIViewController {
  @IBOutlet private weak var coinLabel: UILabel!
  @IBOutlet private weak var coinImageView: UIImageView!
  @IBOutlet private weak var stickerPackpickerView: UIPickerView!
  @IBOutlet private weak var stickerPackLabel: UILabel!
  @IBOutlet private weak var levelsCollectionView: UICollectionView!
  private var myActivityIndicatorView: UIActivityIndicatorView!
  private let levelCollectionViewCellId = "LevelCollectionViewCell"
  private let disposeBag = DisposeBag()
  private var viewModel: MenuViewModel!
  private var router = Router()

  convenience init(viewModel: MenuViewModel) {
    self.init()
    self.viewModel = viewModel
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    observeViewModel()
    viewModel.observingDownloadStatus()
  }

  private func observeViewModel() {
    viewModel.startAnimating
      .subscribe(onNext: { [weak self] in
        guard let strongSelf = self else {return}
        DispatchQueue.main.async {
          strongSelf.startAnimating()
        }
        }, onCompleted: { [weak self] in
          guard let strongSelf = self else {return}
          DispatchQueue.main.async {
            strongSelf.stopAnimating()
          }
      }).disposed(by: disposeBag)
    viewModel.showAlertView
      .subscribe(onNext: { [weak self] alertViewModel in
        guard let strongSelf = self else {return}
        DispatchQueue.main.async {
          strongSelf.showAlert(withViewModel: alertViewModel)
        }
      }).disposed(by: disposeBag)
    viewModel.pickerViewModel.currentStickerPackName
      .subscribe(onNext: { [weak self] currentStickerPackName in
        guard let strongSelf = self else {return}
        strongSelf.stickerPackLabel.text = currentStickerPackName
      }).disposed(by: disposeBag)
    viewModel.startGame
      .subscribe(onNext: { [weak self] gameViewModel in
        guard let strongSelf = self else {return}
        strongSelf.navigateToGame(withViewModel: gameViewModel)
      }).disposed(by: disposeBag)
  }

  private func setupView() {
    setupActivityIndicator()
    setupCollectionView()
    setupPickerView()
    setupStackView()
  }

  private func setupCollectionView() {
    levelsCollectionView.delegate = self
    levelsCollectionView.dataSource = self
    view.backgroundColor = UIColor.Backgrounds.mainYellow
    levelsCollectionView.backgroundColor = UIColor.Backgrounds.mainYellow
    let levelCellNib = UINib(nibName: levelCollectionViewCellId, bundle: nil)
    levelsCollectionView.register(levelCellNib, forCellWithReuseIdentifier: levelCollectionViewCellId)
  }


  private func setupActivityIndicator() {
    myActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    myActivityIndicatorView.center = view.center
    view.addSubview(myActivityIndicatorView)
  }
  private func setupPickerView() {
    stickerPackpickerView.delegate = self
    stickerPackpickerView.dataSource = self
  }

  private func setupStackView() {
    coinImageView.contentMode = .scaleAspectFill
    coinImageView.image = UIImage(named: "coin")
  }

  private func startAnimating() {
    myActivityIndicatorView.isHidden = false
    myActivityIndicatorView.startAnimating()
    userIteractionEnabled(isEnabled: false)
  }

  private func stopAnimating() {
    myActivityIndicatorView.stopAnimating()
    myActivityIndicatorView.isHidden = true
    userIteractionEnabled(isEnabled: true)
  }

  private func userIteractionEnabled(isEnabled: Bool) {
    stickerPackpickerView.isUserInteractionEnabled = isEnabled
    levelsCollectionView.isUserInteractionEnabled = isEnabled
  }

  private func showAlert(withViewModel alertViewModel: AlertViewModel) {
    router.showAlert(alertViewModel, inViewController: self)
  }

  private func navigateToGame(withViewModel viewModel: GameViewModel) {
    let gameViewController = GameViewController(viewModel: viewModel)
    navigationController?.pushViewController(gameViewController, animated: true)
  }
}

extension MenuViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfCells
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = levelsCollectionView.dequeueReusableCell(withReuseIdentifier: levelCollectionViewCellId, for: indexPath) as! LevelCollectionViewCell
    cell.viewModel = viewModel.getCellViewModel(at: indexPath.row)
    return cell
  }
}

extension MenuViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel.selectLevel(atIndex: indexPath.row)
  }
}

extension MenuViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return viewModel.pickerViewModel.numberOfRowsForPicker
  }

  func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    return viewModel.pickerViewModel.viewSizeForRow
  }

  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return viewModel.pickerViewModel.viewSizeForRow
  }

  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    return viewModel.pickerViewModel.setupViewForRow(indexOfTheRow: row)
  }
}

extension MenuViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    viewModel.pickerViewModel.sendInfoToLabel(indexOfTheRow: row)
  }
}
