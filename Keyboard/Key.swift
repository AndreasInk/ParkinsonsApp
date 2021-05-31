//
//  Key.swift
//  Keyboard
//
//  Created by Andreas on 4/23/21.
//

import SwiftUI

struct Key: Hashable, Codable {
    var id: UUID
    var key: String
    var sens: Double
}

