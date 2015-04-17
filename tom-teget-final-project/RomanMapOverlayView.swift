//
//  RomanMapOverlayView.swift
//  tom-teget-final-project
//
//  Created by TomLudwig on 4/17/15.
//  Copyright (c) 2015 Bucknell University. All rights reserved.
//

import UIKit
import MapKit

/// Roman Map Rendering implementation
class RomanMapOverlayView: MKOverlayRenderer {
    /// Roman map image to be overlayed
    var overlayImage: UIImage
    
    /**
        Instantiates a RomanMapOverlayView object used to add an overlay 
        of the map of Roman Empire.

        :param: overlay - referece to overlay object
        :param: overlayImage - image to be overlayed over map.
    */
    init(overlay: MKOverlay, overlayImage: UIImage) {
        self.overlayImage = overlayImage
        super.init(overlay: overlay)
    }
    
    /**
        Defines how the overlayed Image should be displayed
        given different input parameters.
        TODO - Write better comments
        :param: mapRect - TODO
        :param: zoomScale - TODO
    
    */
    override func drawMapRect(mapRect: MKMapRect, zoomScale: MKZoomScale,inContext context: CGContext!) {
                
        let imageReference = overlayImage.CGImage
        
        let boundingRect = overlay.boundingMapRect
        let imageRect = rectForMapRect(boundingRect)
        
        // Display the image
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextTranslateCTM(context, 0.0, -imageRect.size.height)
        CGContextDrawImage(context, imageRect, imageReference)
        
    }
}