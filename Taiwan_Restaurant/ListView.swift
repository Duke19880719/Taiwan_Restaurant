//
//  ListView.swift
//  Taiwan_Restaurant
//
//  Created by 江培瑋 on 2022/9/13.
//

import SwiftUI

struct ListView: View {
    
    var data:Info_struct?
    
    var body: some View {
        
            VStack{
                ZStack{
                    AsyncImage(url: URL(string: (data?.Picture1 ?? "") )) {
                        phase  in

                        if let image = phase.image{
                            
                            image
                                .resizable()
                                .overlay {
                                    Rectangle()
                                        .foregroundColor(.gray)
                                        .opacity(0.4)
                                        .frame(maxWidth: 300, maxHeight: 300)
                                }
                        } else if phase.error != nil {
                            Image("default_pic1")
                                .resizable()
                                .overlay {
                                    Rectangle()
                                        .foregroundColor(.gray)
                                        .opacity(0.4)
                                        .frame(maxWidth: 300, maxHeight: 300)
                                }
                        } else {
                            Image("default_pic1")
                                .resizable()
                                .overlay {
                                    Rectangle()
                                        .foregroundColor(.gray)
                                        .opacity(0.4)
                                        .frame(maxWidth: 300, maxHeight: 300)
                                }
                        }
                    }
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .clipped()
                    .cornerRadius(20)
                    
                    
                    Text((data?.Name ?? "nil"))
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(Color.white)
                    .padding([.leading,.bottom])
                    .frame(maxWidth: 300, alignment: .leading)
                    .offset(y:100)
                    .shadow(color: .black, radius: 0.85,x:1 ,y: 1)
                    
                }
                .cornerRadius(20)
                
                VStack{
                    if #available(iOS 16.0, *) {
                        Group{
                            Text(data?.Add ?? "無地址資料無地址資料無地址資料")
                            Text(data?.Opentime ?? "無營業時間資料")
                            Text(data?.Tel ?? "無電話資料")
                        }
                        .padding(.horizontal)
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .fontWeight(.bold)
                    
                    } else {
                        // Fallback on earlier versions
                    }


                }
                .frame(width: 300,height: 100)

            }
            .frame(height: 400)
            .padding(.bottom)
            .cornerRadius(20)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.8),lineWidth: 2  )
                
            )
            .clipped()
            

        
     
    
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
