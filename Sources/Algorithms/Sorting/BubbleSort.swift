//
//  BubbleSort.swift
//
//
//  Created by Marco Domingues on 12/06/2024.
//

import Foundation

public extension Array where Element: Comparable {
    mutating func bubbleSort() {
        let count = self.count
        for i in 0..<count {
            var swapped = false
            for j in 0..<count - i - 1 {
                if self[j] > self[j + 1] {
                    self.swapAt(j, j + 1)
                    swapped = true
                }
            }

            // Stop if the array is already sorted
            if !swapped {
                break
            }
        }
    }

    func bubbleSorted() -> [Element] {
        var sorted = self
        sorted.bubbleSort()
        return sorted
    }
}
