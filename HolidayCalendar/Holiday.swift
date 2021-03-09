//
//  Holiday.swift
//  HolidayCalendar
//
//  Created by ilomidze on 04.03.21.
//

import Foundation


struct HolidayResponce:Decodable {
    var responce:Holidays
}

struct Holidays:Decodable {
    var holidays:[HolidayDetail]
}

struct HolidayDetail:Decodable{
    var name:String
    var date:DateInfo
}

struct DateInfo:Decodable {
    var iso:String
    
}
