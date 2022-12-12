//
//  back_to_selectview_button.swift
//  Taiwan_Restaurant
//
//  Created by 江培瑋 on 2022/12/12.
//

import SwiftUI

struct back_to_selectview_button:View{
    @Binding var check_select_complete:Bool
//    @Binding var check_back_view_button_display:Bool
    var body: some View {
        VStack{
            Spacer()
            HStack{
                
                Button {
                    print("111")
                    check_select_complete = false
                } label: {
                    
                    HStack{
                        Image(systemName: "arrow.uturn.backward")
                            .foregroundColor( .clear )
                            .font(.system(size: 20, weight: .black, design: .rounded))
                            
             
                        Image(systemName: "doc.text.magnifyingglass")
                            .foregroundColor( .clear )
                            .font(.system(size: 20, weight: .black, design: .rounded))
                            
                  
                    }
                    .padding()
                    .background(.black)
                    .opacity(0.25)
                    .cornerRadius(20)
                    .clipped()
                    
                }
                .overlay(
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 5)
                            .shadow(color: .black, radius: 1, x: 0.25, y: 0.25)
                        HStack{
                            Image(systemName: "arrow.uturn.backward")
                                .foregroundColor( .white )
                                .font(.system(size: 20, weight: .black, design: .rounded))
                                                 
                            Image(systemName: "doc.text.magnifyingglass")
                                .foregroundColor( .white )
                                .font(.system(size: 20, weight: .black, design: .rounded))

                        }
                    }
                )
                .cornerRadius(20)
                .clipped()
                .shadow(color: .gray, radius: 1, x: 1, y: 1)
                Spacer()
            }
            .padding()
        }
        .padding()
    }
}

//struct back_to_selectview_button_Previews: PreviewProvider {
//    static var previews: some View {
//        back_to_selectview_button()
//    }
//}
