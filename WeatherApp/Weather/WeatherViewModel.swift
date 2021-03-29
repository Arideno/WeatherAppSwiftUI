//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Andrii Moisol on 29.03.2021.
//

import Foundation
import Foundation

enum Direction: String, CaseIterable {
    case n, nne, ne, ene, e, ese, se, sse, s, ssw, sw, wsw, w, wnw, nw, nnw
}

extension Direction: CustomStringConvertible  {
    init<D: BinaryFloatingPoint>(_ direction: D) {
        self = Self.allCases[Int((direction.angle+11.25).truncatingRemainder(dividingBy: 360)/22.5)]
    }
    var description: String { rawValue.uppercased() }
}

extension BinaryFloatingPoint {
    var angle: Self {
        (truncatingRemainder(dividingBy: 360) + 360)
            .truncatingRemainder(dividingBy: 360)
    }
    var direction: Direction { .init(self) }
}

class WeatherViewModel: ObservableObject {
    @Published var cityName: String
    @Published var temperature: String
    @Published var minTemperature: String
    @Published var maxTemperature: String
    @Published var windSpeed: String
    @Published var windDirection: String
    @Published var state: String
    
    let numberFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.decimalSeparator = "."
        f.minimumFractionDigits = 2
        f.maximumFractionDigits = 2
        return f
    }()
    
    init(weatherData: WeatherData) {
        cityName = weatherData.name
        temperature = (numberFormatter.string(from: NSNumber(value: weatherData.main.temp)) ?? "0") + "°"
        minTemperature = (numberFormatter.string(from: NSNumber(value: weatherData.main.tempMin)) ?? "0") + "°"
        maxTemperature = (numberFormatter.string(from: NSNumber(value: weatherData.main.tempMax)) ?? "0") + "°"
        windSpeed = (numberFormatter.string(from: NSNumber(value: weatherData.wind.speed)) ?? "0") + "km/h"
        windDirection = weatherData.wind.speed.direction.description
        state = weatherData.weather.first!.main
    }
}
