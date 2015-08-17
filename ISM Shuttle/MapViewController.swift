//
//  MapViewController.swift
//  ISM Shuttle
//
//  Created by Shubham Chauhan on 10/08/15.
//  Copyright (c) 2015 Shubham Chauhan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var bytes: NSMutableData?
    var bytes_final: NSMutableData?


    override func viewDidLoad() {
        
        super.viewDidLoad()
        var route: MKOverlay
        self.mapView.showsUserLocation = true
        let initialLocation = CLLocation(latitude: 23.81, longitude: 86.44)
        centerMapOnLocation(initialLocation)
        
        // Do any additional setup after loading the view.
        
        trackBus()
        var busLocation = MKPointAnnotation()
        var lat  = 23.81
        var longi = 86.44
        busLocation.coordinate = CLLocationCoordinate2D(latitude:lat, longitude:longi)
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
    
    func trackBus(){
        let request = NSURLRequest(URL: NSURL(string: "http://shuttletracker.hostei.com/?bus=1&latest=1")!)
        let loader = NSURLConnection(request: request, delegate: self, startImmediately: true)

    }
    
    func connection(connection: NSURLConnection!, didReceiveData conData: NSData!) {
        //if conData = '}'
        self.bytes?.appendData(conData)
    }
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        self.bytes = NSMutableData()
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        
        // we serialize our bytes back to the original JSON structure
        //println("Check this : \(bytes)")
        //bytes?.resetBytesInRange(NSMakeRange(87, 150))
        //println("Check this again : \(bytes)")
        
        var jsonResult : Dictionary = NSJSONSerialization.JSONObjectWithData(self.bytes!, options: NSJSONReadingOptions.MutableContainers, error: nil) as! Dictionary<String, AnyObject>
        
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
