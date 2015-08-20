//
//  MapViewController.swift
//  ISM Shuttle
//
//  Created by Shubham Chauhan on 10/08/15.
//  Copyright (c) 2015 Ayush AGRAwal. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class MapViewController: UIViewController, NSURLConnectionDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var busLocation :MKPointAnnotation?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.mapView.showsUserLocation = true
        let initialLocation = CLLocation(latitude: 23.81, longitude: 86.44)
        centerMapOnLocation(initialLocation)

        // Do any additional setup after loading the view.
        
        var timer : NSTimer = NSTimer.scheduledTimerWithTimeInterval(5.0, target:self, selector:Selector("track:"), userInfo: nil, repeats: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 700
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius * 1.3, regionRadius * 1.3)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func track(timer:NSTimer){
        
        if ((busLocation) != nil){
            mapView.removeAnnotation(busLocation)
        }
        else{
            busLocation = MKPointAnnotation()
        }
        
        let json = JSON.fromURL("http://shuttletracker.zz.mu/?bus=1&latest=1")
        
        let lat:Double = (json["latitude"].toString() as NSString).doubleValue
        let lon:Double = (json["longitude"].toString() as NSString).doubleValue
        
        busLocation!.coordinate = CLLocationCoordinate2D(latitude:coordinates(lat/100.0), longitude:coordinates(lon/100.0))
        mapView.addAnnotation(busLocation)
        
        //centerMapOnLocation(CLLocation(latitude:coordinates(lat/100.0), longitude:coordinates(lon/100.0)))

    }
    
    func coordinates(var f: Double)->Double{
        var a : Int = Int(f)
        var frac : Double = (f - Double(a))/0.6
        return Double(a) + frac
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
