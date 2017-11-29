//
//  weatherModel.swift
//  sgweather
//
//  Created by Isa Andi on 28/11/2017.
//  Copyright © 2017 Massive Infinity. All rights reserved.
//

import ObjectMapper

class WeatherResponse: Mappable {
    var city: String?
    var country: String?
    var conditionDate: String?
    var conditionTemp: String?
    var conditionText: String?
    var forecast: [Forecast]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        city <- map["query.results.channel.location.city"]
        country <- map["query.results.channel.location.country"]
        conditionDate <- map["query.results.channel.item.condition.date"]
        conditionTemp <- map["query.results.channel.item.condition.temp"]
        conditionText <- map["query.results.channel.item.condition.text"]
        forecast <- map["query.results.channel.item.forecast"]
    }
}

class Forecast: Mappable {
    var code: String?
    var date: String?
    var low: String?
    var high: String?
    var text: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        date <- map["date"]
        low <- map["low"]
        high <- map["high"]
        text <- map["text"]
    }
}



