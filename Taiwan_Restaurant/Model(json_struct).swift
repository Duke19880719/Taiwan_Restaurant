//
//  json_struct.swift
//  Taiwan_Restaurant
//
//  Created by 江培瑋 on 2022/8/3.
//

import Foundation
import UIKit

//source: restaurant online json source
struct decode_restaurant_json_struct:Codable{
    let XML_Head:xml_head_struct

}
struct xml_head_struct:Codable{
    let Updatetime:Date
    let Infos:Infos_struct
 
}
struct Infos_struct:Codable{
    var Info:[Info_struct]
  
}
struct Info_struct:Codable{
    var Name:String?
    let Description:String?
    let Add: String?
    let Zipcode: String?
    let Region: String?
    let Town: String?
    let Tel: String?
    let Opentime: String?
    let Website: String?
    let Picture1: String?
    let Picdescribe1: String?
    let Picture2: String?
    let Picdescribe2: String?
    let Picture3: String?
    let Picdescribe3: String?
    let Px: Double?
    let Py: Double?
//        let Class: String?
    let Map: String?
    let Parkinginfo: String?
    let id = UUID()

}

//source: taiwan city data offline assets json source

struct city:Codable{
    let districts:[districts]
    let name:String
}

struct districts:Codable{
   
    let name:String
}

extension city {
    static var data: [Self] {
        var districtData = [Self]()
        if let data = NSDataAsset(name: "taiwan_districts")?.data {
            do {
                districtData = try JSONDecoder().decode([Self].self, from: data)
            } catch {
                print(error)
            }
            
        }
        return districtData
    }
}
