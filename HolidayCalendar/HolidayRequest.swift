//
//  HolidayRequest.swift
//  HolidayCalendar
//
//  Created by ilomidze on 04.03.21.
//

import Foundation

enum HolidayError:Error{
    case noDataAvailable
    case cantProcessData
}

struct HolidayRequest {
    let resourceURL:URL
    let apiKEY = "2d6c56316787857b49effdade6b1592d18938f7e"

    
    init(countryCode:String){

        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        
        let currentYear = format.string(from: date)
        
        
        let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(apiKEY)&country=\(countryCode)&year=\(currentYear)"
    
    
        guard let resourceURL = URL(string: resourceString) else {
            fatalError()
        }
        self.resourceURL = resourceURL
    }
    
    func getHolidays(completiton: @escaping(Result<[HolidayDetail], HolidayError>)->Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL){data,_,_ in
            guard let jsonData = data else{
                completiton(.failure(.noDataAvailable))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let holidayResponce = try decoder.decode(HolidayResponce.self, from: jsonData)
                let holidayDetails = holidayResponce.responce.holidays
                completiton(.success(holidayDetails))
            } catch{
                completiton(.failure(.cantProcessData))
            }
            
        }
        dataTask.resume()
    }
    
}
