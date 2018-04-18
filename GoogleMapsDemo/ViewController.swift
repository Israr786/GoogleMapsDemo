//
//  ViewController.swift
//  GoogleMapsDemo
//
//  Created by Apple on 4/18/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import GoogleMaps

class VacationDestination: NSObject {
    let name :String?
    let location:CLLocationCoordinate2D
    let zoom :Float
    
    init(name: String, location: CLLocationCoordinate2D, zoom: Float) {
        self.name = name
        self.location = location
        self.zoom = zoom
    }
    
}


class ViewController: UIViewController {

    var mapView:GMSMapView?
    var currentDestination : VacationDestination?
    let destinations = [VacationDestination.init(name: "Embarcadero Station", location: CLLocationCoordinate2DMake(37.793249, -122.396740), zoom: 15),VacationDestination.init(name:"Ferry Building MArket Place", location: CLLocationCoordinate2DMake(37.795532, -122.393451), zoom: 15)]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GMSServices.provideAPIKey("AIzaSyBTZ15049TxeuoS4RPoHnELliTHKaU8mdA")
        let camera = GMSCameraPosition.camera(withLatitude: 37.621007, longitude: -122.377754, zoom: 12)
        
         mapView = GMSMapView.map(withFrame:.zero, camera: camera)
        view = mapView
        let currentLocation = CLLocationCoordinate2DMake(37.621007, -122.377754)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "SFO Airport"
        marker.map = mapView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Next", style: .plain, target: self, action:#selector(nexts))
    
        
    }
    
  @objc func nexts() {
    
    if currentDestination == nil {
        currentDestination = destinations.first
    }else {
        if let index = destinations.index(of: currentDestination!){
            currentDestination = destinations[index + 1]
        }
    }
    
    setMapCemara()
}
    
    
    private func setMapCemara() {
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        mapView?.animate(to: GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom: currentDestination!.zoom))
        CATransaction.commit()
        
        let marker = GMSMarker(position: (currentDestination?.location)!)
        marker.title = currentDestination?.name
        marker.map = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

