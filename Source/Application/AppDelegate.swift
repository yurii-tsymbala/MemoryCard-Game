//
//  AppDelegate.swift
//  MemoryCard Game
//
//  Created by Yurii Tsymbala on 12/29/18.
//  Copyright © 2018 Yurii Tsymbala. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    setupView()
    return true
  }

  private func setupView() {
    let menuViewController = MenuViewController(viewModel: MenuViewModel(userDefaultsServive: UserDefaultsService(downloadService: DownloadService()), pickerViewModel: PickerViewModel()))
    let navigationController = UINavigationController(rootViewController: menuViewController)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    navigationController.isNavigationBarHidden = true
  }

  func applicationWillTerminate(_ application: UIApplication) {
    if let error = self.saveContext() {
      print(error)
    }
  }

  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Source")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()

  // MARK: - Core Data Saving support

  func saveContext () -> NSError? {
    var nsError: NSError?
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        nsError = error as NSError
        fatalError("Unresolved error \(nsError!), \(nsError!.userInfo)")
      }
    }
    return nsError
  }
}



