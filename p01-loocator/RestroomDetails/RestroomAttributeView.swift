//
//  RestroomAttributeView.swift
//  p01-loocator
//
//  Created by William Wang on 3/7/23.
//

import SwiftUI

struct RestroomAttributeView: View {
    let title: String
    let icon: Image
    let isOn: Bool
    
    init(title: String, icon: Image, isOn: Bool) {
        self.title = title
        self.icon = icon
        self.isOn = isOn
    }
    
    init(title: String, systemIcon: String, isOn: Bool) {
        self.title = title
        icon = Image(systemName: systemIcon)
        self.isOn = isOn
    }
    
    var body: some View {
        HStack {
            icon
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding(12)
                .background(Material.regular)
                .cornerRadius(12)
            
            Text("\(title)?")
                .fontWeight(.semibold)
            
            Spacer()
            
            Text(isOn ? "Yes" : "No")
                .foregroundColor(isOn ? .green : .red)
        }
    }
}

