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
        
        println("Getting map span")
        let mapSpan = baseRomanMap.getMapSpan()
        let romanMapRegion = MKCoordinateRegionMake(baseRomanMap.midCoord, mapSpan)
        baseMapView.region = romanMapRegion
        println("Base map loaded")
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
        This method adds a polygon-overlay of the province Britannica. It is a test. 
        In the future, we will add all the provincial boundaries.
    */
    func addBritannicaBoundary() {
        
    }
    
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
        return nil
    }
    
}