//
//  LocationMapVC.swift
//  Meal_Do
//
//  Created by Dipak Kasodariya on 12/08/19.
//  Copyright © 2019 Maitree. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import KVNProgress


protocol CurrentLocationDelegate {
    func getLocation(coordinate : CLLocationCoordinate2D,name :String)
}

class LocationMapVC: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate,GMSPlacePickerViewControllerDelegate {
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    
    var marker = GMSMarker()
    var CurrentCordinate = CLLocationCoordinate2D()
    var locationManager = CLLocationManager()
    var delegate : CurrentLocationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        KVNProgress.show()
     
        
        //GMSPlacePickerViewControllerDelegate = self
      
        // Do any additional setup after loading the view.
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        let location = locations.last?.coordinate
//        CurrentCordinate = location!
//        let camera = GMSCameraPosition.camera(withLatitude: location!.latitude, longitude: location!.longitude, zoom: 15.0)
//        self.mapView.animate(to: camera)
//        self.marker.position = location!
//        self.marker.map = mapView
//        print(locations)
//
//
//    }
//
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last?.coordinate
        CurrentCordinate = location!
        print(locations.last?.coordinate)
        CLGeocoder().reverseGeocodeLocation(locations[0]) { (placeMark, error) in
            if error == nil && placeMark?.count ?? 0 > 0
            {
                if let places = placeMark{
                    print(places)
                    
                    let country = places.last?.country ?? ""
                    
                    let Pickupcity = places.last?.locality ?? ""
                    let PickupState = places.last?.administrativeArea ?? ""
                    let address = places.last?.name ?? ""
                    
                    self.locationLabel.text = address + " " + (places.last?.subLocality)! ?? ""
                    
                    
                    let camera = GMSCameraPosition.camera(withLatitude: location!.latitude, longitude: location!.longitude, zoom: 17.0)
                    self.mapView.animate(to: camera)
                    self.marker.position = location!
                    self.marker.map = self.mapView
                    
                    KVNProgress.dismiss()
                    self.locationManager.stopUpdatingLocation()
                }
                
            }
                
            else
            {
                
            }
           
        }
        
    }
    
    @IBAction func btnCancelPressed(_ sender: Any) {
        
//        let center = CLLocationCoordinate2D(latitude: CurrentCordinate.latitude, longitude: CurrentCordinate.longitude)
//        let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001,
//                                               longitude: center.longitude + 0.001)
//        let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001,
//                                               longitude: center.longitude - 0.001)
//        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
//        let config = GMSPlacePickerConfig(viewport: viewport)
//
//        //let config = GMSPlacePickerConfig(viewport: nil)
//        let placePicker = GMSPlacePickerViewController(config: config)
//        placePicker.delegate = self
//        present(placePicker, animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSendPressed(_ sender: Any) {
        delegate?.getLocation(coordinate: CLLocationCoordinate2D.init(latitude: CurrentCordinate.latitude, longitude: CurrentCordinate.longitude), name: locationLabel.text!)
        self.dismiss(animated: true, completion: nil)
      
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        print("Place name \(place.name)")
        print("Place address \(place.formattedAddress)")
        print("Place attributions \(place.attributions)")
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
       dismiss(animated: true, completion: nil)
        
        print("No place selected")
    }
    
}
