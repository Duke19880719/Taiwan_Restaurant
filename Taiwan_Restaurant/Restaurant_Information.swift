//
//  Restaurant_Information.swift
//  Taiwan_Restaurant
//
//  Created by 江培瑋 on 2022/11/1.
//

import SwiftUI
import WebKit

struct Restaurant_Information: View {
    
    @State var receive_data:Info_struct?
    @Environment(\.presentationMode) var mode
    
    
    var body: some View {
        
        VStack{

            TabView {
                
                TabView_AsyncImage(web_image_url: receive_data?.Picture1, check_image_index: "1", pic_desctiption: receive_data?.Picdescribe1 ?? "nil")
                
                TabView_AsyncImage(web_image_url: receive_data?.Picture2, check_image_index: "2", pic_desctiption: receive_data?.Picdescribe2 ?? "nil")
                
                TabView_AsyncImage(web_image_url: receive_data?.Picture3, check_image_index: "3", pic_desctiption: receive_data?.Picdescribe3 ?? "nil")
                
            }
//            .edgesIgnoringSafeArea(.top)
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame( height: UIScreen.main.bounds.height/2)
                
            ScrollView{

                Text(receive_data?.Name ?? "店名")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .padding()
                
                Spacer(minLength: 15)

                detail(title: "地址", symbol_name: "house",label_information: receive_data?.Add ,label_description: "無地址資料")
                
                detail(title: "電話", symbol_name: "phone.connection", label_information: receive_data?.Tel, label_description: "無電話資料")
                
                detail(title: "營業時間", symbol_name: "clock.badge.checkmark", label_information: receive_data?.Opentime, label_description: "無營業時間資料")
                detail(title: "網頁", symbol_name: "network", label_information:receive_data?.Website, label_description: "無網頁資料")
                detail(title: "停車資訊", symbol_name: "car", label_information: receive_data?.Parkinginfo, label_description: "無停車資訊")
                detail(title: "餐廳介紹", symbol_name: "fork.knife", label_information:receive_data?.Description, label_description: "無餐廳介紹資料")
                Spacer(minLength: 35)
        
            }
            .frame( height: UIScreen.main.bounds.height/2)
            
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            
            self.mode.wrappedValue.dismiss()
                    
        }, label: {
                    
                    Text("\(Image(systemName: "arrow.turn.up.left"))")
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .font(.system(size: 20))
                .shadow(color: .black, radius: 0.5, x: 1, y: 1)
                    
        }))
        


    }
}


struct detail:View{
    
    var title:String
    var symbol_name:String
    
    var label_information:String?
    var label_description:String
    
    @State var check_url_button_click:Bool = false
    
    var body: some View {
        HStack{
            Text(title)
                .font(.system(.title2, design: .rounded))
                .frame(alignment: .leading)
                .padding(.leading)
      
            Image(systemName: symbol_name)
                .font(.system(.title2, design: .rounded))
                .frame(alignment: .leading)
                .padding(.leading,-5)
            Spacer()
        }
        Spacer(minLength: 10)
        if (title == "網頁" && label_information != nil && label_information != "" ){
            
            Button {
//                print("web_url: \(label_information)")
                check_url_button_click = true
            } label: {
                Text( "\t\(label_information!)")
                    .font(.system(.title2, design: .rounded))
                    .foregroundColor(Color.gray.opacity(0.65))
                    .shadow(color: .black, radius: 0.25, x: 0.5, y: 0.5)
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    .padding(.leading)
            }.sheet(isPresented: $check_url_button_click) {
             
                web_view(url: URL(string: label_information!)!)
            }
            
//            Link(destination: URL(string: "https://ithelp.ithome.com.tw/articles/10227071")!) {
//                Text( "\t\(web_url)")
//                   .font(.system(.title2, design: .rounded))
//                   .foregroundColor(Color.gray.opacity(0.65))
//                   .shadow(color: .black, radius: 0.25, x: 0.5, y: 0.5)
//                   .frame(maxWidth: .infinity ,alignment: .leading)
//                   .padding(.leading)
//            }

        }
        else{
            if label_information == ""{
                Text( "\t\(label_description)")
                    .font(.system(.title2, design: .rounded))
                    .foregroundColor(Color.gray.opacity(0.65))
                    .shadow(color: .black, radius: 0.25, x: 0.5, y: 0.5)
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    .padding(.leading)
            }
            else{
                Text( "\t\(label_information ?? "\(label_description)")")
                    .lineSpacing(10)
                    .font(.system(.title2, design: .rounded))
                    .foregroundColor(Color.gray.opacity(0.65))
                    .shadow(color: .black, radius: 0.25, x: 0.5, y: 0.5)
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    .padding(.leading)
            }
      
        }

        
        Spacer(minLength: 15)
    }
}


