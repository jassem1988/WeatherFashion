//
//  WeatherDataModel.swift
//  Weather Fashion
//
//  Created by Jassem Al-Buloushi on 1/13/19.
//  Copyright © 2019 Jassem Al-Buloushi. All rights reserved.
//

import UIKit

class WeatherDataModel {
    
    //Weather model veriables

    var temperature : Int = 0
    var condition : Int = 0
    var city : String = ""
    var weatherIconName : String = ""
    var clothingIconName : String = ""
    
    //method turn condition code to weather icon
    
    func updateWeatherConditionToWeatherIcon(condition: Int) -> String {
        switch(condition) {
            case 0...300 :
                return "009-storm-1"
            
            case 301...500 :
                return "003-rainy"
            
            case 501...600 :
                return "004-rainy-1"
            
            case 601...700 :
                return "006-snowy"
            
            case 701...771 :
                return "017-foog"
            
            case 772...799 :
                return "008-storm"
            
            case 800 :
                return "039-sun"
            
            case 801...804 :
                return "001-cloud"
            
            case 900...903, 905...1000  :
                return "036-storm-4"
            
            case 903 :
                return "006-snowy"
            
            case 904 :
                return "039-sun"
            
            default :
                return "dunno"
            }
    }
    
    func updateWeatherConditionToClothingIcon(condition: Int, temp: Int) -> String {
        if (condition >= 301 && condition <= 600) {
            return "023-raincoat"
        } else {
            switch(temp) {
            case -15 ... -1 :
                return "050-coat"
                
            case 0...9 :
                return "010-sweater"
                
            case 10...15 :
                return "001-hoodie"
                
            case 16...20 :
                return "019-shirt"
                
            case 21...30 :
                return "028-shirt-1"
                
            case 31...40 :
                return "018-flip-flops"
                
            case 41...60 :
                return "002-tank-top"
            default :
                return "dunno"
            }
        }
        
//        switch(condition) {
//        case 0...300 :
//            return "010-sweater"
//
//        case 301...600 :
//            return "023-raincoat"
//
//        case 601...700 :
//            return "050-coat"
//
//        case 701...771 :
//            return "019-shirt"
//
//        case 772...799 :
//            return "001-hoodie"
//
//        case 800 :
//            return "002-tank-top"
//
//        case 801...804 :
//            return "028-shirt-1"
//
//        case 900...903, 905...1000  :
//            return "001-hoodie"
//
//        case 903 :
//            return "031-hat"
//
//        case 904 :
//            return "018-flip-flops"
//
//        default :
//            return "dunno"
//        }
    }
}
    

