//
//  select_view.swift
//  Taiwan_Restaurant
//
//  Created by 江培瑋 on 2022/12/12.
//

import SwiftUI

struct select_view: View {
    @Binding var search_bar_keyword:String
    @Binding var DistrictData:[String]
    @Binding var selectedIndex_picker_city:Int
    @Binding var selectedIndex_picker_town:Int
    @Binding var onchange_check:Bool
    @Binding var appear_check:Bool
//    let city_data = city.data
    
    @Binding var json_data_sort_complete:[Info_struct]
    @Binding var json_data:decode_restaurant_json_struct?
    
    @Binding var check_web_infomation:Bool
    @Binding var check_park_infomation:Bool
    
    @Binding var check_select_complete:Bool
    
    @Binding var select_picker_city_string:String
    @Binding var select_picker_city_town_string:String
    
    @Binding var city_data:[city]
    
    var body: some View {
        Form{
               Section(header:  Text("篩選條件")
                   .fontWeight(.heavy)
                   .font(.title))
               {
                   VStack {
                       Spacer(minLength: 15)
                       
                       TextField( "", text:$search_bar_keyword )
                           .placeholder(when:search_bar_keyword.isEmpty) {
                               Text("輸入關鍵字搜尋")
                                   .fontWeight(.black)
                                   .foregroundColor(.gray)
                                   .font(.system(size: 20))
                           }
                           .padding(10)
                           .padding(.horizontal, 35)
                           .background(.white)
                           .cornerRadius(8)
                           .padding(.horizontal, 5)
                           .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
                           .keyboardType(.default)
                           .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 25))
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)
                                
                                if search_bar_keyword != "" {
                                    
                                    Button(action: {
                                        self.search_bar_keyword = ""
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    }) {
                                        Image(systemName: "multiply.circle.fill")
                                            .font(.system(size: 25))
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    }
                                }
                            }
                           )
                       
                       Spacer(minLength: 35)
                       Picker(selection: $selectedIndex_picker_city) {
                           

                           ForEach(0..<city_data.count,id: \.self) { item in
                               Text(city_data[item].name)
                                   .fontWeight(.black)
                                   .foregroundColor(.gray)
                                   .font(.system(size: 25))
//                                   .tag(item)
                               
                               
                           }
                           
                       } label: {
                           Text("選擇縣市")
                               .fontWeight(.black)
                               .foregroundColor(.gray)
                               .font(.system(size: 20))
                           
                           
                       }
                       .padding(7)
                       .pickerStyle(MenuPickerStyle())
                       .background(Color.white)
                       .cornerRadius(8)
                       .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
                       .onChange(of: selectedIndex_picker_city) { v in
                           onchange_check = true
                           select_picker_city_string = city_data[v].name
                           
                           for index in 0..<city_data.count{
                               
                               if v == index{
                                   self.DistrictData.removeAll()
                                   
                                   for index_town in 0..<city_data[index].districts.count{
                                       self.DistrictData.append(city_data[index].districts[index_town].name)
                                   }
                                   
                               }
                           }
                           
                       }
                       
                       Spacer(minLength: 35)
                       Picker(selection: $selectedIndex_picker_town) {
                           

                           ForEach(0..<DistrictData.count,id: \.self) { item in
                               
                               Text(DistrictData[item])
                                   .fontWeight(.heavy)
                                   .foregroundColor(.gray)
                                   .font(.system(size: 25))
//                                   .tag(item)
                           }
                           
                           
                       } label: {
                           Text("選擇區鄉鎮")
                               .fontWeight(.black)
                               .foregroundColor(.gray)
                               .font(.system(size: 20))
                       }
                       .pickerStyle(MenuPickerStyle())
                       .padding(7)
                       //                                       .pickerStyle(.automatic)
                       .background(Color.white)
                       .cornerRadius(8)
                       .shadow(color: .black, radius: 1, x: 0.5, y: 0.5)
                       .onChange(of: selectedIndex_picker_town) { v in
                           select_picker_city_town_string = DistrictData[v]
                       }
                       
                   }
                   VStack{
                       Spacer(minLength: 30)
                      
                       Toggle(isOn: $check_web_infomation) {
                           HStack{
                               Text("網站資訊")
                                   .fontWeight(.black)
                                   .foregroundColor(.gray)
                                   .font(.system(size: 20))
                               
                               Image(systemName: "network")
                                   .foregroundColor(check_web_infomation ? .blue  : .gray)
                                   .font(.system(size: 25, weight: .black, design: .rounded))
                         
                           }
                       }.padding()
                       
                       Spacer(minLength: 30)
                      
                       Toggle(isOn: $check_park_infomation) {
                           HStack{
                               Text("停車資訊")
                                   .fontWeight(.black)
                                   .foregroundColor(.gray)
                                   .font(.system(size: 20))
                    
                               
                               Image(systemName: "car")
                                   .foregroundColor(check_park_infomation ? .blue  : .gray)
                                   .font(.system(size: 25, weight: .black, design: .rounded))
                         
                           }
                       }.padding()
                       
                       Spacer(minLength: 30)
                       
                       Button {
                           check_select_complete = true
                           json_data_sort_complete.removeAll()


                               for index in  0..<json_data!.XML_Head.Infos.Info.count{
                                   // text != "" ,key word value
                                   if search_bar_keyword != "" && json_data!.XML_Head.Infos.Info[index].Name!.contains(search_bar_keyword)
                                   {
                                       //picker string value
                                       if json_data!.XML_Head.Infos.Info[index].Add!.contains(select_picker_city_string) &&
                                            json_data!.XML_Head.Infos.Info[index].Add!.contains(select_picker_city_town_string){
                                           
                                           //web bool true,web string value
                                           if check_web_infomation == true && json_data!.XML_Head.Infos.Info[index].Website != ""{
                                               
                                               //park bool true,park string value
                                               if check_park_infomation == true && json_data!.XML_Head.Infos.Info[index].Parkinginfo != ""{
                                                   
                                                   
                                                   json_data_sort_complete.append(json_data!.XML_Head.Infos.Info[index])
                                                   
                                               }
                                               //park bool false,park string no value
                                               else if check_park_infomation == false && json_data!.XML_Head.Infos.Info[index].Parkinginfo == ""{
                                                   
                                                   json_data_sort_complete.append(json_data!.XML_Head.Infos.Info[index])
                                               }
                                               
                                               
                                           }
                                           //web bool false,web string no value
                                           else if check_web_infomation == false && json_data!.XML_Head.Infos.Info[index].Website == ""{
                                               
                                               //park bool true,park string value
                                               if check_park_infomation == true && json_data!.XML_Head.Infos.Info[index].Parkinginfo != ""{
                                                   
                                                   
                                                   json_data_sort_complete.append(json_data!.XML_Head.Infos.Info[index])
                                                   
                                               }
                                               //park bool false,park string no value
                                               else if check_park_infomation == false && json_data!.XML_Head.Infos.Info[index].Parkinginfo == ""{
                                                   
                                                   json_data_sort_complete.append(json_data!.XML_Head.Infos.Info[index])
                                               }
                                           }
                                       }
                                       
                                       //picker string no value
                                       else if select_picker_city_string == "" && select_picker_city_town_string == "" {
                                           
                                           //web bool true,web string value
                                           if check_web_infomation == true && json_data!.XML_Head.Infos.Info[index].Website != ""{
                                               
                                               //park bool true,park string value
                                               if check_park_infomation == true && json_data!.XML_Head.Infos.Info[index].Parkinginfo != ""{
                                                   
                                                   
                                                   json_data_sort_complete.append(json_data!.XML_Head.Infos.Info[index])
                                                   
                                               }
                                               //park bool false,park string no value
                                               else if check_park_infomation == false && json_data!.XML_Head.Infos.Info[index].Parkinginfo == ""{
                                                   
                                                   json_data_sort_complete.append(json_data!.XML_Head.Infos.Info[index])
                                               }
                                               
                                               
                                           }
                                           //web bool false,web string no value
                                           else if check_web_infomation == false && json_data!.XML_Head.Infos.Info[index].Website == ""{
                                               
                                               //park bool true,park string value
                                               if check_park_infomation == true && json_data!.XML_Head.Infos.Info[index].Parkinginfo != ""{
                                                   
                                                   
                                                   json_data_sort_complete.append(json_data!.XML_Head.Infos.Info[index])
                                                   
                                               }
                                               //park bool false,park string no value
                                               else if check_park_infomation == false && json_data!.XML_Head.Infos.Info[index].Parkinginfo == ""{
                                                   
                                                   json_data_sort_complete.append(json_data!.XML_Head.Infos.Info[index])
                                               }
                                           }
                                       }
//
                                   }
                                   // text == "" ,key word no value
                                   else if search_bar_keyword == "" {
                                       
                                       //picker string value
                                       if json_data!.XML_Head.Infos.Info[index].Add!.contains(select_picker_city_string) &&
                                            json_data!.XML_Head.Infos.Info[index].Add!.contains(select_picker_city_town_string){
                                           
                                           //web bool true,web string value
                                           if check_web_infomation == true && json_data!.XML_Head.Infos.Info[index].Website != ""{
                                               
                                               //park bool true,park string value
                                               if check_park_infomation == true && json_data!.XML_Head.Infos.Info[index].Parkinginfo != ""{
                                                   
                                                   
                                                   json_data_sort_complete.append(json_data!.XML_Head.Infos.Info[index])
                                                   
                                               }
                                               //park bool false,park string no value
                                               else if check_park_infomation == false && json_data!.XML_Head.Infos.Info[index].Parkinginfo == ""{
                                                   
                                                   json_data_sort_complete.append(json_data!.XML_Head.Infos.Info[index])
                                               }
                                               
                                               
                                           }
                                           //web bool false,web string no value
                                           else if check_web_infomation == false && json_data!.XML_Head.Infos.Info[index].Website == ""{
                                               
                                               //park bool true,park string value
                                               if check_park_infomation == true && json_data!.XML_Head.Infos.Info[index].Parkinginfo != ""{
                                                   
                                                   
                                                   json_data_sort_complete.append(json_data!.XML_Head.Infos.Info[index])
                                                   
                                               }
                                               //park bool false,park string no value
                                               else if check_park_infomation == false && json_data!.XML_Head.Infos.Info[index].Parkinginfo == ""{
                                                   
                                                   json_data_sort_complete.append(json_data!.XML_Head.Infos.Info[index])
                                               }
                                           }
                                       }
                                       
                                       //picker string no value
                                       else if select_picker_city_string == "" && select_picker_city_town_string == "" {
                                           
                                           //web bool true,web string value
                                           if check_web_infomation == true && json_data!.XML_Head.Infos.Info[index].Website != ""{
                                               
                                               //park bool true,park string value
                                               if check_park_infomation == true && json_data!.XML_Head.Infos.Info[index].Parkinginfo != ""{
                                                   
                                                   
                                                   json_data_sort_complete.append(json_data!.XML_Head.Infos.Info[index])
                                                   
                                               }
                                               //park bool false,park string no value
                                               else if check_park_infomation == false && json_data!.XML_Head.Infos.Info[index].Parkinginfo == ""{
                                                   
                                                   json_data_sort_complete.append(json_data!.XML_Head.Infos.Info[index])
                                               }
                                               
                                               
                                           }
                                           //web bool false,web string no value
                                           else if check_web_infomation == false && json_data!.XML_Head.Infos.Info[index].Website == ""{
                                               
                                               //park bool true,park string value
                                               if check_park_infomation == true && json_data!.XML_Head.Infos.Info[index].Parkinginfo != ""{
                                                   
                                                   
                                                   json_data_sort_complete.append(json_data!.XML_Head.Infos.Info[index])
                                                   
                                               }
                                               //park bool false,park string no value
                                               else if check_park_infomation == false && json_data!.XML_Head.Infos.Info[index].Parkinginfo == ""{
                                                   
                                                   json_data_sort_complete.append(json_data!.XML_Head.Infos.Info[index])
                                               }
                                           }
                                       }
                                   }
                                   
                               }
                           print("1: \(json_data_sort_complete)")
                           
                       } label: {
                           HStack{
                               Text("顯示搜尋結果頁面")
                                   .fontWeight(.bold)
                                   .fontWeight(.black)
                                   .foregroundColor(.gray)
                                   .font(.system(size: 20))
//
                               Image(systemName: "doc.text.magnifyingglass")
                                   .foregroundColor( .gray)
                                   .font(.system(size: 25, weight: .black, design: .rounded))
                           }
                          .font(.title)
                          .foregroundColor(.gray)
                          .padding()
                          .overlay(
                              RoundedRectangle(cornerRadius: 20)
                                  .stroke(Color.white, lineWidth: 5)
                                  .shadow(color: .black, radius: 1, x: 0.25, y: 0.25)

                          )
                          
                       }.buttonStyle(BorderlessButtonStyle())
                   }

                     
                   
               }
                .listRowBackground(Color.clear)

            }
    }
}

//struct select_view_Previews: PreviewProvider {
//    static var previews: some View {
//        select_view()
//    }
//}
