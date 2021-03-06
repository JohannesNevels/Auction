//
//  ItemsInteractor.swift
//  Auction
//
//  Created by Raymond Law on 1/17/18.
//  Copyright (c) 2018 Clean Swift LLC. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import RealmSwift

protocol ItemsBusinessLogic
{
  func fetchItems(request: Items.FetchItems.Request)
}

protocol ItemsDataStore
{
}

class ItemsInteractor: ItemsBusinessLogic, ItemsDataStore, RealmWorkerDelegate
{
  var presenter: ItemsPresentationLogic?
  var worker: ItemsWorker?
  
  // MARK: Fetch items
  
  var items: Results<Item>?
  
  func fetchItems(request: Items.FetchItems.Request)
  {
    RealmWorker.shared.addDelegate(delegate: self)
    refreshItems()
  }
  
  // MARK: Refresh items
  
  private func refreshItems()
  {
    if items?.realm == nil {
      if RealmWorker.shared.realm != nil {
        items = RealmWorker.shared.realm.objects(Item.self)
      }
    }
    let response = Items.FetchItems.Response(items: items)
    presenter?.presentFetchItems(response: response)
  }
  
  // MARK: RealmWorkerDelegate
  
  func realmWorkerHasChanged()
  {
    refreshItems()
  }
}
