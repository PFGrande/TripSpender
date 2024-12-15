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
//    case createtripview
    case detailtripview(String)
    
    // case tripdetailview(TripInfo)
    // case profileview(User)
    var description: String { // for debugging
        switch self {
        case .registrationview: return "Registration View"
        case .loginview: return "Login View"
        case .tripsview: return "Trips View"
//        case .createtripview: return "Create Trip View"
        case .detailtripview(let tripId): return "Trip Detail View for \(tripId)"
        }
    }
}
//
//// localPath (located in TripsView.swift
//enum LocalRoute: Hashable, Equatable {
//
//    case createtripview
//    case detailtripview(TripInfo)
//
//    var description: String {
//        switch self {
//            case .createtripview: return "Create Trip View"
//            case .detailtripview(let trip): return "Trip Detail View for \(trip.id)"
//        }
//    }
//}
