//
//  Loaded.swift
//  Socialcademy
//
//  Created by Łukasz Adamczak on 16/08/2025.
//

import Foundation

enum Loadable<Value> {
    case loading
    case error(Error)
    case loaded(Value)
}

extension Loadable where Value: RangeReplaceableCollection {
    static var empty: Loadable<Value> { .loaded(Value()) }
}
