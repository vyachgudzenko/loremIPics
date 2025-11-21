//
//  CustomTabbar.swift
//  UniverseGroupTestTask
//
//  Created by Слава on 21.11.2025.
//

import SwiftUI

struct CustomTabbar: View {
    @Binding var selectedTab: TabScreen
    var body: some View {
        HStack{
            ForEach(TabScreen.allCases, id: \.rawValue){
                tabScreen in
                TabScreenView(tab: tabScreen, isSelected: selectedTab == tabScreen)
                    .onTapGesture {
                        withAnimation(.spring) {
                            selectedTab = tabScreen
                        }
                    }
            }
        }
        .frame(height: 80)
        .background {
            Rectangle()
                .fill(.white)
                .shadow(color: .black.opacity(0.05),radius: 15, y: -8)
                .ignoresSafeArea()
        }
        
    }
}

struct TabScreenView: View{
    let tab: TabScreen
    let isSelected: Bool
    
    var body: some View{
        VStack(spacing: 8){
            Image(tab.currentImageName(isSelected: isSelected))
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundStyle(isSelected ? .customBlue : .customLightGray)
            Text(tab.title)
                .standartFont(size: 11, weight: isSelected ? .semibold : .regular)
                .foregroundStyle( .black)
                .opacity(isSelected ? 1 : 0.6)
                
                
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CustomTabbar(selectedTab: .constant(.images))
}
