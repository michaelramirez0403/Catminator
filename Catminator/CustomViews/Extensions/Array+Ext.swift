//
//  Array+Ext.swift
//  Catminator
//
//  Created by Macky Ramirez on 10/2/24.
//
import UIKit
extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
