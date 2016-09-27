//
//  JoinViewController.swift
//  CoenceptRE
//
//  Created by Reebonz on 9/8/16.
//  Copyright © 2016 srajanapitupulu. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController {
  
  @IBOutlet weak var vwHeader:HeaderView!
  @IBOutlet weak var vwMain:UIView!
  
  @IBOutlet weak var loadingView:UIActivityIndicatorView!
  @IBOutlet weak var webVwJoin:UIWebView!

  @IBOutlet weak var consVwMainLeading: NSLayoutConstraint!
  
  var sbMain:UIStoryboard!
  
  var leftMenuView = LeftMenuViewController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.sbMain = UIStoryboard.init(name: "Main", bundle: nil)
    
    self.vwHeader.delHeaderView = self
    self.leftMenuView.delLeftMenu = self
    
    self.addChildViewController(leftMenuView)
    
    var menuFrame = self.leftMenuView.view.frame
    
    menuFrame.origin.x = 0 - menuFrame.size.width
    menuFrame.origin.y = 0
    menuFrame.size.height = self.view.frame.size.height
    
    self.leftMenuView.view.frame = menuFrame
    
    self.view.addSubview(leftMenuView.view)
    self.view.sendSubviewToBack(leftMenuView.view)
    self.leftMenuView.didMoveToParentViewController(self)
    
    let url = NSURL (string: "http://rahmatemmanuel.com/next-step-webview/")
    let requestObj = NSURLRequest(URL: url!);
    self.webVwJoin.loadRequest(requestObj)
    
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


extension JoinViewController:UIWebViewDelegate {
  func webViewDidFinishLoad(webView: UIWebView) {
    self.loadingView.stopAnimating()
    self.loadingView.hidden = true
  }
}


extension JoinViewController:DelegateLeftMenu {
  func doGoToHome(){
    self.dismissLeftMenu()
    var homeVC = ViewController()
    homeVC = sbMain.instantiateViewControllerWithIdentifier("MainViewController") as! ViewController
    self.presentViewController(homeVC, animated: true, completion: nil)
  }
  
  func doGoToAbout(){
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToSchedule(){
    self.dismissLeftMenu()
    var scheduleVC = ScheduleViewController()
    scheduleVC = sbMain.instantiateViewControllerWithIdentifier("ScheduleViewController") as! ScheduleViewController
    self.presentViewController(scheduleVC, animated: true, completion: nil)
  }
  
  func doGoToNews(){
    self.dismissLeftMenu()
    var newsVC = NewsViewController()
    newsVC = sbMain.instantiateViewControllerWithIdentifier("NewsViewController") as! NewsViewController
    self.presentViewController(newsVC, animated: true, completion: nil)
  }
  
  func doGoToVideo(){
    self.dismissLeftMenu()
    var videoVC = VideosViewController()
    videoVC = sbMain.instantiateViewControllerWithIdentifier("VideosViewController") as! VideosViewController
    self.presentViewController(videoVC, animated: true, completion: nil)
  }
  
  func doGoToCorner(){
    self.dismissLeftMenu()
    var cornerVC = PSCornerViewController()
    cornerVC = sbMain.instantiateViewControllerWithIdentifier("PSCornerViewController") as! PSCornerViewController
    self.presentViewController(cornerVC, animated: true, completion: nil)
  }
  
  func doGoToJoin() {
    self.dismissLeftMenu()
  }
  
  func doGoToGive() {
    self.dismissLeftMenu()
    var giveVC = GiveViewController()
    giveVC = sbMain.instantiateViewControllerWithIdentifier("GiveViewController") as! GiveViewController
    self.presentViewController(giveVC, animated: true, completion: nil)
  }
  
  func doGoToPassion() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = 6
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToPassionLocation() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = 7
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToVisionPartners() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = 9
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToInsideOut() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = 10
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToBaptism() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = 11
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToRebic() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = 12
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToVolunteers() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = 13
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
}

extension JoinViewController:DelegateHeaderView {
  func doOpenLeftMenu() {
    if self.leftMenuView.isLeftMenuShown {
      self.dismissLeftMenu()
    }
    else {
      self.showLeftMenu()
    }
  }
}
