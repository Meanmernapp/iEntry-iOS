//
//  CompanyMapVC.swift
//  iEntry
//
//  Created by ZAFAR on 13/08/2021.
//

import UIKit
import GooglePlaces
import GoogleMaps
import CoreLocation
import MapKit

class CompanyMapVC: UIViewController,MKMapViewDelegate {
    
    //MARK: - here are the iboutlet
    
    @IBOutlet weak var lblmaptitle: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lbladdressDetail: UILabel!
    @IBOutlet weak var lbladdresstitle: UILabel!
    @IBOutlet weak var lblcompnyDetail: UILabel!
    @IBOutlet weak var lblcompany: UILabel!
    @IBOutlet weak var overMApHeight: NSLayoutConstraint!
    @IBOutlet weak var OverMapView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var stackViewForClose: UIStackView!
    @IBOutlet weak var plusBtn: UIView!
    
    var lat = ShareData.shareInfo.conractWithCompany?.company?.latitud ?? ShareData.shareInfo.headersData?.company?.latitud ?? 0.0
    var long = ShareData.shareInfo.conractWithCompany?.company?.longitud ?? ShareData.shareInfo.headersData?.company?.longitud ?? 0.0
    var companyname = ShareData.shareInfo.conractWithCompany?.company?.name ?? ShareData.shareInfo.headersData?.company?.name ?? ""
    var address = ShareData.shareInfo.conractWithCompany?.company?.address ?? ShareData.shareInfo.headersData?.company?.address ?? ""
    
    
    //MARK:- here are the Location Manager
    var location = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plusBtn.isHidden = true
        navigationBarHidShow(isTrue: true)
        stackViewForClose.roundViewWithCustomRadius(radius: 10)
        self.lblcompnyDetail.text = companyname
        self.lbladdressDetail.text = address
        self.lblmaptitle.text = "M A P A".localized
        self.lblcompany.text = "COMPAÑIA".localized
        self.lbladdresstitle.text = "DIRECCIÓN".localized
        conFigMap()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.animateView))
        stackViewForClose.addGestureRecognizer(tap)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        plusBtn.isHidden = true
    }
    
    @objc func animateView() {
        
        if overMApHeight.constant == 0 {
                    
                    
                    overMApHeight.priority = UILayoutPriority(rawValue: 250)
                    UIView.animate(withDuration: 0.25, animations: {
                        self.OverMapView.isHidden = false
                        self.overMApHeight.constant = 120
                        self.view.layoutIfNeeded()
                    }, completion: { _ in


                    })
                } else if overMApHeight.constant == 120 {
                    
                    overMApHeight.priority = UILayoutPriority(rawValue: 250)
                    UIView.animate(withDuration: 0.25, animations: {
                        self.OverMapView.isHidden = true
                        self.overMApHeight.constant = 0
                        self.view.layoutIfNeeded()
                    }, completion: { _ in

                        
                    })

                }
        
    }
    
    //MARK:- this funtion use to set the UI
    func conFigMap() {
        let annotation = MKPointAnnotation()
        let centerRegionCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:lat, longitude:long)
        annotation.coordinate = centerRegionCoordinate
        annotation.title = "\(companyname)"
        mapView.addAnnotation(annotation)
        mapView.setCenter(centerRegionCoordinate, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        openMapForPlace(lat: self.lat, long: self.long)
    }
    func openMapForPlace(lat:Double,long:Double) {
        
        
        let latitude:CLLocationDegrees =  lat
        let longitude:CLLocationDegrees =  long
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(self.companyname)"
        mapItem.openInMaps(launchOptions: options)
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: StoryBoards.Home.rawValue, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier:"NewHomeViewController") as? NewHomeViewController //SelectCompanyVC//CompanyVC //HomeVC///EnterEmailVC
        self.navigationController?.setViewControllers([vc!], animated: true)
    }
    
    @IBAction func optionAction(_ sender: Any) {
    }
    
    
}
