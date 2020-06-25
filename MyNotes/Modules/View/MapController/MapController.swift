//
//  MapController.swift
//  MyNotes
//
//  Created by rau4o on 6/19/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit
import MapKit
import MapViewPlus
import CoreLocation

class MapController: UIViewController {
    
    // MARK: - Properties
    
    lazy var mapView: MapViewPlus = {
        let map = MapViewPlus()
        map.delegate = self
        return map
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        let annotations = [AnnotationPlus.init(viewModel: DefaultCalloutViewModel.init(title: "example", subtitle: "43 tam", imageType: .fromBundle(image: #imageLiteral(resourceName: "appImage")), theme: .light, detailButtonType: .info), coordinate: CLLocationCoordinate2DMake(50.85, 5.35))]
        mapView.setup(withAnnotations: annotations)
    }
    
    // MARK: - Helper function
    
    private func configureUI() {
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - MapViewPlusDelegate

extension MapController: MapViewPlusDelegate {
    
    func mapView(_ mapView: MapViewPlus, imageFor annotation: AnnotationPlus) -> UIImage {
        return #imageLiteral(resourceName: "PlaceholderDark")
    }
    
    func mapView(_ mapView: MapViewPlus, calloutViewFor annotationView: AnnotationViewPlus) -> CalloutViewPlus{
        let calloutView = MapViewPlusTemplateHelper.defaultCalloutView
        
        // Below two are:
        // Required if DefaultCalloutView is being used
        // Optional if you are using your own callout view
        mapView.calloutViewCustomizerDelegate = calloutView
        mapView.anchorViewCustomizerDelegate = calloutView
        
        //Optional. Conform to this if you want button click delegate method to be called.
        calloutView.delegate = self
        
        return calloutView
    }
    
    // Optional
    func mapView(_ mapView: MapViewPlus, didAddAnnotations annotations: [AnnotationPlus]) {
        mapView.showAnnotations(annotations, animated: true)
    }
    
    // Optional. Just to show that delegate forwarding is actually working.
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("This method is being forwarded to you by MapViewPlusDelegate")
    }
}

// MARK: - DefaultCalloutViewDelegate

extension MapController: DefaultCalloutViewDelegate {
    func buttonDetailTapped(with viewModel: DefaultCalloutViewModelProtocol, buttonType: DefaultCalloutViewButtonType) {
        let alert = UIAlertController(title: buttonType == .background ? "Background Tapped" : "Detail Button Tapped", message: viewModel.title + "  " + (viewModel.subtitle ?? ""), preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(confirmAction)
        self.present(alert, animated: true, completion: nil)
    }
}

