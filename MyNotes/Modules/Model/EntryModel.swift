//
//  EntryModel.swift
//  MyNotes
//
//  Created by rau4o on 6/17/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit
import RealmSwift
import MapKit
import Toucan

class EntryModel: Object {
    
    @objc dynamic var text = ""
    @objc dynamic var date = Date()
    let pictures = List<Picture>()
//    let coordinates = List<Location>()
    
    func datePrettyString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d, yyyy"
        return formatter.string(from: date)
    }
    func monthPrettyString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: date)
    }
    func dayPrettyString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    func yearPrettyString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: date)
    }
    func monthYearPrettyString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: date)
    }
}

//class Location: Object {
//    @objc dynamic var longitude = 0.0
//    @objc dynamic var latitude = 0.0
//    @objc dynamic var entry: EntryModel?
//
//    var coordinate: CLLocationCoordinate2D {
//        return CLLocationCoordinate2D(
//            latitude: latitude,
//            longitude: longitude)
//    }
//    convenience init(long: Double, lat: Double) {
//        self.init()
//        longitude = long
//        latitude = lat
//    }
//}

class Picture: Object {
    
    @objc dynamic var fullImageName = ""
    @objc dynamic var thumbnailImage = ""
    @objc dynamic var entry: EntryModel?
    
    convenience init(image: UIImage) {
        self.init()
        fullImageName = imageToUrlString(image: image)
        if let smallImage = Toucan(image: image).resize(CGSize(width: 500, height: 500), fitMode: .crop).image {
            thumbnailImage = imageToUrlString(image: smallImage)
        }
    }
    
    func fullImage() -> UIImage {
        return imageWithFilename(filename: fullImageName)
    }
    
    func thumbnail() -> UIImage {
        return imageWithFilename(filename: thumbnailImage)
    }
    
    func imageWithFilename(filename: String) -> UIImage {
        var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        path.appendPathComponent(filename)
        if let imageData = try? Data(contentsOf: path) {
            if let image = UIImage(data: imageData) {
                return image
            }
        }
        return UIImage()
    }
    
    func imageToUrlString(image: UIImage) -> String {
        if let imageData = image.pngData() {
            let filename = UUID().uuidString + ".png"
            var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            path.appendPathComponent(filename)
            try? imageData.write(to: path)
            return filename
        }
        return ""
    }
}
