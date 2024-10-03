//
//  CatInfoViewModel.swift
//  Catminator
//
//  Created by Macky Ramirez on 10/2/24.
//

import Foundation
class CatInfoViewModel: BaseViewModel {
    var cat: Cat?
    func getRandomCats() {
        self.delegate?.loading()
        NetworkManager.shared.getRandomCat() { [weak self] result in
            guard let self = self else { return }
            self.delegate?.dismiss()
            switch result {
            case .success(let cats):
                print(cats)
                cats.response?.enumerated().forEach { (index, desc) in
                    let meow = Cat(id: index, catdesc: desc, catUrl: Images.ramdomCatUrl)
                    self.cat = (meow)
                }
                self.delegate?.didRequestSuccess(self.cat!)
            case .failure(let error):
                self.delegate?.didRequestFailed(error: error)
            }
        }
    }
}
