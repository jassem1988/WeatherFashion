//
//  ChangeCityViewController.swift
//  Weather Fashion
//
//  Created by Jassem Al-Buloushi on 1/30/19.
//  Copyright © 2019 Jassem Al-Buloushi. All rights reserved.
//

import UIKit

//Protocols

protocol ChangeCityDelegate {
    func userEnteredNewCityName(city : String)
}

class ChangeCityViewController: UIViewController {
    
    //Declare Delegate
    
    var delegate : ChangeCityDelegate?
    
    @IBOutlet weak var changeCityTextField: UITextField!
    
    @IBAction func getWeatherPressed(_ sender: Any) {
        
        let cityName = changeCityTextField.text!
        
        delegate?.userEnteredNewCityName(city: cityName)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func backButtinPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
