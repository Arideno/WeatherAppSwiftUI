//
//  MainView.swift
//  WeatherApp
//
//  Created by Andrii Moisol on 29.03.2021.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.weatherDatas) { weatherData in
                Text(weatherData.weather?.first?.main ?? "")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
