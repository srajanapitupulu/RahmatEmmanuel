//
//  NewsService.swift
//  CoenceptRE
//
//  Created by Reebonz on 9/16/16.
//  Copyright © 2016 srajanapitupulu. All rights reserved.
//

import UIKit

protocol DelegateNewsService: NSObjectProtocol {
  func newsServiceResponse(newsData data:[News])
}

class NewsService: NSObject {
  
  var service: Service!
  var delNewsService: AnyObject!
  
  //MARK: Initialization
  init(delNewsService: DelegateNewsService) {
    self.delNewsService = delNewsService
    
    super.init()
    
    self.service = Service(delService: self)
  }
  
  func getNewsData() {
    self.service.callGETRestAPI(withURL: Constants.API_NEWS)
  }
}

extension NewsService:DelegateServiceCall {
  func onCallSuccess(withJSON jsonResponse: [String : AnyObject]) {
    var jsonData: [News] = [News]()
    
//    if let page = jsonResponse["page"] {
      if let posts: [AnyObject] = jsonResponse["posts"] as? [AnyObject] {
        for indexData in 0..<posts.count {
          if let jObjUserData: [String:AnyObject] = posts[indexData] as? [String:AnyObject] {
            
            let responseData = News()
            
            if let id = jObjUserData["id"] as? Int,
              let type = jObjUserData["type"] as? String,
              let url = jObjUserData["url"] as? String,
              let title = jObjUserData["title"] as? String,
              let content = jObjUserData["content"] as? String,
              let excerpt = jObjUserData["excerpt"] as? String,
              let date = jObjUserData["date"] as? String,
              let author = jObjUserData["author"] as? [String:AnyObject],
              let imagesArr = jObjUserData["thumbnail_images"] as? [String:AnyObject]
            {
              
              responseData.Id       = String.init(format:"%d", id)
              responseData.type     = type
              responseData.url      = url
              responseData.title    = title
              responseData.content  = content
              responseData.excerpt  = excerpt
              responseData.date     = date
              
              responseData.author   = ""
              responseData.authorId = ""
              
              responseData.imageURL = ""
              
//              if let authorID = author["id"] as? String,
              if let authorName = author["first_name"] as? String {
                responseData.author   = authorName
//                responseData.authorId = authorID
              }
              
              if let imageJSONData = imagesArr["medium"] as? [String:AnyObject] {
                if let url = imageJSONData["url"] as? String {
                  responseData.imageURL = url
                }
              }
              
              jsonData.append(responseData)
            }
          }
        }
      }
//    }
    
    (self.delNewsService as! DelegateNewsService).newsServiceResponse(newsData: jsonData)
  }
  
  func onCallFailed(withErrorMessage error: String) {
    
  }
}