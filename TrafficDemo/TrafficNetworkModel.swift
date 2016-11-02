//
//  TrafficNetworkModel.swift
//  TrafficDemo
//
//  Created by Leo on 2016/11/2.
//  Copyright © 2016年 Leo. All rights reserved.
//

import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import RxOptional
import RxSwift


class TrafficNetworkModel {
    
    let provider: RxMoyaProvider<Traffic>
    var flightElements = Variable<[Flights]>([])
    let loading = Variable<Bool>(false)

    private let disposeBag = DisposeBag()

    init(provider:RxMoyaProvider<Traffic>) {
        self.provider = provider
     
        let refreshRequest = loading.asObservable()
            .flatMap { loading -> Observable<[Flights]> in
                if loading {
                    return Observable.empty()
                } else {
                    return self.fetchFlights().filterNil()
                }
        }
      
        let request = Observable
            .of(refreshRequest)
            .shareReplay(1)

        Observable
            .of(request.map { _ in false })
            .merge()
            .bindTo(loading)
            .addDisposableTo(disposeBag)

        request.subscribeNext { (flights) in
            flights.subscribeNext({ (flights) in
                self.flightElements = Variable.init(flights)
            }).dispose()
        }.addDisposableTo(disposeBag)
        
        
    
    }
    
    
    func fetchFlights() -> Observable<[Flights]?> {
       return self.provider
        .request(Traffic.FetchFlights())
        .debug()
        .mapArrayOptional(Flights.self, keyPath: "items")
    }
}
