//
//  Model.swift
//  WeatherCombine
//
//  Created by Lilia on 6/16/20.
//  Copyright © 2020 Liliia. All rights reserved.
//

import Foundation

struct WeatherDetail: Codable, Identifiable {
    
    let main: Main?
    var id: Int?
    
    static var placeholder: Self {
        return WeatherDetail(main: nil, id: nil)
    }
}

struct Main: Codable {
    let temp: Double?
}
