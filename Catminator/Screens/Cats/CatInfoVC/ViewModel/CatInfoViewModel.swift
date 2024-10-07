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
//    func getRandomCat() {
//        self.delegate?.loading()
//        NetworkManager.shared.getRandomCat() { [weak self] result in
//            guard let self = self else { return }
//            self.delegate?.dismiss()
//            switch result {
//            case .success(let cats):
//                print(cats)
//                cats.response?.enumerated().forEach { (index, desc) in
//                    let randomString = String().randomString(of: Collection.randomStringLength) //1Prowp5DGId0yG7V
//                    let meow = Cat(id: index, catdesc: desc, catUrl: Images.ramdomCatUrl+"?_id=\(randomString)")
//                    self.cat = (meow)
//                }
//                self.delegate?.didRequestSuccess(self.cat!)
//            case .failure(let error):
//                self.delegate?.didRequestFailed(error: error)
//            }
//        }
//    }
    func randomCat() -> Cat {
        let winner = cats.randomElement()!
        print("The winning number is \(winner).")
        return winner
    }
}
