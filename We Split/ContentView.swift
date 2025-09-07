//
//  ContentView.swift
//  We Split
//
//  Created by isa on 06.09.25.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 0
    @FocusState private var amountIsFocused: Bool
    
    private let tipPercentages = [10, 15, 20, 25, 0]
    
    private let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    private var amountPerPerson: Double {
        let percent = 1.0 + Double(tipPercentage) / 100.0
        let totalAmount = amount * percent
        
        return totalAmount / Double(numberOfPeople)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(
                        "Amount",
                        value: $amount,
                        format: .currency(code: currencyCode)
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2...99, id: \.self) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage)  {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Text(amountPerPerson, format: .currency(code: currencyCode))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
