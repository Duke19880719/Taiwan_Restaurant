//
//  Data_Loading_Animation.swift
//  Taiwan_Restaurant
//
//  Created by 江培瑋 on 2022/9/7.
//

import SwiftUI

struct Data_Loading_Animation: View {
    
    var text_string:String = "Data Downloading"
    @State var animation = false
    
    var body: some View {
        
        GeometryReader{ geo_value in
            
            VStack{
                HStack(spacing: 1){
                        ForEach(0..<text_string.count,id: \.self){ index in
                            
                            if #available(iOS 16.0, *) {
                                Text(String(text_string[text_string.index(text_string.startIndex, offsetBy: index)]))
                                    .shadow(color: Color.black, radius: 0.5, x: 1.65, y: 1.65)
                                //                                .font(.system(size: 35, weight:.bold))
                                
                                    .font(Font.custom("RaviPrakash-Regular", size: 40, relativeTo: .title))
                                    .fontWeight(.bold)
                                    .foregroundColor( randomColor() )
                            } else {
                                // Fallback on earlier versions
                            }
                        }
                }
                .position(x: geo_value.size.width/2, y: geo_value.size.height/2.7+15)
                .mask(
                    Rectangle()
                       
                        .fill(
                            LinearGradient(gradient: .init(colors: [Color.red.opacity(0.5),Color.white,Color.yellow.opacity(0.25)]), startPoint: .top, endPoint: .bottom)
                        )
                        .rotationEffect(.init(degrees: 75))
                        .padding(20)
    //rectangle animation 特效
                        .offset(x: -250)
                        .offset(x: animation ? 800 : 0)
                )
                .onAppear(perform: {
                
                    withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)){
                        
                        animation.toggle()
                    }
                })
                
            }
            .frame(width: geo_value.size.width, height: geo_value.size.height )
        }
    }
}
func randomColor()->Color{
    
    let color = Color(red: 1, green: .random(in: 0.25...0.75), blue: .random(in: 0...1))
    
    return color
}


struct Data_Loading_Animation_Previews: PreviewProvider {
    static var previews: some View {
        Data_Loading_Animation()
    }
}
