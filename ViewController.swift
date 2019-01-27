//
//  ViewController.swift
//  Journal2.0
//
//  Created by Noam Cohen on 2019-01-26.
//  Copyright © 2019 Noam Cohen. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

public var fullStrArr:[String]=[]
class ViewController: UIViewController, CLLocationManagerDelegate {
    var word:String="hello world"
    
    let locationManager = CLLocationManager()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate=self
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
         let fileName = "data1"
         let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
         
         let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
         let fileURLProject = Bundle.main.path(forResource: "data1", ofType: "txt")
         // Read from the file
         var readStringProject = ""
         do {
         readStringProject = try String(contentsOfFile: fileURLProject!, encoding: String.Encoding.utf8)
         } catch let error as NSError {
         print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
         }
         fullStrArr = readStringProject.split{$0 == "\n"}.map(String.init)
        
    }
    @IBAction func button(_ sender: Any) {
        locationManager.requestLocation()
        let alertController = UIAlertController(title: "Welcome to My First App", message: "\(word)", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lat = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude {
            let plays=findPlays(radius:500000,lat:lat,lon:long,file:fullStrArr)
            word="\(lat),  \(long) :"+String(plays.count)
            //print(findPlays(radius:1,lat1:lat,lon1:long,file:fullStrArr))
            if let result = mostFrequent(array: plays) {
                if(result.value != nil){
                    word = word+"    \(result.value!) occurs \(result.count) times"
                }
                if(result.value == nil){
                    word = word+"    \(result.value) occurs \(result.count) times"
                }
            }
            //print("\(lat),\(long)")
        } else {
            print("No coordinates")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    
}
 func dist(lat1:Double, lon1:Double, lat2:Double, lon2:Double) -> Double{
     let radius = 6371000
     let lat1_rad = lat1 * Double.pi / 180
     let lat2_rad = lat2 * Double.pi / 180
     let lon1_rad = lon1 * Double.pi / 180
     let lon2_rad = lon2 * Double.pi / 180
     let de_lat = lat1_rad - lat2_rad
     let de_lon = lon1_rad - lon2_rad
     let a = sin(de_lat / 2) * sin(de_lat / 2) + cos(lat1_rad) * cos(lat2_rad) * sin(de_lon / 2) * sin(de_lon / 2)
     let b = 2 * atan2(sqrt(a),sqrt(1 - a))
     let c = Double(radius) * b
     return c
 }

 func findPlays(radius:Int, lat:Double, lon:Double, file:[String])->[Int?]{
     var temp:[Int?]=[]
     for i in file{
     //print (i.split{$0 == ","}.map(String.init)[0])
     var fileLon = (i.split{$0 == ","}.map(String.init)[3])
     fileLon.removeFirst()
     let songLon = Double(fileLon)
     //print(songLat)
        
     var fileLat=(i.split{$0 == ","}.map(String.init)[4])
     fileLat.removeFirst()
     let songLat = Double(fileLat)
        if(songLat != nil){
            if (Int(dist(lat1:songLat!, lon1: songLon!, lat2:lat, lon2:lon)) < radius){
                temp.append(Int((i.split{$0 == ","}.map(String.init)[0])))
            }
        }
     
     }
     print(temp)
     return temp
 
 }
func mostFrequent<T: Hashable>(array: [T]) -> (value: T, count: Int)? {
    
    let counts = array.reduce(into: [:]) { $0[$1, default: 0] += 1 }
    if let (value, count) = counts.max(by: { $0.1 < $1.1 }) {
        return (value, count)
    }
    
    // array was empty
    return nil
}






