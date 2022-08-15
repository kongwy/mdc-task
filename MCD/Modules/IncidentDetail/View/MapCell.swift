//
//  MapCell.swift
//  MCD
//
//  Created by Weiyi Kong on 16/8/2022.
//

import UIKit
import MapKit
import CoreLocation
import SnapKit
import Kingfisher

class MapCell: UITableViewCell {
    lazy var mapView = MKMapView()
    lazy var annotationView = MKAnnotationView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setup() {
        mapView.delegate = self
        contentView.addSubview(mapView)
    }

    func layout() {
        mapView.snp.makeConstraints { make in
            make.height.equalTo(312)
            make.top.bottom.left.right.equalToSuperview()
        }
    }

    func update(coordinate: CLLocationCoordinate2D?, icon: URL?) {
        if let coordinate = coordinate {
            if !mapView.annotations.isEmpty { mapView.removeAnnotations(mapView.annotations) }
            mapView.setRegion(MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500), animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
        }
        if let icon = icon {
            ImageDownloader.default.downloadImage(with: icon) { [weak self] result in
                switch result {
                case .success(let value):
                    var image: UIImage? = value.image
                    image = BlendImageProcessor(blendMode: .normal, alpha: 1.0, backgroundColor: .systemGray6)
                        .process(item: .image(image!), options: KingfisherParsedOptionsInfo(nil))
                    image = RoundCornerImageProcessor(cornerRadius: image!.size.width / 2)
                        .process(item: .image(image!), options: KingfisherParsedOptionsInfo(nil))
                    self?.annotationView.image = image?.resize(to: CGSize(width: 32, height: 32))
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }
    }
}

extension MapCell: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return annotationView
    }
}
