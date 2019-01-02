//
//  AlertViewController.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 1/2/19.
//  Copyright © 2019 Yurii Tsymbala. All rights reserved.
//

import UIKit

class AlertViewController: UIAlertController {

  var viewModel: AlertViewModel?

  override func viewDidLoad() {
    super.viewDidLoad()
    self.message = viewModel?.message
    self.title = viewModel?.title
    addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
  }

}
