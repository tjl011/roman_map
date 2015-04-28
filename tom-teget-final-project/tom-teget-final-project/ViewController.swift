//
//  ViewController.swift
//  tom-teget-final-project
//
//  Created by TomLudwig on 4/17/15.
//  Copyright (c) 2015 Bucknell University. All rights reserved.
//

import UIKit
import MapKit


/// This class is the 'main' view controller of the project
class ViewController: UIViewController {

    /// Map view
    @IBOutlet weak var baseMapView: MKMapView!
    
    /// Base Roman Empire model object
    var baseRomanMap = RomanMapModel(mapInfoName: "baseRomanMap")
    
    /// This object encapsulates the data of each province
    var aggregateProvincialData = AggregateProvinceModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapSpan = baseRomanMap.getMapSpan()
        let romanMapRegion = MKCoordinateRegionMake(baseRomanMap.midCoord, mapSpan)
        baseMapView.region = romanMapRegion
        println("Base map loaded")
        
        baseMapView.delegate = self
        
        for provinceName in aggregateProvincialData.provincialModelDictionary.keys {
            println("Adding province \(provinceName)")
            addProvincialPolygonOverlay(provinceName)
        }
        
        //addRomanMapOverlay()
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
        This helper method generates a polygonal overlay of a province whose
        identifier is passed into this function as input
        
        :param: provinceIdentifier - Province key i.e. 'dacia' or 'moesia_superior'
        :returns: true if the province was successfully added otherwise false
    */
    func addProvincialPolygonOverlay(provinceIdentifier: String) -> Bool {
        let provinceData = aggregateProvincialData.provincialModelDictionary[provinceIdentifier] as! RomanProvinceModel?
        if (provinceData == nil) {
            println("WARNING: \(provinceIdentifier) is not a valid key in the provincialModelDictionary")
            return false
        }
        else {
            let provinceOverlay = MKPolygon(coordinates: &(provinceData!.provinceBoundary), count: provinceData!.provinceBoundary.count)
            baseMapView.addOverlay(provinceOverlay)
            return true
        }
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
            //provinceRenderer!.fillColor = provinceRenderer as
            provinceRenderer!.strokeColor = UIColor.blueColor()
            // TODO - add color to polygon overlay
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