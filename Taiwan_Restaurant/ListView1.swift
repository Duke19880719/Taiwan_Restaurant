//
//  ListView1.swift
//  Taiwan_Restaurant
//
//  Created by 江培瑋 on 2022/12/12.
//

import SwiftUI

struct ListView1: View {
    var restaurant_obj:Info_struct

    var body: some View {
        ZStack{
            Image(restaurant_obj.Picture1!)
                .resizable()
                .aspectRatio( contentMode: .fill)
                .frame(height: 200)
                .cornerRadius(10)
                .overlay{
                    Rectangle()
                        .foregroundColor(Color.black)
                        .cornerRadius(10)
                        .opacity(0.2)
                }
            Text(restaurant_obj.Name!)
                .font(.system(size: 30, weight: .black, design: .rounded))
                .foregroundColor(Color.white)
        }
    }
}

//struct ListView1_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView1()
//    }
//}
