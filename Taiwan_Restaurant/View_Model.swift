//
//  view_model.swift
//  Taiwan_Restaurant
//
//  Created by 江培瑋 on 2022/12/8.
//

import Foundation

class Restaurant_ViewModel:ObservableObject{
    @Published var json_data:decode_restaurant_json_struct?
    @Published var json_data_sort_complete:[Info_struct] = []
    
    @Published var city_data:[city]

    @Published var DistrictData:[String] = []
    
    
    init(){
         city_data = city.data
    }
    
    func load_json() async{
        debugPrint("load_json")
        
        var request = URLRequest(url: URL(string: "https://media.taiwan.net.tw/XMLReleaseALL_public/restaurant_C_f.json")!)
        
        request.httpMethod = "GET"

        let task =  URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is (httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            if data.isEmpty != true{
                let json_decoder = JSONDecoder()
                json_decoder.dateDecodingStrategy = .iso8601
                
                DispatchQueue.main.async{
                    do{
                        let decode_data = try json_decoder.decode(decode_restaurant_json_struct.self, from: data)
                        
                        self.json_data = decode_data
                        
                    }
                    catch{
                        print("\(String(describing: error))" )
                    }
                }
     
            }
        }.resume()
    }
}