struct web_view:UIViewRepresentable{
     var url: URL

      func makeUIView(context: Context) -> WKWebView {
          return WKWebView()
      }

      func updateUIView(_ webView: WKWebView, context: Context) {
          let request = URLRequest(url:  url)
          DispatchQueue.main.async {
              webView.load(request)
          }
//          webView.load(request)
      }
}

struct TabView_AsyncImage:View{
    
    var web_image_url:String?

    var check_image_index:String
    
    var pic_desctiption:String

    var image_text:String {
        get{
       
//            switch check_image_index{
//            case  "1":
//                return "圖片一"
//            case  "2":
//                return "圖片二"
//            case  "3":
//                return "圖片三"
//
//            default:
//                return "無資源，以預設圖片顯示"
//            }
            if pic_desctiption == "nil"{
                return "無圖片說明"
            }else{
                return pic_desctiption
            }
           
        }
        set{
            pic_desctiption = newValue
        }
    }
    
    var image_default_index:String {
        get{
       
            switch check_image_index{
            case  "1":
                return "default_pic1"
            case  "2":
                return "default_pic2"
            case  "3":
                return "default_pic3"
                
            default:
                return "無資源，以預設圖片顯示"
            }
           
        }
        set{
            check_image_index = newValue
        }
    }
    
    
    var body: some View {
        AsyncImage(url: URL(string: (web_image_url ?? "") ), scale: 2.0, transaction: Transaction(animation: .spring())) {
            phase  in

            if  phase.image != nil{
                
                tableview_image(image_default_index: image_default_index, asny_image: phase.image, image_text: image_text)
            

            }
            else if phase.error != nil {
     
                tableview_image(image_default_index: image_default_index, asny_image: nil)
                
            } else {
                tableview_image(image_default_index: image_default_index, asny_image: nil)
                   
            }
        }
//        .edgesIgnoringSafeArea(.top)
////        .scaledToFill()
//        .frame(width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height/2)
//        .clipped()
        
    }
}

struct tableview_image:View{
    
    var image_default_index:String
    var asny_image:Image?
    var image_text:String = ""
    
    var body: some View{
        
        
        if let image = asny_image,image_text != ""{
            image
                .resizable()
//                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height/2)
                .clipped()
                .overlay {
                    VStack{
                        HStack{
                            Spacer()
                            Text(image_text)
                                .font(.system(size: 20))
                                .fontWeight(Font.Weight.black)
                                .foregroundColor(Color.clear)
                                .padding(8)
                                .overlay {
                                    Rectangle()
                                        .fill(Color.black.opacity(0.6))
                                        .cornerRadius(10)
                                        .overlay {
                                            Text(image_text)
                                                .font(.system(size: 20))
                                                .fontWeight(Font.Weight.black)
                                                .foregroundColor(Color(red: 255/255, green: 231/255, blue: 164/255))
                                        }
                                }

                        }
                        .padding(.trailing,10)
                        .padding(.top,30)
                        Spacer()
                    }
                }
                .transition(.slide)
        }
        else{
            Image(image_default_index)
                .resizable()
//                .scaledToFill()
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height/2)
                .clipped()
                .overlay {
                    VStack{
                        HStack{
                            Spacer()
                            Text("無資源，以預設圖片顯示")
                                .font(.system(size: 20))
                                .fontWeight(Font.Weight.black)
                                .foregroundColor(Color.clear)
                                .padding(8)
                                .overlay {
                                    Rectangle()
                                        .fill(Color.black.opacity(0.6))
                                        .cornerRadius(10)
                                        .overlay {
                                            Text("無資源，以預設圖片顯示")
                                                .font(.system(size: 20))
                                                .fontWeight(Font.Weight.black)
                                                .foregroundColor(Color(red: 255/255, green: 231/255, blue: 164/255))
                                        }
                                }
                            
                        }
                        .padding(.trailing,10)
                        .padding(.top,30)
                        Spacer()
                    }
                }
        }
       

    }
}

struct Restaurant_Information_Previews: PreviewProvider {
    static var previews: some View {
        Restaurant_Information()
    }
}
