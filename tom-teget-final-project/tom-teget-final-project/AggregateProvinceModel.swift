//
//  AggregateProvinceModel.swift
//  tom-teget-final-project
//
//  Created by Tom J. Ludwig on 4/24/15.
//  Copyright (c) 2015 Bucknell University. All rights reserved.
//

import Foundation
import MapKit

/// Global variable for resource file name that contains the names of all the provincial resource file names
let PROVINCIAL_DATA_RESOURCE = "province_list"

let RGB_ARRAY = [UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor()]

class AggregateProvinceModel {
    
    /// Dictionary of provincial plist file names to their associated model
    var provincialModelDictionary: [String: RomanProvinceModel?]
    
    /// Official Title of Map
    var officialMapTitle: String?
    
    
    /**
        Constructor for AggregateProvinceModel.
        If a province resource file doesn't exist yet, the value for the specified file name key is nil
    */
    
    init() {
        let resourceFilePath = NSBundle.mainBundle().pathForResource(PROVINCIAL_DATA_RESOURCE, ofType: "plist")
        let provincialResourceDictionary = NSDictionary(contentsOfFile: resourceFilePath!)
        
        self.officialMapTitle = provincialResourceDictionary!["name"] as? String
        
        // Populate dictionary by iterating through provinces array in plist file
        self.provincialModelDictionary = [String: RomanProvinceModel]()
        for resourceFile in provincialResourceDictionary!["provinces"] as! NSArray {
            let provincialResource = NSBundle.mainBundle().pathForResource(resourceFile as? String, ofType: "plist")
            if (provincialResource == nil) {
                println("WARNING: \(resourceFile) COULD NOT BE LOCATED!")
                self.provincialModelDictionary[(resourceFile as? String)!] = nil
            }
            else {
                println("DEBUG: \(resourceFile) WAS FOUND")
                self.provincialModelDictionary[resourceFile as! String] = RomanProvinceModel(provinceInfoFileName: resourceFile as! String)
            }
        }
        
    } /* init() */
    
}