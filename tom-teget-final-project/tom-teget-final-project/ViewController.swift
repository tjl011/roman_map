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
    
    /// Provincial model object - Britannia
    var BritannicaModel = RomanProvinceModel(provinceInfoFileName: "dacia")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapSpan = baseRomanMap.getMapSpan()
        let romanMapRegion = MKCoordinateRegionMake(baseRomanMap.midCoord, mapSpan)
        baseMapView.region = romanMapRegion
        println("Base map loaded")
        
        baseMapView.delegate = self
        addBritannicaOverlay()
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
        This method adds a polygon-overlay of the province Britannica. It is a test. 
        In the future, we will add all the provincial boundaries.
    */
    func addBritannicaOverlay() {
        println(NSString(format: "Adding Britannica overlay: %d", BritannicaModel.provinceBoundary.count))
        
        var mapPointArray: [MKMapPoint]
        mapPointArray = []
        for coord2D in BritannicaModel.provinceBoundary {
            let mapPoint = MKMapPointForCoordinate(coord2D)
            mapPointArray += [mapPoint]
        }
        let provincePolygon = MKPolygon(points: &mapPointArray, count: mapPointArray.count)
      //  let provincePolygon = MKPolygon(coordinates: &BritannicaModel.provinceBoundary, count: BritannicaModel.provinceBoundary.count)
        provincePolygon.title = "Britannia"
        provincePolygon.subtitle = "Province of Britannia"
        baseMapView.addOverlay(provincePolygon)
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
        else if overlay is MKPolygon {
            println("province delegate adding overlay")
           
            var provinceRenderer = MKPolygonRenderer(overlay: overlay)
            provinceRenderer!.fillColor = UIColor.greenColor()
            provinceRenderer!.strokeColor = UIColor.greenColor()
            provinceRenderer!.lineWidth = 1.5
            
            return provinceRenderer
        }
        return nil
    }
    
    /**
        Adds overlay views to mapView.
    */
    func mapView(mapView: MKMapView!, viewForOverlay overlay: MKOverlay!) -> MKOverlayView! {
        if overlay is MKPolygon {
            println("Display overlay view")
            var provinceView = MKPolygonView(overlay: overlay)
            return provinceView!
        }
        return nil
    }
}