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
    
    private var locationService = LocationService()
    
    private let cities = CurrentValueSubject<Set<String>, Never>([])
    
    init() {
        cities
            .sink { [weak self] (cities) in
                guard let self = self else { return }
                self.weatherDatas = []
                cities.forEach { (city) in
                    OpenWeatherService.default.getWeather(for: city)
                        .sink { [weak self] (data) in
                            guard let self = self else { return }
                            if let data = data {
                                self.weatherDatas.append(data)
                            }
                        }
                        .store(in: &self.cancellables)
                }
            }
            .store(in: &cancellables)
        
        locationService.cityName
            .sink { [weak self] (city) in
                guard let self = self, let city = city else { return }
                self.addCity(city)
            }
            .store(in: &cancellables)
    }
    
    func addCity(_ city: String) {
        guard !self.cities.value.contains(city) else { return }
        var cities = self.cities.value
        cities.insert(city)
        self.cities.send(cities)
    }
}
