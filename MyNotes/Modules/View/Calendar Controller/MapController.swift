//
//  MapController.swift
//  MyNotes
//
//  Created by rau4o on 7/19/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class MapController: UIViewController {
    
    // MARK: - Properties
    
    private var entries: Results<EntryModel>?
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.entries = RealmService.shared.realm.objects(EntryModel.self).sorted(byKeyPath: "date", ascending: false)
            
        guard let entriesData = entries else {return}
        for i in entriesData {
            configureMap(with: i.address)
        }
    }
    
    // MARK: - Helper function
    
    func configureMap(with location: String) {

        let geocoder = CLGeocoder()

        geocoder.geocodeAddressString(location) { [weak self] (placemarks, error) in
            guard let self = self else {return}
            if let error = error {
                print(error.localizedDescription)
                return
            }

            if let placemarks = placemarks {
                // Get the first placemark
                let placemark = placemarks[0]

                // Add annotation
                let annotation = MKPointAnnotation()

                if let location = placemark.location {
                    // Display the annotation
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)

                    // Set the zoom level
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }
        }
    }
}

// MARK: - SetupUI

private extension MapController {
    
    func initialSetup() {
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
