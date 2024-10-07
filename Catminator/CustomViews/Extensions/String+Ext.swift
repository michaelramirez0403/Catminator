//
//  String+Ext.swift
//  Catminator
//
//  Created by Macky Ramirez on 10/7/24.
//

import Foundation
extension String {
    func randomString(of length: Int) -> String {
//        var str = blank_
//        for _ in 0 ..< length {
//            str.append(Collection.letters.randomElement()!)
//        }
        return String((0..<length).map { _ in Collection.letters.randomElement()! })
   }
}
