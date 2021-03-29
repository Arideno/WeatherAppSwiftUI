//
//  MainView.swift
//  WeatherApp
//
//  Created by Andrii Moisol on 29.03.2021.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    
    @State private var presentAlert = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.weatherDatas) { weatherData in
                    WeatherView(weatherViewModel: WeatherViewModel(weatherData: weatherData))
                }
            }
            .navigationTitle("Weather")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                addCityButton
            })
        }
        .alert(isPresented: $presentAlert, TextAlert(title: "Add new city", message: nil, action: { (result) in
            if let city = result {
                viewModel.addCity(city)
            }
        }))
    }
    
    var addCityButton: some View {
        Button(action: {
            presentAlert.toggle()
        }, label: {
            Image(systemName: "plus")
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
