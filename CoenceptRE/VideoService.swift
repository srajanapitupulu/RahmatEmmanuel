//
//  VideoService.swift
//  CoenceptRE
//
//  Created by Reebonz on 9/16/16.
//  Copyright © 2016 srajanapitupulu. All rights reserved.
//

import UIKit

protocol DelegateVideoService: NSObjectProtocol {
  func videoServiceResponse(videoData data:[Video])
}

class VideoService: NSObject {
  
  var service: Service!
  var delVideoService: AnyObject!
  
  //MARK: Initialization
  init(delVideoService: DelegateVideoService) {
    self.delVideoService = delVideoService
    
    super.init()
    
    self.service = Service(delService: self)
  }
  
  func getVideosData() {
    self.service.callGETRestAPI(withURL: Constants.API_VIDEO)
  }
}

extension VideoService:DelegateServiceCall {
  func onCallSuccess(withJSON jsonResponse: [String : AnyObject]) {
    var jsonData: [Video] = [Video]()
    
    if let posts: [AnyObject] = jsonResponse["posts"] as? [AnyObject] {
      for indexData in 0..<posts.count {
        if let jObjUserData: [String:AnyObject] = posts[indexData] as? [String:AnyObject] {
          
          let responseData = Video()
          
          if let id = jObjUserData["id"] as? Int,
            let type = jObjUserData["type"] as? String,
            let url = jObjUserData["url"] as? String,
            let title = jObjUserData["title"] as? String,
            let content = jObjUserData["content"] as? String,
            let excerpt = jObjUserData["excerpt"] as? String,
            let date = jObjUserData["date"] as? String,
            let author = jObjUserData["author"] as? [String:AnyObject],
            let imagesArr = jObjUserData["custom_fields"] as? [String:AnyObject]
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
            
            if let authorName = author["first_name"] as? String {
              responseData.author   = authorName
            }
            
            if let videoJSONData = imagesArr["video_link"] as? [String:AnyObject] {
              if let url = videoJSONData["0"] as? String {
                responseData.videoURL = String.init(format: "https://www.youtube.com/watch?v=%@", url)
              }
              if let urlImage = videoJSONData["image"] as? String {
                responseData.imageURL = urlImage
              }
            }
            
//            if let imageJSONData = imagesArr["video_image"] as? [String] {
//              if let url = imageJSONData[0] as? String {
//                responseData.imageURL = url
//              }
//            }
            
            jsonData.append(responseData)
          }
        }
      }
    }
    
    (self.delVideoService as! DelegateVideoService).videoServiceResponse(videoData: jsonData)
  }
  
  func onCallFailed(withErrorMessage error: String) {
    
  }
}