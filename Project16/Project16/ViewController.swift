//
//  ViewController.swift
//  Project16
//
//  Created by meekam okeke on 11/16/20.
//
import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate{
    @IBOutlet var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map type", style: .plain, target: self, action: #selector(changeMapType))

        
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 summer olympics.", website: "wikipedia.org/wiki/London")
        let oslo  = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "founded over a thousand years ago.", website: "wikipedia.org/wiki/Oslo" )
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the city of light.", website: "wikipedia.org/wiki/Paris")
        let rome =  Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Home to the Vatican city.", website: "wikipedia.org/wiki/Rome")
        let washington = Capital(title: "Washington", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.", website: "wikipedia.org/wiki/Washington")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else {return nil}
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.pinTintColor = .blue
        return annotationView
        
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else{return}
        
        let placeName = capital.title
        let placeInfo = capital.website
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: placeInfo, style: .default, handler: { (_) in
            if let vc = self.storyboard?.instantiateViewController(identifier: "WikiPage") as? DetailViewController{
                vc.selectedCityName = placeName
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }))
       present(ac, animated: true, completion: nil)
        
    }
    @objc func changeMapType(_ sender: UIBarButtonItem){
        
        let ac = UIAlertController(title: "Map Type", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Hybrid Flyover", style: .default, handler: hybridFlyover))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: satellite))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: hybrid))
        ac.addAction(UIAlertAction(title: "Muted Standard", style: .default, handler: mutedStandard))
        ac.addAction(UIAlertAction(title: "Satellite FLyover", style: .default, handler: satelliteFlyover))
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: standard))
        present(ac, animated: true)
    }
    func hybridFlyover(action: UIAlertAction){
        self.mapView.mapType = .hybridFlyover
    }
    func satellite(action: UIAlertAction){
        self.mapView.mapType = .satellite
    }
    func hybrid(action: UIAlertAction){
        self.mapView.mapType = .hybrid
    }
    func mutedStandard(action: UIAlertAction){
        self.mapView.mapType = .mutedStandard
    }
    func satelliteFlyover(action: UIAlertAction){
        self.mapView.mapType = .satelliteFlyover
    }
    func standard(action: UIAlertAction){
        self.mapView.mapType = .standard
    }

}

