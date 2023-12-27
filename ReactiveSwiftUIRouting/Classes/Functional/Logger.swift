//
//  Logger.swift
//  ReactiveSwiftUIRouting
//
//  Created by Viktor Jenei on 2023. 12. 27..
//

import Foundation
import os

extension Logger {
    static let subsystem = Bundle.main.bundleIdentifier!

    static let generic = Logger(subsystem: subsystem, category: "generic")
}
