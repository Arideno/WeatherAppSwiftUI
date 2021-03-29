//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Andrii Moisol on 29.03.2021.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("\(weatherViewModel.cityName)")
                    .font(.headline)
                Text("\(weatherViewModel.temperature)")
                    .font(.subheadline)
                Text("Min: \(weatherViewModel.minTemperature)")
                    .font(.footnote)
                Text("Max: \(weatherViewModel.maxTemperature)")
                    .font(.footnote)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("Wind: \(weatherViewModel.windSpeed) \(weatherViewModel.windDirection)")
                    .font(.subheadline)
                
                Text("Overall state: \(weatherViewModel.state)")
                    .font(.subheadline)
                
                Spacer()
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weatherViewModel: WeatherViewModel(weatherData: WeatherData(id: 1, main: WeatherData.Main(temp: 1, feelsLike: 1, tempMin: 1, tempMax: 1), weather: [WeatherData.Weather(main: "TEST", description: "TEST")], wind: WeatherData.Wind(speed: 2, deg: 2), name: "Kyiv")))
    }
}
