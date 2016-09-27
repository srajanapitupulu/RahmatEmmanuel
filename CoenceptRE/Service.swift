//
//  Service.swift
//  Coencept_RE
//
//  Created by Samuel Napitupulu on 8/1/16.
//  Copyright © 2016 Samuel Napitupulu. All rights reserved.
//

import Foundation

protocol DelegateServiceCall: NSObjectProtocol {
  func onCallSuccess(withJSON jsonResponse:[String:AnyObject])
  func onCallFailed(withErrorMessage error:String)
}

class Service:NSObject {
  
  var delService: AnyObject!
  
  //MARK: Initialization
  init(delService: DelegateServiceCall) {
    self.delService = delService
    
    super.init()
  }
  
  
  func callGETRestAPI(withURL urlEndpoint:String) {
    
    guard let url = NSURL(string: urlEndpoint) else {
      (self.delService as! DelegateServiceCall).onCallFailed(withErrorMessage: "Error: cannot create URL")
      return
    }
    
    let urlRequest = NSURLRequest(URL: url)
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    let session = NSURLSession(configuration: config)
    
    let task = session.dataTaskWithRequest(urlRequest) {
      (data, response, error) in
      guard let responseData = data else {
        (self.delService as! DelegateServiceCall).onCallFailed(withErrorMessage: "Error: did not receive data")
        return
      }
      guard error == nil else {
        print(error)
        (self.delService as! DelegateServiceCall).onCallFailed(withErrorMessage: "error calling into URL")
        return
      }
      // parse the result as JSON, since that's what the API provides
      do {
        guard let jsonResponse = try NSJSONSerialization.JSONObjectWithData(responseData, options: []) as? [String: AnyObject] else {
          // TODO: handle
          (self.delService as! DelegateServiceCall).onCallFailed(withErrorMessage: "Couldn't convert received data to JSON dictionary")
          return
        }
        // now we have the todo, let's just print it to prove we can access it
        (self.delService as! DelegateServiceCall).onCallSuccess(withJSON: jsonResponse)
        
      } catch  {
        (self.delService as! DelegateServiceCall).onCallFailed(withErrorMessage: "error trying to convert data to JSON")
      }
    }
    task.resume()
  }
}
