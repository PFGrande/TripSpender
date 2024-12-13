//
//  Trip.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/13/24.
//

import Foundation
import SwiftUI

// will contain information about the trip

struct TripInfo {
    var destination: String; // address provided by user
    var tripThumbnail: Image;
    var contributors: [User];
    var tripItems: [TripItem];
    
}
