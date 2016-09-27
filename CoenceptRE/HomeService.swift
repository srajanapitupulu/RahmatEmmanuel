//
//  HomeService.swift
//  CoenceptRE
//
//  Created by Reebonz on 9/16/16.
//  Copyright © 2016 srajanapitupulu. All rights reserved.
//

import UIKit

protocol DelegateHomeService: NSObjectProtocol {
  func homeServiceResponse(homeData data:[Home])
}

class HomeService: NSObject {
  
  var service: Service!
  var delHomeService: AnyObject!
  
  //MARK: Initialization
  init(delHomeService: DelegateHomeService) {
    self.delHomeService = delHomeService
    
    super.init()
    
    self.service = Service(delService: self)
  }
  
  func getHomeData() {
    self.service.callGETRestAPI(withURL: Constants.API_HOME)
  }
}

extension HomeService:DelegateServiceCall {
  func onCallSuccess(withJSON jsonResponse: [String : AnyObject]) {
    var jsonData: [Home] = [Home]()
    
    if let page = jsonResponse["page"] {
      if let attachment: [AnyObject] = page["attachments"] as? [AnyObject] {
        for indexData in 0..<attachment.count {
          if let jObjUserData: [String:AnyObject] = attachment[indexData] as? [String:AnyObject] {
            
            var responseData = Home()
            
            if let id = jObjUserData["id"] as? Int,
              let imagesArr = jObjUserData["images"] as? [String:AnyObject],
              let title = jObjUserData["title"] as? String,
              let description = jObjUserData["description"] as? String
            {
              responseData.ID          = String.init(format:"%d", id)
              responseData.URL         = ""
              responseData.TITLE       = title
              responseData.DESCRIPTION = description
              
              if let imageJSONData = imagesArr["medium"] as? [String:AnyObject] {
                if let url = imageJSONData["url"] as? String {
                  responseData.URL = url
                }
              }
              
              jsonData.append(responseData)
            }
          }
        }
      }
    }
    
    (self.delHomeService as! DelegateHomeService).homeServiceResponse(homeData: jsonData)
  }
  
  func onCallFailed(withErrorMessage error: String) {
    print("GAGAL CUK : \(error)")
  }
}