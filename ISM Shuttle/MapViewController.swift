//
//  MapViewController.swift
//  ISM Shuttle
//
//  Created by Shubham Chauhan on 10/08/15.
//  Copyright (c) 2015 Ayush AGRAwal. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, NSURLConnectionDelegate {

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        var route: MKOverlay
        self.mapView.showsUserLocation = true
        let initialLocation = CLLocation(latitude: 23.81, longitude: 86.44)
        centerMapOnLocation(initialLocation)

        // Do any additional setup after loading the view.
        
        let json = JSON.fromURL("http://shuttletracker.zz.mu/?bus=1&latest=1")
        
        let lat:Double = (json["latitude"].toString() as NSString).doubleValue
        let lon:Double = (json["longitude"].toString() as NSString).doubleValue
        
        println("Latitude : \(lat/100) , Longitude : \(lon/100)")
        
        var busLocation = MKPointAnnotation()
        busLocation.coordinate = CLLocationCoordinate2D(latitude:lat/100, longitude:lon/100)
        
        mapView.addAnnotation(busLocation)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius * 1.5, regionRadius * 1.5)
        mapView.setRegion(coordinateRegion, animated: true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
