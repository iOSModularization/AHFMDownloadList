//
//  ViewController.swift
//  AHFMDownloadList
//
//  Created by ivsall2012 on 08/03/2017.
//  Copyright (c) 2017 ivsall2012. All rights reserved.
//

import UIKit
import AHServiceRouter
import AHFMDownloaderManager
import AHFMDownloadListManager
import AHFMDownloadListServices
import AHFMNetworking
import AHFMDataTransformers
import SwiftyJSON

class ViewController: UIViewController {
    lazy var networking = AHFMNetworking()
    override func viewDidLoad() {
        super.viewDidLoad()
        AHFMDownloaderManager.activate()
        AHFMDownloadListManager.activate()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        networking.showsByCategory("news") { (data, _) in
            if let data = data, let jsonShows = JSON(data)["results"].array {
                let shows = AHFMShowTransform.transformJsonShows(jsonShows)
                if shows.count > 0{
                    let show = shows.first!
                    let id = show["id"] as! Int
                    let dict = [AHFMDownloadListService.keyShowId: id]
                    AHServiceRouter.navigateVC(AHFMDownloadListService.service, taskName: AHFMDownloadListService.taskNavigation, userInfo: dict, type: .push(navVC: self.navigationController!), completion: nil)
                }
                
            }
        }
        
    }
    

}

