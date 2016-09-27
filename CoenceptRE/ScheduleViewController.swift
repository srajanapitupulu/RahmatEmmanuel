//
//  ScheduleViewController.swift
//  CoenceptRE
//
//  Created by Reebonz on 9/8/16.
//  Copyright © 2016 srajanapitupulu. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
  
  @IBOutlet weak var vwHeader:HeaderView!
  @IBOutlet weak var vwMain:UIView!
  
  @IBOutlet weak var tblSchedule:UITableView!
  @IBOutlet weak var loadingView:UIActivityIndicatorView!
  @IBOutlet weak var consVwMainLeading: NSLayoutConstraint!
  
  var sbMain:UIStoryboard!
  var leftMenuView = LeftMenuViewController()
  
  var scheduleService: ScheduleService!
  
  var arrSchedule:[Schedule] = [Schedule]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.sbMain = UIStoryboard.init(name: "Main", bundle: nil)
    
    self.vwHeader.delHeaderView = self
    self.leftMenuView.delLeftMenu = self
    
    self.vwHeader.lblTitle.text = "Schedule"
    
    self.addChildViewController(leftMenuView)
    
    var menuFrame = self.leftMenuView.view.frame
    
    menuFrame.origin.x = 0 - menuFrame.size.width
    menuFrame.origin.y = 0
    menuFrame.size.height = self.view.frame.size.height
    
    self.leftMenuView.view.frame = menuFrame
    
    self.view.addSubview(leftMenuView.view)
    self.view.sendSubviewToBack(leftMenuView.view)
    self.leftMenuView.didMoveToParentViewController(self)
    
    let nibScheduleViewCell = UINib(nibName: String(ScheduleTableViewCell.classForCoder()), bundle: nil)
    self.tblSchedule.registerNib(nibScheduleViewCell, forCellReuseIdentifier: String(ScheduleTableViewCell.classForCoder()))
    self.tblSchedule.separatorStyle = .None
    
    self.scheduleService = ScheduleService(delScheduleService: self)
    self.scheduleService.getScheduleData()
    
    self.loadingView.hidden = false
    self.loadingView.startAnimating()
    self.tblSchedule.hidden = true
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

extension ScheduleViewController:DelegateScheduleService {
  func scheduleResponse(scheduleData data:[Schedule]) {
    self.arrSchedule = data
    self.tblSchedule.reloadData()
    
    self.loadingView.hidden = true
    self.loadingView.startAnimating()
    self.tblSchedule.hidden = false
  }
}

extension ScheduleViewController:UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {}
}

extension ScheduleViewController:UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.arrSchedule.count
  }
  
//  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//    return 300.0
//  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 300.0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let viewCell = tableView.dequeueReusableCellWithIdentifier(String(ScheduleTableViewCell.classForCoder()), forIndexPath: indexPath) as! ScheduleTableViewCell
    
    let scheduleData = self.arrSchedule[indexPath.row]
    
    viewCell.lblTitle.text        = scheduleData.locationName
    viewCell.lblRoom.text         = scheduleData.locationDetail
    viewCell.lblAddress.text      = scheduleData.locationAddress
    viewCell.lblMainSchedule.text = scheduleData.mainSchedule
    
    if let kidsSchedule = scheduleData.kidsSchedule {
      viewCell.lblKidsSchedule.text = "RE Kids Church [ \(kidsSchedule) ]"
    }
    
    return viewCell
  }
}

extension ScheduleViewController:DelegateLeftMenu {
  func doGoToHome(){
    self.dismissLeftMenu()
    var homeVC = ViewController()
    homeVC = sbMain.instantiateViewControllerWithIdentifier("MainViewController") as! ViewController
    self.presentViewController(homeVC, animated: true, completion: nil)
  }
  
  func doGoToSchedule(){
    self.dismissLeftMenu()
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

extension ScheduleViewController:DelegateHeaderView {
  func doOpenLeftMenu() {
    if self.leftMenuView.isLeftMenuShown {
      self.dismissLeftMenu()
    }
    else {
      self.showLeftMenu()
    }
  }
}
