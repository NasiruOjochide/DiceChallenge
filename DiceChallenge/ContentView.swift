//
//  ContentView.swift
//  DiceChallenge
//
//  Created by Danjuma Nasiru on 25/03/2023.
//

import SwiftUI

struct ContentView: View {
    let diceSides = [4,6,8,10,12,16,20,100]
    let noOfDice = [1,2]
    @State private var numberOfDice = 1
    @State private var diceChoice = 4
    @State private var diceRolled = false
    @State private var flicks = 0
    var dice : [Int]{
        var array = [Int]()
        for i in 1...diceChoice{
            array.append(i)
        }
        return array
    }
    @State private var timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    @State private var result1 = 0
    @State private var result2 = 0
    @State private var noOfRolls = 0
    var total : Int{
        if numberOfDice == 1{
            return result1
        }
        if numberOfDice == 2 {
            return result1 + result2
        }
        return result1
    }
    @State private var sumTotal = 0
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Text("Select your type of dice").font(.subheadline.italic())
                    Picker("Choose Difficulty", selection: $diceChoice){
                        ForEach(diceSides, id: \.self){sides in
                            Text("\(sides) sides")
                        }
                    }.onChange(of: diceChoice, perform: {x in
                        sumTotal = 0
                        noOfRolls = 0
                    })
                    Picker("Choose number of Dice", selection: $numberOfDice){
                        ForEach(noOfDice, id: \.self){num in
                            Text("\(num)")
                        }
                    }.onChange(of: numberOfDice, perform: {x in
                        sumTotal = 0
                        noOfRolls = 0
                    })
                }.frame(height: 200)
                VStack{
                    Spacer()
                    Button{
                        flicks = 0
                        diceRolled = true
                        timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
                    } label: {
                        Text("Roll").font(.title3.bold())
                            .onReceive(timer){time in
                                if !diceRolled{
                                    timer.upstream.connect().cancel()
                                }else{
                                    flicks += 1
                                    switch numberOfDice{
                                    case 1:
                                        
                                        result1 = dice.randomElement() ?? 1
                                        if flicks == 6{
                                            sumTotal += result1
                                            diceRolled = false
                                            timer.upstream.connect().cancel()
                                        }
                                    case 2:
                                        result1 = dice.randomElement() ?? 1
                                        result2 = dice.randomElement() ?? 1
                                        if flicks == 6{
                                            sumTotal += result1 + result2
                                            diceRolled = false
                                            timer.upstream.connect().cancel()
                                        }
                                    default:
                                        result1 = dice.randomElement() ?? 1
                                        diceRolled = false
                                        sumTotal += result1
                                    }
                                }
                            }
                    }
                    .frame(width: 100, height: 20)
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    switch numberOfDice{
                    case 1:
                        Text(result1.formatted(.number)).padding()
                    case 2:
                        HStack{
                            Text(result1.formatted(.number)).padding(.horizontal, 40)
                                .padding(.vertical, 10)
                            Text(result2.formatted(.number)).padding(.horizontal, 40)
                                .padding(.vertical, 10)
                        }
                    default:
                        Text(result1.formatted(.number)).padding()
                    }
                    Spacer()
                    Text("Total: \(sumTotal)")
                    Text("Rolls: \(noOfRolls)")
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
