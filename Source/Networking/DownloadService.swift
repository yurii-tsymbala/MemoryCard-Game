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

 func fetchingData() {
    var defaultUrl = URL(string: "http://www.recipepuppy.com/api/")
    defaultUrl = defaultUrl?.appendingPathComponent("?i=\(newIngredientsString)")
    URLSession.shared.dataTask(with: defaultUrl! ) { (data, response, error) in
      guard let data = data else { return }
      do {
        let decoder = JSONDecoder()
        self.meals = try decoder.decode(Meals.self, from: data)
        self.cellViewModels = (self.meals?.meals.map { MealsCellViewModel($0) })!
        self.reloadingData?()
      } catch let err {
        print("Err", err)
      }
      }.resume()
  }

  //fetchUIImageArray with logic of stickerpack
}
