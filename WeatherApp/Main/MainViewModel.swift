//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Andrii Moisol on 29.03.2021.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var weatherDatas = [WeatherData]()
    
    let cities = ["Kyiv", "London", "Los Angeles"]
    
    init() {
        cities.forEach { (city) in
            OpenWeatherService.default.getWeather(for: city)
                .sink { [weak self] (data) in
                    guard let self = self else { return }
                    if let data = data {
                        self.weatherDatas.append(data)
                    }
                }
                .store(in: &cancellables)
        }
    }
}
