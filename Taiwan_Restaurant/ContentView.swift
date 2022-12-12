//
//  ContentView.swift
//  Taiwan_Restaurant
//
//  Created by 江培瑋 on 2022/8/3.
//
//-----------------------------------------------------

//preview bug:Cannot preview in this file - Timed out waiting for connection to DTServiceHub after 15.0 seconds.

//解決方法： 開啟舊往的檔案，再重新run preview again

//-----------------------------------------------------

//api : https://media.taiwan.net.tw/XMLReleaseALL_public/restaurant_C_f.json

//-----------------------------------------------------

//在swiftui 處理兩個picker 的連動上，切換動態改變顯示內容，會發生 index 數量不一致，造成程式崩潰，在foreach中使用id ，不同id 會有不同的view，可以創造一個新的view，解決此問題.

//網路上提供的解法，在foreach {}後加上id()修飾符，無法解決問題，順利可以順利運行，但是子picker的欄位數顯示錯誤

//-----------------------------------------------------

//picker overlapping problem

//.pickerStyle 選用自動的情況，會出現 overlapping problem，點取out side space 會觸發picker action，網路現在所有的方法都只適用１５.0以下的版本，還未有好的解決方法，我是偶然使用menu style，才發現沒有出現此問題

//-----------------------------------------------------

//當表單行包含接受點選手勢的檢視（如按鈕）時，它們的行為會有所不同。 當該行包含一個按鈕時，當用戶點選該按鈕時，同一行中的其他所有內容也會收到點選手勢。
//解決方法1: button 加上.buttonStyle(BorderlessButtonStyle()),BorderlessButtonStyle:不應用邊框的按鈕樣式。
//解決方法2: So when the Button is in a Form, you need to put the code into an .onTapGesture handler, but if the Button is outside a Form, you need the code in the action: handler.

//-----------------------------------------------------
//舉例： 澎湖白沙 新北新店

import SwiftUI

struct ContentView: View {
    
    @State var show_animation_close:Bool = false
    
//    @State var json_data:decode_restaurant_json_struct?
//    @State var json_data_sort_complete:[Info_struct] = []
    
    @State var check_top_vstack:Bool = true
    @State var check_select_complete:Bool = false
    
    @State var search_bar_keyword:String = ""

//    @State var DistrictData:[String] = []
    @State var selectedIndex_picker_city = 0
    @State var selectedIndex_picker_town = 0
    @State var onchange_check:Bool = false
    @State var appear_check:Bool = false
//    let city_data = city.data
    
    @State var check_web_infomation:Bool = false
    @State var check_park_infomation:Bool = false
    @State var check_back_view_button_display:Bool = false

    @State var select_picker_city_string:String = ""
    @State var select_picker_city_town_string:String = ""
    
    @StateObject var fooddie_view_model:Restaurant_ViewModel = Restaurant_ViewModel()
    
    
    
    var body: some View {
    
        VStack{
            if fooddie_view_model.json_data != nil{
                
                if check_top_vstack{
                    
                    top_view(check_top_vstack: $check_top_vstack, json_data_sort_complete: $fooddie_view_model.json_data_sort_complete, json_data: $fooddie_view_model.json_data, check_select_complete: $check_select_complete)
                        .animation(.spring(response: 0.5, dampingFraction: 0.25, blendDuration: 0.5), value: check_top_vstack)
                        .transition(.move(edge: .top))
                   
                }
                   
                if check_select_complete{
                    ZStack {
                        NavigationView {
                            List{
                                Section(header: Text("Restaurants").fontWeight(.heavy).font(.title3))
                                {

                                    ForEach(fooddie_view_model.json_data_sort_complete, id: \.id)
                                    { item in

                                        ZStack{
                                            ListView(data: item)
                                            NavigationLink {

                                                Restaurant_Information(receive_data: item)
                                                    .onAppear{
                                                        check_top_vstack = false
                                                        check_back_view_button_display = true
                                                    }
                                                    .onDisappear{
                                                        check_top_vstack = true
                                                        check_back_view_button_display = false
                                                    }
                                            } label: {

                                            }.opacity(0)

                                        }

                                    }
                                }
                                .listRowSeparator(.hidden) //隔線隱藏
                                .listRowBackground(Color.clear) //背景透明


                            }
                            .navigationBarHidden(true)
                        }
                        
                        if check_back_view_button_display == false{
                            back_to_selectview_button(check_select_complete: $check_select_complete)
                                .animation(.easeIn(duration: 1), value: check_back_view_button_display)
                                .transition(.opacity)
                        }
                        

                    }
                   
                }

                if !check_select_complete{
               
                    select_view(search_bar_keyword: $search_bar_keyword,
                                DistrictData: $fooddie_view_model.DistrictData,
                                selectedIndex_picker_city: $selectedIndex_picker_city,
                                selectedIndex_picker_town: $selectedIndex_picker_town,
                                onchange_check: $onchange_check,
                                appear_check: $appear_check,
                                json_data_sort_complete: $fooddie_view_model.json_data_sort_complete,
                                json_data: $fooddie_view_model.json_data,
                                check_web_infomation: $check_web_infomation,
                                check_park_infomation:$check_park_infomation,
                                check_select_complete:$check_select_complete,
                                select_picker_city_string: $select_picker_city_string,
                                select_picker_city_town_string: $select_picker_city_town_string,
                                city_data: $fooddie_view_model.city_data
                    )
                   
                }
            
     
            }
            
            if show_animation_close && fooddie_view_model.json_data == nil{
                Data_Loading_Animation()
                    .task {

                        await fooddie_view_model.load_json()
                    }
            }
       
            if !show_animation_close{
                opening_animation_view()
                .onAppear {

                    DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                        show_animation_close = true

                    }
                }
            }
        }
    }

}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
extension UIPickerView {
   open override var intrinsicContentSize: CGSize {
      return CGSize(width: UIView.noIntrinsicMetric, height: super.intrinsicContentSize.height)}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
