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
  //func fetchUIImageArray() with logic of stickerpack
}

class DownloadService: DownloadServiceType {

  var images: [Image]!

  func downloadImagesToDB() {
    /* парсанути джейсонку і зберегти обєкти в структуру Images
     цю структурку пройтись масивом і зберегти в кордату
     в юзердефолтс сервісі поставити апкаскачана = тру


     // викачати з інтернету  якшо успішно то зберегти в базу даних і якшо успішно то я викличу цю функцію і поставлю значенння в юзердефолтс сервісі шо фотки збережені
     */




  }

  func fetchingData(completion: @escaping (Result<Bool, Error>) -> Void) {
    let jsonURL = URL(string: "https://raw.githubusercontent.com/yurii-tsymbala/Assets/master/images.json")!
    URLSession.shared.dataTask(with: jsonURL) { (data, response, error) in
      guard let data = data else { return }
      do {
        let decoder = JSONDecoder()
        self.images = try decoder.decode([Image].self, from: data)
        print(self.images)

        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
          for image in self.images {
            let imageMO = ImageMO(context: appDelegate.persistentContainer.viewContext)
            DispatchQueue.global().async {
              let dataURL = URL(string: image.link)!
              let data = try? Data(contentsOf: dataURL)
              DispatchQueue.main.async {
                imageMO.image = data
                imageMO.name = image.name
                appDelegate.saveContext()
              }
            }
          }
        }
      } catch let err {
        print("Err", err)
      }
      }.resume()
  }


}
