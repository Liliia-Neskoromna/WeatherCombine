//
//  WeatherAPI.swift
//  WeatherCombine
//
//  Created by Lilia on 6/16/20.
//  Copyright © 2020 Liliia. All rights reserved.
//

import Foundation
import Combine

class WeatherAPI {
    static let shared = WeatherAPI()
    private let celsiusCharacters = "°C"
    private let baseaseURl = "https://api.openweathermap.org/data/2.5/weather"
    private let apiKey = "35b80fc7e92ced8b98ba88190b7b274b"
    
    private func absoluteURL(city: String) -> URL? {
        let queryURL = URL(string: baseaseURl)!
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else { return nil }
        urlComponents.queryItems = [URLQueryItem(name: "apiid", value: apiKey),
                                    URLQueryItem(name: "q", value: city),
                                    URLQueryItem(name: "units", value: "metric")]
        return urlComponents.url!
    }
    func fetchWeather(for city: String) -> AnyPublisher<WeatherDetail, Never> {
        guard let url = absoluteURL(city: city) else {
            return Just(WeatherDetail.placeholder)
                .eraseToAnyPublisher()
            
        }
        return
            URLSession.shared.dataTaskPublisher(for:url)
            .map { $0.data }
            .decode(type: WeatherDetail.self, decoder: JSONDecoder())
            .catch { error in Just(WeatherDetail.placeholder) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
