//
//  AboutViewController.swift
//  CoenceptRE
//
//  Created by Reebonz on 9/8/16.
//  Copyright © 2016 srajanapitupulu. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
  
  @IBOutlet weak var vwHeader:HeaderView!
  @IBOutlet weak var vwMain:UIView!
  
  @IBOutlet weak var loadingView:UIActivityIndicatorView!
  @IBOutlet weak var webVwAbout:UIWebView!
  
  var leftMenuView = LeftMenuViewController()
  
  var sbMain:UIStoryboard!
  
  var intWebViewType: Int!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.sbMain = UIStoryboard.init(name: "Main", bundle: nil)
    
    self.vwHeader.delHeaderView = self
    self.leftMenuView.delLeftMenu = self
    
    self.vwHeader.lblTitle.text = "About"
    
    self.addChildViewController(leftMenuView)
    
    var menuFrame = self.leftMenuView.view.frame
    
    menuFrame.origin.x = 0 - menuFrame.size.width
    menuFrame.origin.y = 0
    menuFrame.size.height = self.view.frame.size.height
    
    self.leftMenuView.view.frame = menuFrame
    
    self.view.addSubview(leftMenuView.view)
    self.view.sendSubviewToBack(leftMenuView.view)
    self.leftMenuView.didMoveToParentViewController(self)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    
    var url = NSURL()
    
    switch self.intWebViewType {
    case Constants.IDX_MENU_PASSION: // PASSION
      self.vwHeader.lblTitle.text = "Passion"
      url = NSURL(string: Constants.API_PASSION)!
      break
    case Constants.IDX_MENU_PASSION_LOCATION: // PASSION LOCATION
      self.vwHeader.lblTitle.text = "Passion Schedule"
      url = NSURL(string: Constants.API_PASSION_LOCATION)!
      break
    case Constants.IDX_MENU_VISION_PARTNERS: // VISION PARTNERS
      self.vwHeader.lblTitle.text = "Vision Partners"
      url = NSURL(string: Constants.API_VISION_PARTNERS)!
      break
    case Constants.IDX_MENU_NEXT_STEP: // RE: NEXT STEP
      self.vwHeader.lblTitle.text = "Join"
      url = NSURL(string: Constants.API_NEXT_STEP)!
      break
    case Constants.IDX_MENU_INSIDE_OUT: // INSIDE OUT
      self.vwHeader.lblTitle.text = "Inside Out"
      url = NSURL(string: Constants.API_INSIDE_OUT)!
      break
    case Constants.IDX_MENU_BAPTISM: // BAPTISM
      self.vwHeader.lblTitle.text = "Baptism"
      url = NSURL(string: Constants.API_BAPTISM)!
      break
    case Constants.IDX_MENU_REBIC: // REBIC
      self.vwHeader.lblTitle.text = "Rebic"
      url = NSURL(string: Constants.API_REBIC)!
      break
    case Constants.IDX_MENU_VOLUNTEERS: // VOLUNTEERS
      self.vwHeader.lblTitle.text = "Volunteers"
      url = NSURL(string: Constants.API_VOLUNTEERS)!
      break
    case Constants.IDX_MENU_GIVE: // GIVE
      self.vwHeader.lblTitle.text = "Give"
      url = NSURL(string: Constants.API_GIVE)!
      break
    default: // ABOUT
      self.vwHeader.lblTitle.text = "About"
      url = NSURL(string: Constants.API_ABOUT)!
      break
    }
    
    let requestObj = NSURLRequest(URL: url);
    self.webVwAbout.loadRequest(requestObj)
    
    self.loadingView.startAnimating()
    self.loadingView.hidden = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func showLeftMenu() {
    UIView.animateWithDuration(0.25, animations: {
      
      var viewRect = self.vwMain.frame
      viewRect.origin.x = 0 + self.leftMenuView.view.frame.size.width
      self.vwMain.frame = viewRect
      self.vwMain.layoutIfNeeded()
      
      var menuFrame = self.leftMenuView.view.frame
      menuFrame.origin.x = 0
      self.leftMenuView.view.frame = menuFrame
      
      }, completion: { (blnFinish) -> Void in
        
        self.leftMenuView.isLeftMenuShown = !self.leftMenuView.isLeftMenuShown
    })
  }
  
  func dismissLeftMenu() {
    UIView.animateWithDuration(0.25, animations: {
      
      var viewRect = self.vwMain.frame
      viewRect.origin.x = 0
      self.vwMain.frame = viewRect
      self.vwMain.layoutIfNeeded()
      
      var menuFrame = self.leftMenuView.view.frame
      menuFrame.origin.x = 0 - menuFrame.size.width
      self.leftMenuView.view.frame = menuFrame
      
      }, completion: { (blnFinish) -> Void in
        
        self.leftMenuView.isLeftMenuShown = !self.leftMenuView.isLeftMenuShown
    })
  }
}

extension AboutViewController:UIWebViewDelegate {
  func webViewDidFinishLoad(webView: UIWebView) {
    self.loadingView.stopAnimating()
    self.loadingView.hidden = true
  }
}

extension AboutViewController:DelegateLeftMenu {
  func doGoToHome(){
    self.dismissLeftMenu()
    var homeVC = ViewController()
    homeVC = sbMain.instantiateViewControllerWithIdentifier("MainViewController") as! ViewController
    self.presentViewController(homeVC, animated: true, completion: nil)
  }
  
  func doGoToSchedule(){
    self.dismissLeftMenu()
    var scheduleVC = ScheduleViewController()
    scheduleVC = sbMain.instantiateViewControllerWithIdentifier("ScheduleViewController") as! ScheduleViewController
    
    let navController = UINavigationController.init(rootViewController: scheduleVC)
    self.presentViewController(navController, animated: true, completion: nil)
  }
  
  func doGoToNews(){
    self.dismissLeftMenu()
    var newsVC = NewsViewController()
    newsVC = sbMain.instantiateViewControllerWithIdentifier("NewsViewController") as! NewsViewController
    
    let navController = UINavigationController.init(rootViewController: newsVC)
    self.presentViewController(navController, animated: true, completion: nil)
  }
  
  func doGoToVideo(){
    self.dismissLeftMenu()
    var videoVC = VideosViewController()
    videoVC = sbMain.instantiateViewControllerWithIdentifier("VideosViewController") as! VideosViewController
    
    let navController = UINavigationController.init(rootViewController: videoVC)
    self.presentViewController(navController, animated: true, completion: nil)
  }
  
  func doGoToCorner(){
    self.dismissLeftMenu()
    var cornerVC = PSCornerViewController()
    cornerVC = sbMain.instantiateViewControllerWithIdentifier("PSCornerViewController") as! PSCornerViewController
    
    let navController = UINavigationController.init(rootViewController: cornerVC)
    self.presentViewController(navController, animated: true, completion: nil)
  }
  
  
  // BELOW HERE IS FOR WEBVIEW
  
  func doGoToAbout(){
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_ABOUT
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToPassion() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_PASSION
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToPassionLocation() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_PASSION_LOCATION
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToJoin() {
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_NEXT_STEP
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToVisionPartners() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_VISION_PARTNERS
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToInsideOut() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_INSIDE_OUT
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToBaptism() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_BAPTISM
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToRebic() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_REBIC
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToVolunteers() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_VOLUNTEERS
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToGive() {
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_GIVE
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
}

extension AboutViewController:DelegateHeaderView {
  func doOpenLeftMenu() {
    if self.leftMenuView.isLeftMenuShown {
      self.dismissLeftMenu()
    }
    else {
      self.showLeftMenu()
    }
  }
}
