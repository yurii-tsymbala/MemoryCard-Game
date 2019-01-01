//
//  MenuViewController.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 12/29/18.
//  Copyright © 2018 Yurii Tsymbala. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

  @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
  private var viewModel: MenuViewModel!

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
    viewModel.checkAppState { [weak self] (_, error) in
      guard let strongSelf = self else { return }
      if error == nil {
        DispatchQueue.main.async {
          strongSelf.stopAnimating()
        }
      } else {
        DispatchQueue.main.async {
          strongSelf.startAnimating()
        }
      }
    }
  }

  private func startAnimating() {
    activityIndicatorView.isHidden = false
    activityIndicatorView.startAnimating()
    // виконується багато разів
    //userIteraction.deactivate = true
  }

  private func stopAnimating() {
    activityIndicatorView.stopAnimating()
    activityIndicatorView.isHidden = true
    //userIteraction.deactivate = false
    // showAlert()     print("Succesfully downloaded images")
  }

  private func setupView() {
    activityIndicatorView.isHidden = true
  }
}
