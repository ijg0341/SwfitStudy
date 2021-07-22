//
//  ViewController.swift
//  MapView
//
//  Created by Jingyu Lim on 2021/07/22.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
     
    let segmentBar: UISegmentedControl = {
        var segment = UISegmentedControl()
        let segmentItmes = ["현재위치", "폴리텍대학", "이지스퍼블리싱", "우리집"]
        segmentItmes.enumerated().forEach { segment.insertSegment(withTitle: $1, at: $0, animated: false) }
        return segment
    }()
    
    let mapView: MKMapView = {
        var mapView = MKMapView()
        mapView.showsUserLocation = true
        return mapView
    }()
    
    let locationInfoLabel1 = UILabel()
    let locationInfoLabel2 = UILabel()
    
    let locationManger = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewInit()
        
        locationInfoLabel1.text = ""
        locationInfoLabel2.text = ""
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func sgChangeLocation(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        
        case 0:
            locationManger.startUpdatingLocation()
        case 1:
            setAnnotation(latitude: 37.751853, longitude: 128.87605740000004, delta: 0.1, title: "한국폴리텍대학 강릉캠퍼스", subtitle: "강원도 강릉시 남산초교길 121")
            locationInfoLabel1.text = "한국폴리텍대학 강릉캠퍼스"
            locationInfoLabel2.text = "강원도 강릉시 남산초교길 121"
        case 2:
            setAnnotation(latitude: 37.55876, longitude: 126.914066, delta: 0.1, title: "이지스퍼블리싱", subtitle: "서울시 마포구 잔다리로 109 이지스 빌딩")
            locationInfoLabel1.text = "이지스 퍼블리싱"
            locationInfoLabel2.text = "서울시 마포구 잔다리로 109 이지스 빌딩"
        case 3:
            setAnnotation(latitude: 37.5022385, longitude: 127.0485858, delta: 0.1, title: "우리집", subtitle: "서울시 강남구 선릉로76길 5-14")
            locationInfoLabel1.text = "우리집"
            locationInfoLabel2.text = "서울시 강남구 선릉로76길 5-14"
        default: break
        }
    }
    
    func viewInit(){
        view.addSubview(segmentBar)
        view.addSubview(mapView)
        locationInfoLabel1.text = "location1"
        locationInfoLabel2.text = "location2"
        
        view.addSubview(locationInfoLabel1)
        view.addSubview(locationInfoLabel2)
        
        segmentBar.addTarget(self, action: #selector(sgChangeLocation(_:)), for: .valueChanged)
        
        segmentBar.translatesAutoresizingMaskIntoConstraints = false
        segmentBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        segmentBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        segmentBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: segmentBar.bottomAnchor, constant: 10).isActive = true
        mapView.bottomAnchor.constraint(equalTo: locationInfoLabel1.topAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: segmentBar.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: segmentBar.rightAnchor).isActive = true
        
        locationInfoLabel1.translatesAutoresizingMaskIntoConstraints = false
        locationInfoLabel1.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        locationInfoLabel1.bottomAnchor.constraint(equalTo: locationInfoLabel2.topAnchor).isActive = true
        locationInfoLabel1.leftAnchor.constraint(equalTo: segmentBar.leftAnchor).isActive = true
        locationInfoLabel1.rightAnchor.constraint(equalTo: segmentBar.rightAnchor).isActive = true
        locationInfoLabel1.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        locationInfoLabel2.translatesAutoresizingMaskIntoConstraints = false
        locationInfoLabel2.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        locationInfoLabel2.leftAnchor.constraint(equalTo: segmentBar.leftAnchor).isActive = true
        locationInfoLabel2.rightAnchor.constraint(equalTo: segmentBar.rightAnchor).isActive = true
        locationInfoLabel2.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }


}

extension ViewController: CLLocationManagerDelegate{
    func goLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitude, longitude)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        mapView.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    func setAnnotation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubTitle: String){
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitude: latitude, longitude: longitude, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubTitle
        mapView.addAnnotation(annotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let pLocation = locations.last else {
            return
        }
        
        _ = goLocation(latitude: pLocation.coordinate.latitude, longitude: pLocation.coordinate.longitude, delta: 0.01)
        
        CLGeocoder().reverseGeocodeLocation(pLocation) { placemarks, Error in
            guard let pm = placemarks?.first else { return }
            guard let country = pm.country else { return }
            
            var address:String = country
            
            if let locality = pm.locality {
                address += " \(locality)"
            }
            
            if let thoroughfare = pm.thoroughfare{
                address += " \(thoroughfare)"
            }
            
            self.locationInfoLabel1.text = "현재 위치"
            self.locationInfoLabel2.text = address
        }
    
        locationManger.stopUpdatingLocation()
    }
}
