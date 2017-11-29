//
//  WeatherEntity.swift
//  sgweather
//
//  Created by Isa Andi on 28/11/2017.
//  Copyright © 2017 Massive Infinity. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherObj: Object {
    @objc dynamic var id : String?
    @objc dynamic var city : String?
    @objc dynamic var country : String?
    @objc dynamic var conditionDate : String?
    @objc dynamic var conditionTemp : String?
    @objc dynamic var conditionText : String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class ForecastObj: Object {
    @objc dynamic var id : String?
    @objc dynamic var date : String?
    @objc dynamic var low : String?
    @objc dynamic var high : String?
    @objc dynamic var text : String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
