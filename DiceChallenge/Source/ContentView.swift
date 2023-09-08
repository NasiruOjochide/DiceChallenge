//
//  ContentView.swift
//  DiceChallenge
//
//  Created by Danjuma Nasiru on 25/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var diceVM = DiceViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Text("Select your type of dice").font(.subheadline.italic())
                    
                    Picker("Choose Difficulty", selection: $diceVM.diceChoice) {
                        ForEach(diceVM.diceSides, id: \.self){ sides in
                            Text("\(sides) sides")
                        }
                    }
                    .onChange(of: diceVM.diceChoice, perform: { x in
                        diceVM.sumTotal = 0
                        diceVM.noOfRolls = 0
                    })
                    
                    Picker("Choose number of Dice", selection: $diceVM.numberOfDice) {
                        ForEach(diceVM.noOfDice, id: \.self){ num in
                            Text("\(num)")
                        }
                    }
                    .onChange(of: diceVM.numberOfDice, perform: { x in
                        diceVM.sumTotal = 0
                        diceVM.noOfRolls = 0
                    })
                }
                .frame(height: 200)
                
                VStack {
                    Spacer()
                    
                    Button{
                        diceVM.flicks = 0
                        diceVM.noOfRolls += 1
                        diceVM.diceRolled = true
                        diceVM.subscribeToTimer()
                    } label: {
                        Text("Roll").font(.title3.bold())
                    }
                    .frame(width: 100, height: 20)
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    
                    switch diceVM.numberOfDice {
                    case 1:
                        Text(diceVM.result1.formatted(.number)).padding()
                    case 2:
                        HStack{
                            Text(diceVM.result1.formatted(.number)).padding(.horizontal, 40)
                                .padding(.vertical, 10)
                            Text(diceVM.result2.formatted(.number)).padding(.horizontal, 40)
                                .padding(.vertical, 10)
                        }
                    default:
                        Text(diceVM.result1.formatted(.number)).padding()
                    }
                    
                    Spacer()
                    
                    Text("Total: \(diceVM.sumTotal)")
                    
                    Text("Rolls: \(diceVM.noOfRolls)")
                    
                    Spacer()
                }
                Spacer()
                
                Spacer()                
            }
            .navigationTitle("Dice Rolls")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
