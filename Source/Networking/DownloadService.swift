//
//  DownloadService.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 12/29/18.
//  Copyright © 2018 Yurii Tsymbala. All rights reserved.
//

import UIKit

enum DownloadServiceError: Error {
  case firstError
  case secondError
  case thirdError
  case fourthError
  case fifthError
  case sixthError
  case seventhError
  case eighthError
  case ninthError
}

protocol DownloadServiceType {
  func checkTheDownload(completion: @escaping (Result<Bool, Error>) -> Void)
  //func fetchUIImageArray() with logic of stickerpack
}

class DownloadService: DownloadServiceType {

  private var images: [Image]!

  func checkTheDownload(completion: @escaping (Result<Bool, Error>) -> Void) {
    fetchDataFromJSON { [weak self] fetchDataResult in
      guard let strongSelf = self else { return }
      switch fetchDataResult {
      case .success(let images):
        strongSelf.saveToCoreData(images: images, completion: { coreDataResult in
          switch coreDataResult {
          case .success(let isSaved):
            completion(Result.success(isSaved))
          case .failure(let error):
            completion(Result.failure(error))
          }
        })
      case .failure(let error):
        completion(Result.failure(error))
      }
    }
  }

  private func fetchDataFromJSON(completion: @escaping (Result<[Image], Error>) -> Void) {
    let jsonURL = URL(string: "https://raw.githubusercontent.com/yurii-tsymbala/Assets/master/images.json")!
    URLSession.shared.dataTask(with: jsonURL) { [weak self]  (data,_,error) in
      guard let strongSelf = self else { return }
      if error == nil {
        guard let data = data else { completion(Result.failure(DownloadServiceError.thirdError)); return }
        do {
          let decoder = JSONDecoder()
          strongSelf.images = try decoder.decode([Image].self, from: data)
          if let successfullyParsedImages = strongSelf.images {
            completion(Result.success(successfullyParsedImages))
          } else {
            completion(Result.failure(DownloadServiceError.fifthError))
          }
        } catch _ {
          completion(Result.failure(DownloadServiceError.fourthError))
        }
      } else {
        if let _ = error {
          completion(Result.failure(DownloadServiceError.firstError))
        } else {
          completion(Result.failure(DownloadServiceError.secondError))
        }
      }
      }.resume()
  }

  private func saveToCoreData(images: [Image], completion: @escaping (Result<Bool, Error>) -> Void ) {
    if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
      for image in images {
        let imageManagedObject = ImageMO(context: appDelegate.persistentContainer.viewContext)
        DispatchQueue.global().async {
          let dataURL = URL(string: image.link)!
          let data = try? Data(contentsOf: dataURL)
          if let successfullDownloadedData = data  {
            imageManagedObject.image = successfullDownloadedData
            imageManagedObject.name = image.name
            appDelegate.saveContext()
            completion(Result.success(true))
          } else {
            completion(Result.failure(DownloadServiceError.ninthError))
          }
        }
      }
    } else {
      completion(Result.failure(DownloadServiceError.eighthError))
    }
  }

//  func fetchingData(completion: @escaping (Result<Bool, Error>) -> Void) {
//    let jsonURL = URL(string: "https://raw.githubusercontent.com/yurii-tsymbala/Assets/master/images.json")!
//    URLSession.shared.dataTask(with: jsonURL) { (data, response, error) in
//      guard let data = data else { return }
//      do {
//        let decoder = JSONDecoder()
//        self.images = try decoder.decode([Image].self, from: data)
//        print(self.images)
//
//        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
//          for image in self.images {
//            let imageMO = ImageMO(context: appDelegate.persistentContainer.viewContext)
//            DispatchQueue.global().async {
//              let dataURL = URL(string: image.link)!
//              let data = try? Data(contentsOf: dataURL)
//              DispatchQueue.main.async {
//                imageMO.image = data
//                imageMO.name = image.name
//                appDelegate.saveContext()
//              }
//            }
//          }
//        }
//      } catch let err {
//        print("Err", err)
//      }
//      }.resume()
//  }


}
