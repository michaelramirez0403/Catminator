//
//  CatInfoViewModel.swift
//  Catminator
//
//  Created by Macky Ramirez on 10/2/24.
//

import Foundation
class CatInfoViewModel: BaseViewModel {
    var cat: Cat?
    var cats: [Cat] = []
    func randomCat() -> Cat {
        let winner = cats.randomElement()!
        print("The winning number is \(winner).")
        return winner
    }
}
