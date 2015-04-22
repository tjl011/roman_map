//
//  RomanMapModel.swift
//  tom-teget-final-project
//
//  Created by TomLudwig on 4/17/15.
//  Copyright (c) 2015 Bucknell University. All rights reserved.
//

import Foundation
import MapKit


/// Container class for base Roman Map model
class RomanMapModel {
    
    /// This array defines the boundaries of the Roman Empire map we use
    var mapBoundary: [CLLocationCoordinate2D]
    
    /// Length of mapBoundary
    var mapBoundaryCount: NSInteger
    
    /// Center coordinate for map
    var midCoord: CLLocationCoordinate2D
    
    /// Upper left coordinate for map overlay
    var overlayTopLeftCoord: CLLocationCoordinate2D
    
    /// Upper right coordinate for map overlay
    var overlayTopRightCoord: CLLocationCoordinate2D
    
    /// Bottom left coordinate for map overlay
    var overlayBottomLeftCoord: CLLocationCoordinate2D
    
    /// Bottom right coordinate for map overlay
    var overlayBottomRightCoord: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2DMake(overlayBottomLeftCoord.latitude,
                                                overlayTopRightCoord.longitude)
        }
    }
    
    /// Bounding rectangle for Roman Empire's boundaries
    var overlayBoundingMapRect: MKMapRect {
        get {
            let topLeft = MKMapPointForCoordinate(overlayTopLeftCoord)
            let topRight = MKMapPointForCoordinate(overlayTopRightCoord)
            let bottomLeft = MKMapPointForCoordinate(overlayBottomLeftCoord)
            
            return MKMapRectMake(topLeft.x, topLeft.y,
                                fabs(topLeft.x - topRight.x),
                                fabs(topLeft.y - bottomLeft.y))
        }
    }
    
    /// Name of resource file (i.e. plist file) that contains the map data
    var mapInfoName: String?
    
    /**
        Constructor for RomanMapModel.
        
        :param: mapInfoName name of resource file that contains the base Roman Map overlay.
    
    */
    init(mapInfoName: String) {
        self.mapInfoName = mapInfoName
        
        let filePath = NSBundle.mainBundle().pathForResource(self.mapInfoName!, ofType: "plist")
        let mapProperties = NSDictionary(contentsOfFile: filePath!)
        
        midCoord = RomanMapModel.generateBoundaryCoordinates(mapProperties!, overlayCoordKey: "midCoord")!
        
        overlayTopLeftCoord = RomanMapModel.generateBoundaryCoordinates(mapProperties!, overlayCoordKey: "overlayTopLeftCoord")!
        
        overlayTopRightCoord = RomanMapModel.generateBoundaryCoordinates(mapProperties!, overlayCoordKey: "overlayTopRightCoord")!
        
        overlayBottomLeftCoord = RomanMapModel.generateBoundaryCoordinates(mapProperties!, overlayCoordKey: "overlayBottomLeftCoord")!
    
       
        let boundaryPointsArray = mapProperties!["boundary"] as! NSArray
        
        self.mapBoundaryCount = boundaryPointsArray.count
        self.mapBoundary = []
        
        // populate map boundary with resource file for map
        for boundaryPoint in boundaryPointsArray {
            let point = CGPointFromString(boundaryPoint as! String)
            self.mapBoundary += [CLLocationCoordinate2DMake(CLLocationDegrees(point.x),
                CLLocationDegrees(point.y))]
        }
    }
    
    /**
        Helper method to generate map overlay coordinates from the data parsed from the RomanMapModel
        resource file (data is stored in a NSDictionary).
    
        :param: mapProperties -  dictionary that contains the map overlay coordinates
        :param: overlayCoordKey - key associated with a specific latitude, longitude pairing
    
        :returns: A CLLocationCoordinate2D for a specific overlay coordinate. If the input overlayCoordKey
        does not exist in the mapProperties dictionary, this fucntion returns nil.
    */
    
    class func generateBoundaryCoordinates(mapProperties: NSDictionary, overlayCoordKey: String) -> CLLocationCoordinate2D? {
        if mapProperties.objectForKey(overlayCoordKey) == nil {
            return nil
        }
        else {
            let overlayPoint = CGPointFromString(mapProperties[overlayCoordKey] as! String)
            
            return CLLocationCoordinate2DMake(CLLocationDegrees(overlayPoint.x),
                    CLLocationDegrees(overlayPoint.y))
        }
    }
    
    /**
        Generates the span of the base Roman map, measured from the upper left corner to
        the bottom right corner. Intended to be used by the view controller.
        :returns:
    */
    func getMapSpan() -> MKCoordinateSpan {
        let latDelta = overlayTopLeftCoord.latitude - overlayBottomRightCoord.latitude
        
        return MKCoordinateSpanMake(fabs(latDelta), 0.0)
        
    }

    
}