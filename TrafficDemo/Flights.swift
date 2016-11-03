//
//	flights.swift
//
//	Create by Leo on 2/11/2016
//	Copyright © 2016. All rights reserved.

import Foundation
import Mapper


struct Flights : Mappable{
    
    var arrivalTime : String!
    var departureTime : String!
    var id : Int!
    var numberOfStops : Int!
    var priceInEuros : String!
    var providerLogo : String!
    
    
    init(map: Mapper) throws {
        try arrivalTime = map.from("arrival_time")
        try departureTime = map.from("departure_time")
        try id = map.from("id")
        try numberOfStops = map.from("number_of_stops")
        try priceInEuros = map.from("price_in_euros")
        try providerLogo = map.from("provider_logo")
    }
    
}
