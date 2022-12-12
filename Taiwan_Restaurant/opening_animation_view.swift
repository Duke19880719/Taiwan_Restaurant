//
//  opening_animation_view.swift
//  Taiwan_Restaurant
//
//  Created by 江培瑋 on 2022/8/3.
//

import Foundation
import SwiftUI

struct opening_animation_view:View{
    
    var body: some View{
        
        Bounce_Animation_View(text: "Taiwan Yummy Food")
         
        
    }
}

struct Bounce_Animation_View:View{
    
    var characters:[String.Element]
    
    @State var offset_bounce_y : CGFloat = -50
    @State var opacity : CGFloat = 0
    @State var appear_check: Bool = false
    
    init(text:String){
        self.characters = Array(text)
     
    }
    
    var body: some View{
        
        GeometryReader{ geo_value in
            
            VStack{
           
                Image("logo")
                    .resizable()
                    .position(x: geo_value.size.width/2, y: geo_value.size.height/2.7)
                    .offset(x: appear_check ? 0 : -geo_value.size.width )
                    .frame(width: geo_value.size.width,height:geo_value.size.height/3)
                    .animation(.spring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.75).delay(0.5), value: appear_check)
                    
                HStack(spacing: 0){
                    ForEach(0..<characters.count,id: \.self){ index in
                        Text(String( self.characters[index] ) )
                            .font(Font.custom("RaviPrakash-Regular", size: 40, relativeTo: .title))
                            .foregroundColor(Color(red: 104/255, green: 22/255, blue:33/255))
                            .offset(x: 0, y: offset_bounce_y)
                            .opacity(opacity)
                            .animation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0.1).delay(Double(index)*0.1), value: offset_bounce_y)
                    }
                    .onAppear{
                        appear_check = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.25){
                            offset_bounce_y = 0
                            opacity = 1
                        }
                    }
                    
                }

                .position(x: geo_value.size.width/2, y: geo_value.size.height/5-20)
                
            }
            .frame(width: geo_value.size.width, height: geo_value.size.height )
            
        }
    }
}


