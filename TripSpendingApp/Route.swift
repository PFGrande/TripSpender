//
//  Route.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/14/24.
//

import SwiftUI
import Foundation

enum Route: Hashable, Equatable {
    case tripsview
    case registrationview
    case loginview
    case detailtripview(TripInfo) // Pass a TripInfo instance
    
    // case tripdetailview(TripInfo)
    // case profileview(User)
    var description: String { // for debugging
        switch self {
        case .registrationview: return "Registration View"
        case .loginview: return "Login View"
        case .tripsview: return "Trips View"
        case .detailtripview(let trip): return "Trips Detail View \(trip.destination)"
        }
    }
}
