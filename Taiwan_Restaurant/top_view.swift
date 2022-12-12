//
//  top_view.swift
//  Taiwan_Restaurant
//
//  Created by 江培瑋 on 2022/12/12.
//

import SwiftUI

struct top_view: View {
    @Binding var check_top_vstack:Bool
    @Binding var json_data_sort_complete:[Info_struct]
    @Binding var json_data:decode_restaurant_json_struct?
    @Binding var check_select_complete:Bool
    
    var body: some View {
        VStack(alignment: .leading , spacing: 2){
            Text(Date(), style: .date)
                .font(.title3)
                .foregroundColor(.white)
                .shadow(color: Color.black , radius: 0.2, x: 1, y: 1)

            HStack{
                Text((check_select_complete)  ? "Your Search Results"  :"Your Search All Results")
                    .font(.title2)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                Spacer()
                Text((check_select_complete)  ? "\(json_data_sort_complete.count)" : "\(json_data?.XML_Head.Infos.Info.count ?? 0)"  )
                    .font(.title3)
                    .padding(.trailing)
                    .foregroundColor(.white)
            }

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.leading,.bottom])
        .background(Color(red: 104/255, green: 22/255, blue:33/255))
        .animation(Animation.easeInOut(duration: 0.25),value: (!check_top_vstack))
        .transition(.opacity)
    }
}

//struct top_view_Previews: PreviewProvider {
//    static var previews: some View {
//        top_view()
//    }
//}
