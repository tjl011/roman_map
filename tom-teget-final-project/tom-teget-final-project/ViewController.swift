//
//  ViewController.swift
//  tom-teget-final-project
//
//  Created by TomLudwig on 4/17/15.
//  Copyright (c) 2015 Bucknell University. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    /// Map view
    @IBOutlet weak var baseMapView: MKMapView!
    
    /// Base Roman Empire model object
    var baseRomanMap = RomanMapModel(mapInfoName: "baseRomanMap")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapSpan = baseRomanMap.getMapSpan()
        let romanMapRegion = MKCoordinateRegionMake(baseRomanMap.midCoord, mapSpan)
        baseMapView.region = romanMapRegion
        println("Base map loaded")
        
        baseMapView.delegate = self
        addRomanMapOverlay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        // TODO - remove this function later?
    }
    
    /**
        Adds an overlay of the Roman Empire Image to the map view.
    */
    func addRomanMapOverlay() {
        println("adding overlay")
        let overlay = RomanMapOverlay(romeMap: baseRomanMap)
        baseMapView.addOverlay(overlay)
    }
    

    /**
        Test method used to generate overlay for the province Lusitania
    */
    
    func loadSelectedOptions() {
        // TODO - implement a way for the user to make selections

    }
}


// Mark: - Map View delegate

extension ViewController: MKMapViewDelegate {
    
    /** 
        Adds Roman Empire overlay to mapView 
    */
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if overlay is RomanMapOverlay {
            println("mapview delegate adding overlay")
            let romanMapImage = UIImage(named: "roman_map_117AD")
            
            let overlayMapView = RomanMapOverlayView(overlay: overlay, overlayImage: romanMapImage!)
            
            return overlayMapView
        }
        else if overlay is MKPolygon {
            println("province delegate adding overlay")
           
            var provinceRenderer = MKPolygonRenderer(overlay: overlay)
            //provinceRenderer!.fillColor = UIColor.greenColor()
            provinceRenderer!.strokeColor = UIColor.greenColor()
            provinceRenderer!.lineWidth = 1.5
            
            return provinceRenderer
        }
        return nil
    }
    
    /**
        Adds overlay views to mapView.
        TODO - remove (pretty sure we don't need)
    */
    func mapView(mapView: MKMapView!, viewForOverlay overlay: MKOverlay!) -> MKOverlayView! {
        if overlay is MKPolygon {
            println("Display overlay view")
            var provinceView = MKPolygonView(overlay: overlay)
            return provinceView!
        }
        return nil
    }
    
    /**
        Services user selection.
    */
  //  func mapView
}