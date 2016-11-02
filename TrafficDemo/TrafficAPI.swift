//
//  TrafficAPI.swift
//  TrafficDemo
//
//  Created by Leo on 2016/11/2.
//  Copyright © 2016年 Leo. All rights reserved.
//

import Foundation
import Moya


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
