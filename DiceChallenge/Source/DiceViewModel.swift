//
//  DiceViewModel.swift
//  DiceChallenge
//
//  Created by Danjuma Nasiru on 08/09/2023.
//

import Combine
import Foundation

class DiceViewModel: ObservableObject {
    
    @Published var numberOfDice = 1
    @Published var diceChoice = 4
    @Published var diceRolled = false
    @Published var flicks = 0
    @Published var result1 = 0
    @Published var result2 = 0
    @Published var noOfRolls = 0
    @Published var sumTotal = 0
    var cancellable = Set<AnyCancellable>()
    var timerCanceler: AnyCancellable? = nil
    let diceSides = [4,6,8,10,12,16,20,100]
    let noOfDice = [1,2]
    var dice : [Int]{
        var array = [Int]()
        for i in 1...diceChoice{
            array.append(i)
        }
        return array
    }
    
    func subscribeToTimer() {
        /*timerCanceler =*/ Timer
            .publish(every: 0.3, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { time in
                if !self.diceRolled{
                    //self.timerCanceler?.cancel()
                    for timer in self.cancellable {
                        timer.cancel()
                    }
                    print("cancelled")
                } else {
                    self.flicks += 1
                    switch self.numberOfDice {
                    case 1:
                        self.result1 = self.dice.randomElement() ?? 1
                        if self.flicks == 6 {
                            self.sumTotal += self.result1
                            self.diceRolled = false
                        }
                    case 2:
                        self.result1 = self.dice.randomElement() ?? 1
                        self.result2 = self.dice.randomElement() ?? 1
                        if self.flicks == 6 {
                            self.sumTotal += self.result1 + self.result2
                            self.diceRolled = false
                        }
                    default:
                        self.result1 = self.dice.randomElement() ?? 1
                        self.diceRolled = false
                        self.sumTotal += self.result1
                    }
                }
            })
            .store(in: &cancellable)
    }
}
