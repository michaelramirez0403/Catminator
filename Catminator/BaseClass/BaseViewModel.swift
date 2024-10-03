//
//  BaseViewModel.swift
//  GGFApp
//
//  Created by Macky Ramirez on 9/2/24.
//

import Foundation
protocol CatDelegate: AnyObject {
    func loading()
    func dismiss()
    func show(_ alert: String)
    func didSelect(_ cat: IndexPath)
    func didRequestSuccess(_ cat: Cat)
    func didRequestFailed(error: CatError)
}
extension CatDelegate {
    func loading() { }
    func dismiss() { }
    func show(_ alert: String) { }
    func didSelect(_ cat: IndexPath) { }
    func didRequestSuccess(_ cat: Cat) { }
    func didRequestFailed(error: CatError) { }
}
class BaseViewModel: NSObject {
    weak var delegate: CatDelegate?
    init(_ delegate: CatDelegate? = nil) {
        super.init()
        self.delegate = delegate
    }
}
