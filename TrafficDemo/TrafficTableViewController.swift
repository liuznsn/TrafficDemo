//
//  TrafficTableViewController.swift
//  TrafficDemo
//
//  Created by LeoLiu on 2016/11/2.
//  Copyright © 2016年 Leo. All rights reserved.
//

import Moya
import Moya_ModelMapper
import UIKit
import RxCocoa
import RxSwift

class TrafficTableViewController: UIViewController {
    
    var tableView: UITableView!
    var searchBar:UISearchBar!
    
    let disposeBag = DisposeBag()
    var provider: RxMoyaProvider<Traffic>!
    var trafficNetworkModel:TrafficNetworkModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Traffic"
        tableView = UITableView(frame: UIScreen.mainScreen().bounds)
        self.view = tableView
        setupRx()
    }
    
    func setupRx() {
        self.navigationController?.navigationBar.translucent = false
        self.edgesForExtendedLayout = .None
        
        provider = RxMoyaProvider<Traffic>()
        trafficNetworkModel = TrafficNetworkModel(provider: provider)
        
        
        trafficNetworkModel.flightElements.asDriver()
            .drive(tableView.rx_itemsWithCellFactory) { (tableView, row, item) in
                let cell = UITableViewCell(style: .Default, reuseIdentifier: "trafficCell")
                cell.textLabel?.text = item.arrivalTime
                return cell
            }.addDisposableTo(disposeBag)
        rx_sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .map { _ in () }
            .bindTo(trafficNetworkModel.refreshTrigger)
            .addDisposableTo(disposeBag)
        
        
        tableView.rx_reachedBottom
            .bindTo(trafficNetworkModel.loadNextPageTrigger)
            .addDisposableTo(disposeBag)
    
        
    }
 
}
