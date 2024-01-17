//
//  NumberGenerator.swift
//  BingoGenerator
//
//  Created by Giang Dong Trinh on 23/12/2020.
//

import Foundation

class NumberGenerator {
    
    static let shared = NumberGenerator()
    
    func generateNumberMatrix(numberOfMatrix: Int) -> [[[Int]]] {
        var matrixies: [[[Int]]] = []
        
        for matrixIndex in 1...numberOfMatrix {
            var numbers = Array(1...75)
            var matrix: [[Int]] = []
            
            print("[Generating][Matrix] \(matrixIndex)")
            
            for _ in 1...5 {
                
                var columns: [Int] = []
                for _ in 1...5 {
                    var shuffledNumbers = numbers.shuffled()
                    let number = shuffledNumbers.remove(at: 0)
                    numbers = shuffledNumbers
                    columns.append(number)
                }
                matrix.append(columns)
            }
            
            matrixies.append(matrix)
        }
        
        return matrixies
    }
}
