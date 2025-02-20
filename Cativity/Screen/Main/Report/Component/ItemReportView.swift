//
//  ItemReportView.swift
//  Cativity
//
//  Created by Wahyu Untoro on 15/05/24.
//

import SwiftUI

struct ItemReportView: View {
    var body: some View {
        VStack {
            Text("Capaian Pekan Ini")
                .fontDesign(.rounded)
                .fontWeight(.bold)
                .padding(.top)
            
            HStack() {
                CatImageView(catType: .constant(.wakeup))
                    .scaleEffect(x: 0.75, y: 0.75)
                    .scaleEffect(x: -1)
                    .offset(CGSize(width: -50.0, height: 0))
                
                VStack(alignment: .leading) {
                    Text("Bangun")
                        .font(.body)
                        .foregroundStyle(.gray)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .offset(CGSize(width: -70.0, height: 0.0))
                    
                    StackedBarView()
                        .offset(CGSize(width: -70.0, height: 0.0))
                }
            }
            .frame(height: 125)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Kuliah")
                        .font(.body)
                        .foregroundStyle(.gray)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .offset(CGSize(width: 95.0, height: 0.0))
                    
                    StackedBarView()
                        .offset(CGSize(width: 95.0, height: 0.0))
                }
                
                CatImageView(catType: .constant(.book))
                    .scaleEffect(x: -1)
                    .scaleEffect(CGSize(width: 0.75, height: 0.75))
                    .offset(CGSize(width: 60.0, height: 0.0))
            }
            .frame(height: 125)
            
            HStack {
                CatImageView(catType: .constant(.sleep))
                    .scaleEffect(CGSize(width: 0.75, height: 0.75))
                    .scaleEffect(x: -1)
                    .offset(CGSize(width: -50.0, height: 0.0))
                
                VStack(alignment: .leading) {
                    Text("Tidur")
                        .font(.body)
                        .foregroundStyle(.gray)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .offset(CGSize(width: -70.0, height: 0.0))
                    
                    StackedBarView()
                        .offset(CGSize(width: -70.0, height: 0.0))
                }
            }
            .frame(height: 125)
            
            HStack {
                Spacer()
                HStack {
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(.secondaryLighter)
                    
                    Text("Lebih Cepat")
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .font(.footnote)
                }
                .frame(width: 125, alignment: .leading)
                HStack {
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(.secondaryNormal)
                    
                    Text("Tepat Waktu")
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .font(.footnote)
                }
                .frame(width: 125, alignment: .leading)
                Spacer()
            }
            
            HStack {
                Spacer()
                HStack {
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(.secondaryDarker)
                    
                    Text("Terlambat")
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .font(.footnote)
                }
                .frame(width: 125, alignment: .leading)
                HStack {
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(.gray)
                    
                    Text("Tidak Tercatat")
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                        .font(.footnote)
                }
                .frame(width: 125, alignment: .leading)
                Spacer()
            }
        }
    }
}

#Preview {
    ItemReportView()
}
