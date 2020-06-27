//
//  MapController.swift
//  MyNotes
//
//  Created by rau4o on 6/19/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit
import MapKit
import AnchoredBottomSheet
import RealmSwift

class MapController: UIViewController {
    
    // MARK: - Properties
    
    var annotationEntries: Results<EntryModel>?
    var viewModel = TableNotesViewModel()
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.delegate = self
        return map
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addAnnotation()
    }
    // MARK: - Helper function
    
    private func configureUI() {
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func presentModalWithStackView() {
        let configuration = BottomSheetViewConfiguration(contentView: UIView(),
                                                         parentViewController: self,
                                                         defaultPosition: .middle(),
                                                         positions: [.middle(), .top()],
                                                         isPullIndicatorNeeded: true,
                                                         isCloseButtonNeeded: false,
                                                         isDismissAllowed: true)
        let bottomSheetView = BottomSheetView(configuration: configuration)
        let bottomSheetViewController = BottomSheetViewController(bottomSheetView: bottomSheetView)

        bottomSheetViewController.delegate = self
        bottomSheetViewController.present(from: self)
    }
    
    private func getData() -> Results<EntryModel> {
        return RealmService.shared.realm.objects(EntryModel.self)
    }
    
    func addAnnotation() {
//        annotationEntries = getData()
//        
//        if let annotationEnumerated = annotationEntries?.enumerated() {
//            for (index, _) in annotationEnumerated {
//            let annotation = MKPointAnnotation()
//            
//            if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
//                CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
//                guard let currentLocation = locationManager.location else {
//                    return
//                }
////                guard let lat = annotationEntries?[index].coordinates[0].latitude else {return}
////                guard let long = annotationEntries?[index].coordinates[0].longitude else {return}
////                annotation.coordinate = CLLocationCoordinate2D(latitude: lat,
////                                                               longitude: long)
//                }
//                mapView.addAnnotation(annotation)
//            }
//        }
    }
}

// MARK: - MapViewPlusDelegate

extension MapController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: String(annotation.hash))
        pinView.pinTintColor = UIColor.orange
        let rightBtn = UIButton(type: .detailDisclosure)
        
        pinView.animatesDrop = true
        pinView.canShowCallout = true
        pinView.rightCalloutAccessoryView = rightBtn
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        presentModalWithStackView()
    }
}



// MARK: - BottomSheetViewControllerDelegate

extension MapController: BottomSheetViewControllerDelegate {
    func didDismiss() {
        print("dismissed")
    }
}

