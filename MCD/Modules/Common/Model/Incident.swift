//
//  Incident.swift
//  MCD
//
//  Created by Weiyi Kong on 15/8/2022.
//

import Foundation
import CoreLocation

struct Incident: Codable {
    static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    let title: String?
    let callTime: Date?
    let lastUpdated: Date?
    let id: String?
    let latitude: Double?
    let longitude: Double?
    let description: String?
    let location: String?
    let status: IncidentStatus?
    let type: String?
    let typeIcon: URL?

    var coordinate: CLLocationCoordinate2D? {
        guard let latitude = latitude, let longitude = longitude else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
