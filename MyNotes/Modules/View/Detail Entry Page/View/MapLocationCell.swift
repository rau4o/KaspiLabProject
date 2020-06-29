//
//  MapLocationCell.swift
//  MyNotes
//
//  Created by rau4o on 6/28/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit
import MapKit

class MapLocationCell: UITableViewCell {

    // MARK: - Properties
    
    lazy private var mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper function
    
    private func configureUI() {
        addSubview(mapView)
        
        mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
//    func configure(with model: EntryModel) {
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = model.destinationCoordinates
//        self.mapView.addAnnotation(annotation)
////        self.mapView.selectAnnotation(annotation, animated: true)
//    }
//
    func configure(with location: String) {

//         Get location
        let geocoder = CLGeocoder()

        print(location)
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
