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
        try arrivalTime = map.from("arrivalTime")
        try departureTime = map.from("departureTime")
        try id = map.from("id")
        try numberOfStops = map.from("numberOfStops")
        try priceInEuros = map.from("priceInEuros")
        try providerLogo = map.from("providerLogo")
    }
    
}
