//
//  SecondViewController.swift
//  Midterm_Reich
//
//  Created by Stephen Reich on 10/6/15.
//  Copyright © 2015 Stephen Reich. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController, MKMapViewDelegate{
    
    @IBOutlet weak var summaryText: UITextView!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var severityLabel: UILabel!
    @IBOutlet weak var certaintyLabel: UILabel!
    @IBOutlet weak var urgencyLabel: UILabel!
    @IBOutlet weak var expiresLabel: UILabel!
    @IBOutlet weak var effectiveLabel: UILabel!
    
    @IBOutlet weak var alertMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if polygon.count > 0
        {
            let lat = coordinates[0]
            let lon = coordinates[1]
            let initialLocation = CLLocation(latitude: lat as CLLocationDegrees, longitude: lon as CLLocationDegrees)
            centerMapOnLocation(initialLocation)
        }
        else
        {
        let initialLocation = CLLocation(latitude: 49.140838, longitude: -123.127886)
            centerMapOnLocation(initialLocation)
        }
        alertMap.delegate = self
                
        eventLabel.text = "\(eventLabel1)"
        summaryText.text = "\(summaryLabel1)"
        severityLabel.text = "\(severityLabel1)"
        certaintyLabel.text = "\(certaintyLabel1)"
        urgencyLabel.text = "\(urgencyLabel1)"
        expiresLabel.text = "\(expiresLabel1)"
        effectiveLabel.text = "\(effectiveLabel1)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    let regionRadius: CLLocationDistance = 10000
   
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        alertMap.setRegion(coordinateRegion, animated: true)
    }
    
    
    @IBAction func WebLink(sender: UIButton) {
        if let url = NSURL(string: linkLabel1) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
}