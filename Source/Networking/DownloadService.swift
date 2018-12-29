//
//  DownloadService.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 12/29/18.
//  Copyright © 2018 Yurii Tsymbala. All rights reserved.
//

import UIKit

protocol DownloadServiceType {
  func downloadImagesToDB()

}

class DownloadService: DownloadServiceType {

  var image: ImageMO!

  func downloadImagesToDB() {

    
    if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
      image = ImageMO(context: appDelegate.persistentContainer.viewContext)


    }
    // викачати з інтернету  якшо успішно то зберегти в базу даних і якшо успішно то я викличу цю функцію і поставлю значенння в юзердефолтс сервісі шо фотки збережені

  }

  //fetchUIImageArray with logic of stickerpack
}
