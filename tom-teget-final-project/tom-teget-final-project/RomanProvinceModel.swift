//
//  RomanProvinceModel.swift
//  tom-teget-final-project
//
//  Created by Tom J. Ludwig on 4/22/15.
//  Copyright (c) 2015 Bucknell University. All rights reserved.
//

import Foundation
import MapKit

/// Container class for Roman Province
class RomanProvinceModel {
    
    /// Name of resource file that contains provincial overlay information.
    var provinceInfoFileName: String?
    
    /// Proper name of Province
    var provinceName: String?
    
    /// Array of CLLocationCoordinate2D structs that contain the province boundary
    var provinceBoundary: [CLLocationCoordinate2D]
    
    /// Array of map points parsed from plist file
    var mapPointArray: [MKMapPoint]
    
    // TODO: Add class variables regarding Province information
    
    
    /**
        Constructor for RomanProvinceModel. This object is a container for the provinces, used to 
        build MKPolygon overlay and provincial overlay, among other things.
            
        :param: provinceInfoFileName - name of resource file that contains data for a given province
    */
    init(provinceInfoFileName: String) {
        self.provinceInfoFileName = provinceInfoFileName
        
        let resourceFilePath = NSBundle.mainBundle().pathForResource(self.provinceInfoFileName!, ofType: "plist")
        let provinceProperties = NSDictionary(contentsOfFile: resourceFilePath!)
        
        self.provinceName = provinceProperties!["province"] as? String
        
        self.provinceBoundary = []
        self.mapPointArray = []
        let boundaryPoints = provinceProperties!["coordinates"] as! NSArray
        for boundaryPoint in boundaryPoints {
            let point = CGPointFromString(boundaryPoint as! String)
            let coordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(point.y),
                CLLocationDegrees(point.x))
                
            self.provinceBoundary.append(coordinate2D)
        }
    }
    
    // TODO: Add method to generate MKMapPoint coordinates?
}