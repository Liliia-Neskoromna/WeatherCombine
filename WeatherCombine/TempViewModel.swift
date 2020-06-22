//
//  TempViewModel.swift
//  WeatherCombine
//
//  Created by Lilia on 6/17/20.
//  Copyright © 2020 Liliia. All rights reserved.
//

import Foundation
import Combine

final class TempViewModel: ObservableObject {
    
    @Published var city: String = "London"
    
    @Published var currentWeather = WeatherDetail.placeholder
    
    init() {
        $city
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { (city:String) -> AnyPublisher<WeatherDetail,Never> in WeatherAPI.shared.fetchWeather(for: city)}
            .assign(to: \.currentWeather, on: self)
            .store(in: &self.cancellableSet)
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
}
