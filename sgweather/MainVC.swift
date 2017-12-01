//
//  MainVC.swift
//  sgweather
//
//  Created by Isa Andi on 27/11/2017.
//  Copyright © 2017 Massive Infinity. All rights reserved.
//

import UIKit
import Firebase
import AlamofireObjectMapper
import Alamofire
import SwiftOverlays
import RealmSwift

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, WeatherServiceDelegate{
    @IBOutlet weak var lblConditionDate: UILabel!
    @IBOutlet weak var lblConditionTemp: UILabel!
    @IBOutlet weak var lblConditionText: UILabel!
    @IBOutlet weak var weatherTableView: UITableView!
    
    var wholeWeekForecastArray = [Forecast]()

    
    let realm = try! Realm()
    lazy var weatherObj: Results<WeatherObj> = { self.realm.objects(WeatherObj.self) }()
    lazy var forecastObj: Results<ForecastObj> = { self.realm.objects(ForecastObj.self) }()

    
    
    @IBAction func LogoutTapped(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.presentLoginScreen()
        }catch{
            
        }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 237.0/255.0, green: 41.0/255.0, blue: 57.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        

        
        if(Auth.auth().currentUser == nil){
           self.presentLoginScreen()
        }else{
            self.showWaitOverlay()
            
            let weatherService = WeatherService()
            weatherService.delegate=self
            weatherService.getTodayWeather()
            
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentLoginScreen(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(loginVC, animated:true, completion:nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastObj.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainTableViewCell
        
        let image = UIImage(named: "arrow.png")
        let checkmark  = UIImageView(frame:CGRect(x:0, y:0, width:(image?.size.width)!, height:(image?.size.height)!));
        checkmark.image = image
        cell?.accessoryView = checkmark
        
        let forecastDate = forecastObj[indexPath.row].date
        let forecastLow = forecastObj[indexPath.row].low
        let forecastHigh = forecastObj[indexPath.row].high
        let forecastText = forecastObj[indexPath.row].text
        
        cell?.lblForecastDate.text = forecastDate
        cell?.lblForecastTemp.text = (forecastLow)!+" - "+(forecastHigh)!
        cell?.lblForecastText.text = forecastText
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80.0;//Choose your custom row height
    }
    
    
    func requestSucceed(response: WeatherResponse) {
        self.removeAllOverlays()
        self.navigationController?.navigationBar.topItem?.title = (response.country)!+", "+(response.city)!
        
        self.lblConditionDate.text = response.conditionDate
        self.lblConditionTemp.text = response.conditionTemp
        self.lblConditionText.text = response.conditionText
        
        self.wholeWeekForecastArray = (response.forecast)!
        //self.weatherTableView.reloadData()
        
        if self.weatherObj.count == 0 {
            if let weekForecast = response.forecast {
                for forecast in weekForecast {
                    try! self.realm.write() {
                        
                        let newForecastObj = ForecastObj()
                        newForecastObj.id = String(arc4random())
                        newForecastObj.date = forecast.date
                        newForecastObj.text = forecast.text
                        newForecastObj.high = forecast.high
                        newForecastObj.low = forecast.low
                        self.realm.add(newForecastObj)
                    }
                    self.forecastObj = self.realm.objects(ForecastObj.self)
                }
            }
        }
        
        
        print("hahaha")
        print(self.forecastObj.count)
        
        if self.weatherObj.count == 0 {
            try! self.realm.write() {
                
                let newWeatherObj = WeatherObj()
                newWeatherObj.country = response.country
                newWeatherObj.city = response.city
                newWeatherObj.conditionDate = response.conditionDate
                newWeatherObj.conditionTemp = response.conditionTemp
                newWeatherObj.conditionText = response.conditionText
                self.realm.add(newWeatherObj)
            }
            self.weatherObj = self.realm.objects(WeatherObj.self)
        }
        
        self.weatherTableView.reloadData()
    }
    
    func requestFailed(error: String) {
        self.removeAllOverlays()
        print(error)
    }
    
}
