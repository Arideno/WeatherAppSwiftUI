//
//  OpenWeatherService.swift
//  WeatherApp
//
//  Created by Andrii Moisol on 29.03.2021.
//

import Foundation
import Combine

final class OpenWeatherService {
    static let `default` = OpenWeatherService()

    private let APP_ID = "869d72df479aa9fe9cbf1d1fba50cf48"
    
    func getWeather(for city: String) -> AnyPublisher<WeatherData?, Never> {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=\(APP_ID)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return AnyPublisher(Empty<WeatherData?, Never>()) }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else { throw URLError(.badServerResponse) }
                
                return data
            }
            .decode(type: WeatherData?.self, decoder: JSONDecoder())
            .replaceError(with: nil)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            
    }
}
