//
//  ContentView.swift
//  Converter
//
//  Created by Andres camilo Raigoza misas on 5/02/22.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 1.0
    @State private var selectedUnits = 0
    @State private var inputUnit: Dimension = UnitLength.meters
    @State private var outputUnit: Dimension = UnitLength.kilometers
    @FocusState private var inputIsFocused: Bool
    
    let conversions = ["Distance", "Mass", "Temperature", "Time"]
    
    let unitTypes = [
        [UnitLength.meters, UnitLength.feet, UnitLength.yards, UnitLength.miles, UnitLength.kilometers],
        [UnitMass.grams, UnitMass.ounces, UnitMass.pounds, UnitMass.kilograms],
        [UnitTemperature.celsius, UnitTemperature.kelvin, UnitTemperature.fahrenheit],
        [UnitDuration.seconds, UnitDuration.minutes, UnitDuration.hours]
    ]
    
    let formatter: MeasurementFormatter
    
    var result: Double {
        let input = Measurement(value: input, unit: inputUnit)
        let output = input.converted(to: outputUnit)
        return output.value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Type of Conversion:")
                        Spacer()
                        Picker("Conversion", selection: $selectedUnits) {
                            ForEach(0..<conversions.count) {
                                Text(conversions[$0])
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    HStack {
                        TextField("Enter your value here...", value: $input, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($inputIsFocused)
                        
                        Picker("From", selection: $inputUnit) {
                            ForEach(unitTypes[selectedUnits], id: \.self) {
                                Text(formatter.string(from: $0).capitalized)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    HStack {
                        Text(result, format: .number)
                        
                        Spacer()
                        
                        Picker("To", selection: $outputUnit) {
                            ForEach(unitTypes[selectedUnits], id: \.self) {
                                Text(formatter.string(from: $0).capitalized)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
            }
            .navigationTitle("Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
            .onChange(of: selectedUnits) { newSelection in
                inputUnit = unitTypes[newSelection].first ?? UnitLength.kilometers
                outputUnit = unitTypes[newSelection].last ?? UnitLength.meters
            }
        }
    }
    
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    
    enum TempUnit: String, CaseIterable {
        case Celcius
        case Fahrenheit
        case Kelvin
    }
    
//    func getConversion() -> Double {
//        switch (inputUnit, resultUnit) {
//        case (.Celcius, .Fahrenheit):
//            return (inputValue * 9/5) + 32
//        case (.Celcius, .Kelvin):
//            return inputValue + 273.15
//        case (.Fahrenheit, .Kelvin):
//            return (inputValue - 32) * 5/9 + 273.15
//        case (.Fahrenheit, .Celcius):
//            return (inputValue - 32) * 5/9
//        case (.Kelvin, .Fahrenheit):
//            return ((inputValue * 1_000) - 273.15 * 9/5 + 32)
//        case (.Kelvin, .Celcius):
//            return (inputValue * 1_000) - 273.15
//        default:
//            return inputValue
//        }
//    }
    func convertWithBuiltIn() {
        let input = Measurement(value: input, unit: UnitTemperature.fahrenheit)
        let _ = input.converted(to: .celsius)
    }
//    func convert() -> Double {
//        var inputInCelcius: Double
//
//        switch inputUnit {
//        case .Fahrenheit:
//            inputInCelcius = (inputValue - 32) * 5/9
//        case .Kelvin:
//            inputInCelcius = (inputValue * 1_000) - 273.15
//        case .Celcius:
//            inputInCelcius = inputValue
//        }
//
//        switch resultUnit {
//        case .Fahrenheit:
//            return (inputInCelcius * 9/5) + 32
//        case .Kelvin:
//            return inputInCelcius + 273.15
//        case .Celcius:
//            return inputInCelcius
//        }
//    }
}
