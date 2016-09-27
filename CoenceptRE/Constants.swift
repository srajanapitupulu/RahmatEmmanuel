//
//  Constants.swift
//  Rahmat Emmanuel
//
//  Created by Reebonz on 9/27/16.
//  Copyright © 2016 srajanapitupulu. All rights reserved.
//

import Foundation
import UIKit

class Constants: NSObject {
  
  static let API_URL = "http://www.rahmatemmanuel.com"
//  static let API_URL = "http://preview.rahmatemmanuel.com"
  
//  static let API_HOME             = String.init(format: "%@/api/?json=1", Constants.API_URL)
  static let API_HOME             = String.init(format: "%@/api/get_page/?slug=home", Constants.API_URL)
  static let API_ABOUT            = String.init(format: "%@/about-webview/", Constants.API_URL)
  static let API_SCHEDULE         = String.init(format: "%@/api/get_page/?slug=location", Constants.API_URL)
  static let API_NEWS             = String.init(format: "%@/api/get_category_posts/?slug=news", Constants.API_URL)
  static let API_VIDEO            = String.init(format: "%@/api/get_category_posts/?slug=sermons", Constants.API_URL)
  static let API_PS_JOSHUA        = String.init(format: "%@/api/get_posts/?post_type=ps-joshua", Constants.API_URL)
  static let API_PASSION          = String.init(format: "%@/passion-webview/", Constants.API_URL)
  static let API_PASSION_LOCATION = String.init(format: "%@/passion-schedule-webview/", Constants.API_URL)
  static let API_NEXT_STEP        = String.init(format: "%@/next-step-webview/", Constants.API_URL)
  static let API_VISION_PARTNERS  = String.init(format: "%@/vision-partners-webview/", Constants.API_URL)
  static let API_INSIDE_OUT       = String.init(format: "%@/inside-out-webview/", Constants.API_URL)
  static let API_BAPTISM          = String.init(format: "%@/baptism-webview/", Constants.API_URL)
  static let API_REBIC            = String.init(format: "%@/rebic-webview/", Constants.API_URL)
  static let API_VOLUNTEERS       = String.init(format: "%@/volunteers-webview/", Constants.API_URL)
  static let API_GIVE             = String.init(format: "%@/give-webview/", Constants.API_URL)
  
  
  static let IDX_MENU_HOME:Int              = 0
  static let IDX_MENU_ABOUT:Int             = 1
  static let IDX_MENU_SCHEDULE:Int          = 2
  static let IDX_MENU_NEWS:Int              = 3
  static let IDX_MENU_VIDEO:Int             = 4
  static let IDX_MENU_PS_JOSHUA:Int         = 5
  static let IDX_MENU_PASSION:Int           = 6
  static let IDX_MENU_PASSION_LOCATION:Int  = 7
  static let IDX_MENU_NEXT_STEP:Int         = 8
  static let IDX_MENU_VISION_PARTNERS:Int   = 9
  static let IDX_MENU_INSIDE_OUT:Int        = 10
  static let IDX_MENU_BAPTISM:Int           = 11
  static let IDX_MENU_REBIC:Int             = 12
  static let IDX_MENU_VOLUNTEERS:Int        = 13
  static let IDX_MENU_GIVE:Int              = 14
}