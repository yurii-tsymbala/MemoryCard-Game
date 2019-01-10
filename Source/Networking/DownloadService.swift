//
//  DownloadService.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 12/29/18.
//  Copyright © 2018 Yurii Tsymbala. All rights reserved.
//

import UIKit
import CoreData

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
  case tenthError
  case eleventhError
}

protocol DownloadServiceType {
  func confirmTheDownload(completion: @escaping (Result<Bool, Error>) -> Void)
  func generateCards(forLevel level: Level, completion: @escaping (Result<[CardCellViewModel],Error>) -> Void)
  //func fetchUIImageArray() with logic of stickerpack // буду повертати юайімеджі 1)в залежноті від стікерпаку
  //  private var images: [ImageMO] = []                                             2) кількість карток/2
  //                                                                                 3) зарандомити
  //  на вході функції потрібно вказати назву стікепарку і кількість карточок в левелі щоб повернути рандомні карточки
  // передивитись логіку з попередньої апки

}

class DownloadService: DownloadServiceType {

  private var images: [Image]!
  private var imagesData = [ImageData]()

  func confirmTheDownload(completion: @escaping (Result<Bool, Error>) -> Void) {
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

  func generateCards(forLevel level: Level, completion: @escaping (Result<[CardCellViewModel],Error>) -> Void) { // переробити з  комплішеном
    var images: [ImageMO]
    var cardArray = [CardCellViewModel]()
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest:NSFetchRequest<ImageMO> = ImageMO.fetchRequest()
    let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptor]
    do {
      images = try managedContext.fetch(fetchRequest)
      for _ in 1...(Int(level.cardsNumber)! / 2) {
        let randomNumber = arc4random_uniform(30)+1
        switch level.stickerPackName {
        case .cars:
          if let data = images[Int(randomNumber)].image {
            let cardOne = CardCellViewModel()
            cardOne.cardImageName = images[Int(randomNumber)].name!
            cardOne.cardImageData = UIImage(data: data)
            let cardTwo = CardCellViewModel()
            cardTwo.cardImageName = images[Int(randomNumber)].name!
            cardTwo.cardImageData = UIImage(data: data)
            cardArray.append(cardOne)
            cardArray.append(cardTwo)
          }
        case .pockemons:
          if let data = images[Int(randomNumber)].image {
            let cardOne = CardCellViewModel()
            cardOne.cardImageName = images[Int(randomNumber+61)].name!
            cardOne.cardImageData = UIImage(data: data)
            let cardTwo = CardCellViewModel()
            cardTwo.cardImageName = images[Int(randomNumber+61)].name!
            cardTwo.cardImageData = UIImage(data: data)
            cardArray.append(cardOne)
            cardArray.append(cardTwo)
          }
        case .food:
          if let data = images[Int(randomNumber)].image {
            let cardOne = CardCellViewModel()
            cardOne.cardImageName = images[Int(randomNumber+30)].name!
            cardOne.cardImageData = UIImage(data: data)
            let cardTwo = CardCellViewModel()
            cardTwo.cardImageName = images[Int(randomNumber+30)].name!
            cardTwo.cardImageData = UIImage(data: data)
            cardArray.append(cardOne)
            cardArray.append(cardTwo)
          }
        }
      }

      //MARK: Randoming cards in Array
      var randomCardArray = [CardCellViewModel]()
      var upperLimit:UInt = UInt(level.cardsNumber)!
      var randomlyGeneratedNumber: Int
      let cardsNumber = Int(level.cardsNumber)!

      for _ in 1...(cardsNumber) {
        randomlyGeneratedNumber = Int(arc4random_uniform(UInt32(upperLimit)))
        randomCardArray.append(cardArray[randomlyGeneratedNumber])
        cardArray.remove(at: randomlyGeneratedNumber)
        upperLimit -= 1
      }
      
      completion(Result.success(randomCardArray))

    } catch let error as NSError {
      completion(Result.failure(error))
    }
  }

  private func fetchDataFromJSON(completion: @escaping (Result<[ImageData], Error>) -> Void) {
    let jsonURL = URL(string: "https://raw.githubusercontent.com/yurii-tsymbala/Assets/master/images.json")!
    URLSession.shared.dataTask(with: jsonURL) { [weak self]  (data,_,error) in
      guard let strongSelf = self else { return }
      if error == nil {
        guard let data = data else { completion(Result.failure(DownloadServiceError.thirdError)); return }
        do {
          let decoder = JSONDecoder()
          strongSelf.images = try decoder.decode([Image].self, from: data)
          if let successfullyParsedImages = strongSelf.images {
            for image in successfullyParsedImages {
              DispatchQueue.global().async {
                let dataURL = URL(string: image.link)!
                let data = try? Data(contentsOf: dataURL)
                guard let downloadedData = data else {completion(Result.failure(DownloadServiceError.tenthError));return}
                let imageData = ImageData(name: image.name, data: downloadedData)
                strongSelf.imagesData.append(imageData)
                if strongSelf.imagesData.count == 92 {
                  completion(Result.success(strongSelf.imagesData))
                }
              }
            }
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

  private func saveToCoreData(images: [ImageData], completion: @escaping (Result<Bool, Error>) -> Void ) {
    DispatchQueue.main.async {
      if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
        for image in images {
          let imageManagedObject = ImageMO(context: appDelegate.persistentContainer.viewContext)
          imageManagedObject.name = image.name
          imageManagedObject.image = image.data
        }
        if let error = appDelegate.saveContext() {
          completion(Result.failure(error))
        } else {
          completion(Result.success(true))
        }
      } else {
        completion(Result.failure(DownloadServiceError.ninthError))
      }
    }
  }
}
