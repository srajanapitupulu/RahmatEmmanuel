//
//  ScheduleService.swift
//  CoenceptRE
//
//  Created by Reebonz on 9/9/16.
//  Copyright © 2016 srajanapitupulu. All rights reserved.
//

import Foundation

protocol DelegateScheduleService: NSObjectProtocol {
  func scheduleResponse(scheduleData data:[Schedule])
}

class ScheduleService: NSObject {
  
  var service: Service!
  var delScheduleService: AnyObject!
  
  //MARK: Initialization
  init(delScheduleService: DelegateScheduleService) {
    self.delScheduleService = delScheduleService
    
    super.init()
    
    self.service = Service(delService: self)
  }
  
  func getScheduleData() {
    self.service.callGETRestAPI(withURL: Constants.API_SCHEDULE)
  }
}

extension ScheduleService:DelegateServiceCall {
  func onCallSuccess(withJSON jsonResponse: [String : AnyObject]) {
    var jsonData: [Schedule] = [Schedule]()
    
    let sched1 = Schedule()
    sched1.locationName     = "HOTEL CIPUTRA JAKARTA"
    sched1.locationDetail   = "PURI ROOM 5 & 6"
    sched1.locationAddress  = "Jl. Letnan Jenderal S. Parman"
    sched1.mainSchedule     = "8AM, 10AM, 1PM, 3PM, 5PM, 7PM"
    sched1.kidsSchedule     = "8AM & 10AM"
    jsonData.append(sched1)
    
    let sched2 = Schedule()
    sched2.locationName     = "HOTEL LUMIRE JAKARTA"
    sched2.locationDetail   = " "
    sched2.locationAddress  = "Jalan Senen Raya Blok A No. 135"
    sched2.mainSchedule     = "10AM"
    sched2.kidsSchedule     = "10AM"
    jsonData.append(sched2)
    
    
    (self.delScheduleService as! DelegateScheduleService).scheduleResponse(scheduleData: jsonData)
  }
  
  func onCallFailed(withErrorMessage error: String) {
    var jsonData: [Schedule] = [Schedule]()
    
    let sched1 = Schedule()
    sched1.locationName     = "HOTEL CIPUTRA JAKARTA"
    sched1.locationDetail   = "PURI ROOM 5 & 6"
    sched1.locationAddress  = "Jl. Letnan Jenderal S. Parman"
    sched1.mainSchedule     = "8AM, 10AM, 1PM, 3PM, 5PM, 7PM"
    sched1.kidsSchedule     = "8AM & 10AM"
    jsonData.append(sched1)
    
    let sched2 = Schedule()
    sched2.locationName     = "HOTEL LUMIRE JAKARTA"
    sched2.locationDetail   = " "
    sched2.locationAddress  = "Jalan Senen Raya Blok A No. 135"
    sched2.mainSchedule     = "10AM"
    sched2.kidsSchedule     = "10AM"
    jsonData.append(sched2)
    
    
    (self.delScheduleService as! DelegateScheduleService).scheduleResponse(scheduleData: jsonData)
  }
}
