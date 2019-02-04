//
//  ViewController.swift
//  Weather Fashion
//
//  Created by Jassem Al-Buloushi on 1/11/19.
//  Copyright © 2019 Jassem Al-Buloushi. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewConroller: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "052c90e1a6caa1fba4d3f65a04fe4df7"
    /***Get your own App ID at https://openweathermap.org/appid ****/
    
    //Declare instance variables
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    
    //IBOutlets
    
    @IBOutlet weak var weatherIcon1: UIImageView!
    @IBOutlet weak var clothingIcon: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up the location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    //MARK: - Networking
    
    func getWeatherData(url: String, parameters: [String:String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success! Got the weather Data")
                
                //Create JSON Object
                let weatherJSON : JSON = JSON(response.result.value!)
                
                self.updateWeatherData(json: weatherJSON)
                
            } else {
                print("Error \(response.result.error!)")
                self.cityNameLabel.text = "Connection Issues"
            }
        }
    }
    
    
    //MARK: - JSON Parsing
    
    func updateWeatherData(json : JSON) {
        
        //Optional binding
        
        if let tempResult = json["main"]["temp"].double {
        
        weatherDataModel.temperature = Int(tempResult - 273.15)
        weatherDataModel.city = json["name"].stringValue
        weatherDataModel.condition = json["weather"][0]["id"].intValue
        
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherConditionToWeatherIcon(condition: weatherDataModel.condition)
        
        weatherDataModel.clothingIconName = weatherDataModel.updateWeatherConditionToClothingIcon(condition: weatherDataModel.condition, temp: weatherDataModel.temperature)
        } else {
            cityNameLabel.text = "Weather Unavailable"
        }
        
        //Update UI
        updateWeatherUI()
    }
    
    //MARK: - UI Update
    
    func updateWeatherUI() {
        cityNameLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temperature)°"
        weatherIcon1.image = UIImage(named: weatherDataModel.weatherIconName)
        clothingIcon.image = UIImage(named: weatherDataModel.clothingIconName)
    }
    
    
    //MARK: - Location Manager Delegate Methods:-
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //The most accurate location
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            //To stop draining the battery
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            print("Longitude: \(location.coordinate.longitude), Latitude: \(location.coordinate.latitude)")
            
            //Create lon and lat veriables
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            //Create a params dictionary
            let params: [String:String] = ["lat":latitude, "lon":longitude, "appid":APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityNameLabel.text = "Location Unavailable"
    }
    
    //MARK : - Change City Delegate methods
    
    func userEnteredNewCityName(city: String) {
        
        let params : [String : String] = ["q" : city, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "changeCityName") {
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
        
    }


}

