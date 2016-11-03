//
//  TrafficAPI.swift
//  TrafficDemo
//
//  Created by Leo on 2016/11/2.
//  Copyright © 2016年 Leo. All rights reserved.
//

import Foundation
import Moya


private func JSONResponseDataFormatter(data: NSData) -> NSData {
    do {
        let dataAsJSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        let prettyData =  try NSJSONSerialization.dataWithJSONObject(dataAsJSON, options: .PrettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}

let requestClosure = { (endpoint: Endpoint<Traffic>, done: MoyaProvider.RequestResultClosure) in
    let request = endpoint.urlRequest.mutableCopy() as! NSMutableURLRequest
    done(.Success(request))
}

let endpointClosure = { (target:Traffic) -> Endpoint<Traffic> in
    let url = target.baseURL.URLByAppendingPathComponent(target.path)!.absoluteString
    var httpHeaderFields:[String: String]? = nil
    
    /*
    switch target {
    
    case .FetchFlights(): break
    
    default:
    
    }
    */
    
    return Endpoint(URL: url!, sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters, parameterEncoding:.JSON, httpHeaderFields: httpHeaderFields)
}


let trafficProvider = MoyaProvider<Traffic>(
    plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)],
    requestClosure:requestClosure,
    endpointClosure:endpointClosure
)




private extension String {
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
}

enum Traffic {
    case FetchFlights()
    case FetchTrains()
    case FetchBuses()
}

extension Traffic: TargetType {
    var baseURL: NSURL { return NSURL(string: "https://api.myjson.com")! }
    var path: String {
        switch self {
        case .FetchFlights:
            return "/bins/w60i"
        case .FetchTrains:
            return "/bins/3zmcy"
        case .FetchBuses:
            return "/bins/37yzm"
        }
    }
    
    var method: Moya.Method {
        return .GET
    }
    
    var parameters: [String: AnyObject]? {
        return nil
    }
    
    var multipartBody: [MultipartFormData]? {
        return nil
    }

    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return method == .GET ? .URL : .JSON
        }
    }
    
    var sampleData: NSData {
        return "".dataUsingEncoding(NSUTF8StringEncoding)!
    }
    
    
    
}
