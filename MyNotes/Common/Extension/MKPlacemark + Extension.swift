//
//  MKPlacemark + Extension.swift
//  MyNotes
//
//  Created by rau4o on 6/27/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit
import MapKit

extension MKPlacemark {
    var address: String? {
        get {
            guard let subThoroughfare = subThoroughfare else { return nil }
            guard let thoroughfare = thoroughfare else { return nil }
            guard let locality = locality else { return nil }
            guard let adminArea = administrativeArea else { return nil }
            
            return "\(subThoroughfare) \(thoroughfare), \(locality) \(adminArea)"
        }
    }
}
