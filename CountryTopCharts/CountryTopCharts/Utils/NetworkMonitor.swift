//
//  NetworkMonitor.swift
//  CountryTopCharts
//
//  Created by Tobias Classon on 2020-12-11.
//  Copyright © 2020 Tobias Classon. All rights reserved.
//

import Foundation
import Network

class NetworkMonitor {
    let monitor = NWPathMonitor()
    
    func checkConnectivity () {
        
        monitor.pathUpdateHandler = { path in
        if path.status == .satisfied {
           print("We're connected!")
         } else {
           print("No connection.")
         }
           print(path.isExpensive, "running on cellular or hotspot")
            
         }
        
        let queue = DispatchQueue(label: "Monitor")
        
        monitor.start(queue: queue)
        
    }
    
    
}
