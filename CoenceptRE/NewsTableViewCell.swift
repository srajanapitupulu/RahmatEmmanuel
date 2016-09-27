//
//  NewsTableViewCell.swift
//  CoenceptRE
//
//  Created by Reebonz on 9/16/16.
//  Copyright © 2016 srajanapitupulu. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
  
  @IBOutlet weak var lblTitle:UILabel!
  @IBOutlet weak var lblDescription:UILabel!
  
  @IBOutlet weak var imgBackground:UIImageView!
  
  @IBOutlet weak var imgPlay:UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    
    self.lblTitle.font = UIFont(name: "ProximaNova-Bold", size: 16)
    self.lblDescription.font = UIFont(name: "ProximaNova-Regular", size: 14)
  }
  
  func setContentDataForNews(withData newsData:News) {
    self.imgPlay.hidden = true
    self.lblTitle.text = newsData.title
    self.lblDescription.text = "by : \(newsData.author)"
    self.tag = Int(newsData.Id)!
  }
  
  func setContentDataForVideo(withData videoData:Video) {
    self.imgPlay.hidden = false
    self.lblTitle.text = videoData.title
    self.lblDescription.text = "by : \(videoData.author)"
    self.tag = Int(videoData.Id)!
  }
  
  func setCellBackgroundImage(withImageFromURL url:String){
    if let url = NSURL(string: url) {
      if let data = NSData(contentsOfURL: url) {
        self.imgBackground.image = UIImage(data: data)
      }
    }
  }
}
