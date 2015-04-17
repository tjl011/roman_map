//
//  RomanMapOverlay.swift
//  tom-teget-final-project
//
//  Created by TomLudwig on 4/17/15.
//  Copyright (c) 2015 Bucknell University. All rights reserved.
//

import Foundation
import UIKit
import MapKit


/// Base Roman Empire Map Overlay
class RomanMapOverlay: NSObject, MKOverlay {
    /// Center coordinate for overlay
    var coordinate: CLLocationCoordinate2D
    /// Bounds of Overlay
    var boundingMapRect: MKMapRect
    
    /**
        Constructor for RomanMapOverlay, uses RomanMapModel to create overlay.
        :param: romeMap 'model' object of basic Roman map.
    */
    init(romeMap: RomanMapModel) {
        self.boundingMapRect = romeMap.overlayBoundingMapRect
        self.coordinate = romeMap.midCoord
    }
}