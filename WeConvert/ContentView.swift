//
//  ContentView.swift
//  WeConvert
//
//  Created by Toni Mijatovic on 01/05/2023.
//

import SwiftUI

struct ContentView: View {
    var temperatures = ["Celcius", "Farenheit", "Kelvin"]
    
    @State private var inputTemperatureUnit = "Celcius"
    @State private var outputTemperatureUnit = "Farenheit"
    @State private var inputTemperature = 20.0
    @FocusState private var inputIsFocused: Bool
    
    var convertedTemperature: Double {
        var temperatureInCelsius = 0.0
        var outputTemperature = 0.0
        //First we calculate to Celcius from all possible inputs
        if(inputTemperatureUnit == "Farenheit") {
            temperatureInCelsius = (inputTemperature  - 32) * 5/9
        } else if(inputTemperatureUnit == "Kelvin") {
            temperatureInCelsius = inputTemperature - 273.15
        } else {
            temperatureInCelsius = inputTemperature
        }
        
        //Then we calculate from Celcius to our desired output
        
        if(outputTemperatureUnit == "Farenheit") {
            outputTemperature = (temperatureInCelsius * 1.8) + 32
        } else if(outputTemperatureUnit == "Kelvin") {
            outputTemperature = temperatureInCelsius + 273.15
        } else {
            outputTemperature = temperatureInCelsius
        }
        
        return outputTemperature
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section {
                    Picker("Input temperature unit", selection: $inputTemperatureUnit) {
                        ForEach(temperatures, id: \.self) { temperature in
                                      Text(temperature.capitalized)
                      }
                    }
                    Picker("Output temperature unit", selection: $outputTemperatureUnit) {
                        ForEach(temperatures, id: \.self) { temperature in
                                      Text(temperature.capitalized)
                      }
                    }
                } header: {
                    Text("Please select your in and outputs")
                }
                Section {
                    TextField("Temperature input", value: $inputTemperature, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Enter amount of \(inputTemperatureUnit)")
                }
            
                Section {
                    Text(convertedTemperature, format: .number)
                } header: {
                    Text("Amount in \(outputTemperatureUnit)")
                }
            }
            .navigationTitle("WeConvert")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
