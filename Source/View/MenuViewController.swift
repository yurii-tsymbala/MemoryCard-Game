//
//  MenuViewController.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 12/29/18.
//  Copyright © 2018 Yurii Tsymbala. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

  private var viewModel: MenuViewModel!

  convenience init(viewModel: MenuViewModel) {
    self.init()
    self.viewModel = viewModel
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.checkAppState { (isInstalled, error) in
      if error == nil {
        if isInstalled {
         print("Succesfully downloaded images")
         // UIActivityIndicatorView.islala = false
           //userIteraction.deactivate = false
        }
      } else {
      // UIActivityIndicatorView.islala = true
        //userIteraction.deactivate = true
      }


    }
    // print in console images from Core Data 46.26 video
  }
}
