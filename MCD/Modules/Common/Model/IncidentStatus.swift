//
//  IncidentStatus.swift
//  MCD
//
//  Created by Weiyi Kong on 16/8/2022.
//

import Foundation

enum IncidentStatus: String, Codable {
    case underControl = "Under control"
    case onScene = "On Scene"
    case outOfControl = "Out of control"
    case pending = "Pending"
}
