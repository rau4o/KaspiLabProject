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
import AnchoredBottomSheet

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
}

// MARK: - MapViewPlusDelegate

extension MapController: MapViewPlusDelegate {
    
    func mapView(_ mapView: MapViewPlus, imageFor annotation: AnnotationPlus) -> UIImage {
        return #imageLiteral(resourceName: "PlaceholderDark")
    }
    
    func mapView(_ mapView: MapViewPlus, calloutViewFor annotationView: AnnotationViewPlus) -> CalloutViewPlus{
        let calloutView = MapViewPlusTemplateHelper.defaultCalloutView
        mapView.calloutViewCustomizerDelegate = calloutView
        mapView.anchorViewCustomizerDelegate = calloutView
        calloutView.delegate = self
        
        return calloutView
    }
    
    func mapView(_ mapView: MapViewPlus, didAddAnnotations annotations: [AnnotationPlus]) {
        mapView.showAnnotations(annotations, animated: true)
    }
}

// MARK: - DefaultCalloutViewDelegate

extension MapController: DefaultCalloutViewDelegate {
    func buttonDetailTapped(with viewModel: DefaultCalloutViewModelProtocol, buttonType: DefaultCalloutViewButtonType) {
        presentModalWithStackView()
    }
}

// MARK: - BottomSheetViewControllerDelegate

extension MapController: BottomSheetViewControllerDelegate {
    func didDismiss() {
        print("dismissed")
    }
}

