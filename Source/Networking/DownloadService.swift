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
  case tenthError
  case eleventhError
}

protocol DownloadServiceType {
  func confirmTheDownload(completion: @escaping (Result<Bool, Error>) -> Void)
  //func fetchUIImageArray() with logic of stickerpack // буду повертати юайімеджі 1)в залежноті від стікерпаку
  //  private var images: [ImageMO] = []                                             2) кількість карток/2
  //                                                                                 3) зарандомити
  //  на вході функції потрібно вказати назву стікепарку і кількість карточок в левелі щоб повернути рандомні карточки
  // передивитись логіку з попередньої апки
  //  func fetchdata() {
  //  var fetchResultController: NSFetchedResultsController<ImageMO>
  //  let fetchRequest: NSFetchRequest<ImageMO> = ImageMO.fetchRequest()
  //  let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
  //  fetchRequest.sortDescriptors = [sortDescriptor]
  //  if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
  //  let context = appDelegate.persistentContainer.viewContext
  //  fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
  //  managedObjectContext: context,
  //  sectionNameKeyPath: nil,
  //  cacheName: nil)
  //  do {
  //  try fetchResultController.performFetch()
  //  if let fetchedObjects = fetchResultController.fetchedObjects {
  //  images = fetchedObjects
  //  }
  //  } catch {
  //  print(error)
  //  }
  //  }
  //  }

//  private func fetchdata() {  //  приклад як витягувати
//  var images: [ImageMO] = []
//  var fetchResultController: NSFetchedResultsController<ImageMO>
//  let fetchRequest: NSFetchRequest<ImageMO> = ImageMO.fetchRequest()
//  let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//  fetchRequest.sortDescriptors = [sortDescriptor]
//  if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
//  let context = appDelegate.persistentContainer.viewContext
//  fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
//  managedObjectContext: context,
//  sectionNameKeyPath: nil,
//  cacheName: nil)
//  do {
//  try fetchResultController.performFetch()
//  if let fetchedObjects = fetchResultController.fetchedObjects {
//  images = fetchedObjects
//  print(images[0].name)
//  print(images[0].image)
//  }
//  } catch {
//  print(error)
//  }
//  }
//  }


}

class DownloadService: DownloadServiceType {

  private func fetchData() {

  }

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
