//
//  ContentView.swift
//  PayBillTip
//
//  Created by Vishrut Vatsa on 14/07/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10,15,20,25,0]
    
    var body: some View {
        NavigationView{
            Form {
                
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    //                I added a line break before .keyboardType and also indented it one level deeper than TextField – that isn’t required, but it can help me keep track of which modifiers apply to which views.
                    
                    
                    TextField("Number of People", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Original Value with the Tip added ")) {
                    Text("₹\(UnchangedAmount, specifier: "%.2f")")
                }
                
                Section (header: Text("Amount per person")){
                    Text("₹\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Pay Bill")
            
            
        }
    }
    
    var totalPerPerson: Double {
        //calculate the total per person here
        
        let peopleCount = Double(numberOfPeople) ?? 1
        let tipSelection = Double(tipPercentages[tipPercentage])
        
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal/peopleCount
        
        return amountPerPerson
        
    }
    var UnchangedAmount: Double {
        
        
        let tipSelection = Double(tipPercentages[tipPercentage])
        
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        
        return grandTotal
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
