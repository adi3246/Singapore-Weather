//
//  WeatherService.swift
//  sgweather
//
//  Created by Isa Andi on 30/11/2017.
//  Copyright © 2017 Massive Infinity. All rights reserved.
//

import UIKit
import Firebase
import AlamofireObjectMapper
import Alamofire

protocol WeatherServiceDelegate{
    func requestSucceed(response: WeatherResponse)
    func requestFailed(error: String)
}

class WeatherService{
    
    var delegate:WeatherServiceDelegate? = nil

    func getTodayWeather() {
        
        let URL = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22singapore%2C%20sg%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
        Alamofire.request(URL).responseObject { (response: DataResponse<WeatherResponse>) in
            switch response.result {
            case .success:
                self.delegate!.requestSucceed(response: response.result.value!)
            case .failure(let error):
                self.delegate!.requestFailed(error: error as! String)
            }
        }
    }
}
