//
//  RomanProvinceModel.swift
//  tom-teget-final-project
//
//  Created by Tom J. Ludwig on 4/22/15.
//  Copyright (c) 2015 Bucknell University. All rights reserved.
//

import Foundation
import MapKit

// Global Varibles
let DEFAULT_OVERLAY_COLOR = UIColor.blueColor()

/// Container class for Roman Province, contains information to build MKPolygonOverlay
public class RomanProvinceModel {
    
    /// Name of resource file that contains provincial overlay information.
    var provinceInfoFileName: String?
    
    /// Proper name of Province
    var provinceName: String?
    
    /// Array of CLLocationCoordinate2D structs that contain the province boundary
    var provinceBoundary: [CLLocationCoordinate2D]
    
    /// Array of map points parsed from plist file
    var mapPointArray: [MKMapPoint]
    
    // TODO: Add class variables regarding Province information
    
    // TODO: Add overlay color and alpha (transparcey)
    var overlayColor: UIColor
    
    
    /**
        Constructor for RomanProvinceModel. This object is a container for the provinces, and it is used to build MKPolygon overlay and provincial overlay, among other things.
        
        If you initialize a Roman Province without specifying a color, the default color is
        :param: provinceInfoFileName - name of resource file that contains data for a given province
    */
    init(provinceInfoFileName: String) {
        self.provinceInfoFileName = provinceInfoFileName
        self.overlayColor = DEFAULT_OVERLAY_COLOR
        
        let resourceFilePath = NSBundle.mainBundle().pathForResource(self.provinceInfoFileName!, ofType: "plist")
        let provinceProperties = NSDictionary(contentsOfFile: resourceFilePath!)
        
        self.provinceName = provinceProperties!["province"] as? String
        
        self.provinceBoundary = []
        self.mapPointArray = []
        let boundaryPoints = provinceProperties!["coordinates"] as! NSArray
        for boundaryPoint in boundaryPoints {
            let point = CGPointFromString(boundaryPoint as! String)
            let coordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(point.x),
                CLLocationDegrees(point.y))
                
            self.provinceBoundary.append(coordinate2D)
        }
    }
    
    /**
        Constructor for RomanProvinceModel. This object is a container for the provinces, and it is
        used to build a MKPolygon ovelay of the provincial data.

        This constructor initializes the data with a user-defined MKPolygon color.
        
        :param: provinceInfoFileName - name of resource file that contains data for a given province
        :param: overlayColor - color used to delineate provincial mkpolygon overlay
    */
    init(provinceInfoFileName: String, overlayColor: UIColor) {
        self.provinceInfoFileName = provinceInfoFileName
        self.overlayColor = overlayColor
        
        let resourceFilePath = NSBundle.mainBundle().pathForResource(self.provinceInfoFileName!, ofType: "plist")
        let provinceProperties = NSDictionary(contentsOfFile: resourceFilePath!)
        
        self.provinceName = provinceProperties!["province"] as? String
        
        self.provinceBoundary = []
        self.mapPointArray = []
        let boundaryPoints = provinceProperties!["coordinates"] as! NSArray
        for boundaryPoint in boundaryPoints {
            let point = CGPointFromString(boundaryPoint as! String)
            let coordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(point.x),
                CLLocationDegrees(point.y))
            
            self.provinceBoundary.append(coordinate2D)
        }
    }
    
    // TODO: Add method to generate MKMapPoint coordinates?
}