//
//  SimpleSegmentedPicker.swift
//  Cativity
//
//  Created by Faiz Hadiyan Firza on 16/05/24.
//
import SwiftUI

struct SimpleSegmentedPicker: View {
    @Binding var selection: Day
    var items: [Day]
    var selectionColor: Color = .blue

    @Namespace private var pickerTransition

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 6) {
                    ForEach(items, id: \.self) { item in
                        let selected = selection == item
                        ZStack {
                            if selected {
                                Capsule()
                                    .foregroundColor(selectionColor)
                                    .matchedGeometryEffect(id: "picker", in: pickerTransition)
                                
                                Text(item.setDayInIndonesia())
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                    .lineLimit(1)
                                    .clipShape(Capsule())
                            } else {
                                Capsule()
                                    .foregroundColor(.clear)
                                Text(item.setDayInIndonesia())
                                    .foregroundColor(.black)
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                    .lineLimit(1)
                                    .clipShape(Capsule())
                            }
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selection = item
                            }
                        }
                        .onChange(of: selection) { _ in
                            withAnimation(.easeInOut(duration: 0.2)) {
                                proxy.scrollTo(selection)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

