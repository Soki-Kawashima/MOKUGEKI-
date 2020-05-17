//
//  ViewController.swift
//  MOKUGEKI!!
//
//  Created by 川島壮生 on 2020/05/15.
//  Copyright © 2020 川島壮生. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate{
    var myLock = NSLock()
    let goldenRatio = 1.618
    
    @IBOutlet var mapView: MKMapView!
    var locationManager: CLLocationManager!

    @IBAction func clickZoomin(_ sender: Any) {
        print("[DBG]clickZoomin")
        myLock.lock()
        if (0.005 < mapView.region.span.latitudeDelta / goldenRatio) {
            print("[DBG]latitudeDelta-1 : " + mapView.region.span.latitudeDelta.description)
            var regionSpan:MKCoordinateSpan = MKCoordinateSpan()
            regionSpan.latitudeDelta = mapView.region.span.latitudeDelta / goldenRatio
                mapView.region.span = regionSpan
                print("[DBG]latitudeDelta-2 : " + mapView.region.span.latitudeDelta.description)
            }
            myLock.unlock()
            
    }
    @IBAction func clickZoomout(_ sender: Any) {
        print("[DBG]clickzoomout")
        myLock.lock()
        if (mapView.region.span.latitudeDelta * goldenRatio < 150.0) {
            print("[DBG]latitudeDelta-1 : " + mapView.region.span.latitudeDelta.description)
            var regionSpan:MKCoordinateSpan = MKCoordinateSpan()
            regionSpan.latitudeDelta = mapView.region.span.latitudeDelta * goldenRatio
            mapView.region.span = regionSpan
            print("[DBG]latitudeDelta-2 : " + mapView.region.span.latitudeDelta.description)
        }
        myLock.unlock()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
    let longitude = (locations.last?.coordinate.longitude.description)!
    let latitude = (locations.last?.coordinate.latitude.description)!
    print("[DBG]longitude : " + longitude)
    print("[DBG]latitude : " + latitude)
    mapView.setCenter((locations.last?.coordinate)!, animated: true)
}

}
