//
//	flights.swift
//
//	Create by Leo on 2/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class flights : NSObject, NSCoding, Mappable{
    
    var arrivalTime : String?
    var departureTime : String?
    var id : Int?
    var numberOfStops : Int?
    var priceInEuros : String?
    var providerLogo : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return flights(map)
    }
    required init?(_ map: Map){}
    
    func mapping(map: Map)
    {
        arrivalTime <- map["arrival_time"]
        departureTime <- map["departure_time"]
        id <- map["id"]
        numberOfStops <- map["number_of_stops"]
        priceInEuros <- map["price_in_euros"]
        providerLogo <- map["provider_logo"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        arrivalTime = aDecoder.decodeObjectForKey("arrival_time") as? String
        departureTime = aDecoder.decodeObjectForKey("departure_time") as? String
        id = aDecoder.decodeObjectForKey("id") as? Int
        numberOfStops = aDecoder.decodeObjectForKey("number_of_stops") as? Int
        priceInEuros = aDecoder.decodeObjectForKey("price_in_euros") as? String
        providerLogo = aDecoder.decodeObjectForKey("provider_logo") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if arrivalTime != nil{
            aCoder.encodeObject(arrivalTime, forKey: "arrival_time")
        }
        if departureTime != nil{
            aCoder.encodeObject(departureTime, forKey: "departure_time")
        }
        if id != nil{
            aCoder.encodeObject(id, forKey: "id")
        }
        if numberOfStops != nil{
            aCoder.encodeObject(numberOfStops, forKey: "number_of_stops")
        }
        if priceInEuros != nil{
            aCoder.encodeObject(priceInEuros, forKey: "price_in_euros")
        }
        if providerLogo != nil{
            aCoder.encodeObject(providerLogo, forKey: "provider_logo")
        }
        
    }
    
}
