//
//  CityInfo.swift
//  WorldWeather
//
//  Created by Anjali Chitkara on 10/29/21.
//

import Foundation

import RealmSwift

class CityInfo : Object {
    @objc dynamic var key: String  = ""
    @objc dynamic var type : String = ""
    @objc dynamic  var localizedName : String = ""
    @objc dynamic var countryLocalizedName : String = ""
    @objc dynamic var administrativeID : String = ""

    
    override static func primaryKey() -> String? {
        return "key"
    }
    
}
