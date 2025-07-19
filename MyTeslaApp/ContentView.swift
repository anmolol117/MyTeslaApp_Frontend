//
//  ContentView.swift
//  MyTeslaApp
//
//  Created by Anmol Mangat on 13/07/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var openVoiceCommand = false
    @State private var openMedia = false
    @State private var openCharging = false
    
    @State private var actionText = ""
    @State private var actionIcon = ""
    @State private var openAction = false
    
    
    
    
    
    
    var body: some View {
        
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(spacing: 20) {
                        HomeHeader()
                        CustomDivider()
                        CarSection(openCharging: $openCharging)
                        CustomDivider()
                        CategoryView(openAction: $openAction,
                                     actionText: $actionText,
                                     actionIcon: actionIcon,
                                     openCharging: $openCharging,
                                     openMedia: $openMedia,
                                     title: "Quick Shortcuts",
                                     showedit: true,actionItems: quickActionItems)
                        CustomDivider()
                        CategoryView(openAction: $openAction,
                                     actionText: $actionText,
                                     actionIcon: actionIcon,
                                     openCharging: $openCharging,
                                     openMedia: $openMedia,
                                     title: "Recent Actions",
                                     actionItems: recentActions)
                        CustomDivider()
                        AllSettings()
                        ReorderButton()
                    }
                    
                }
                .padding()
                
                VoiceCommandButton(open: $openVoiceCommand)
                
                
                
                if openVoiceCommand {
                    VoiceCommandView(open: $openVoiceCommand, text: "Take me to Olive Garden")
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                    
                    Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                        .onTapGesture {
                            withAnimation {
                                openVoiceCommand = false
                            }
                        }
                }
                
                if openCharging {
                    ChargingView()
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                    
                    Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                        .onTapGesture {
                            withAnimation {
                                openCharging = false
                            }
                        }
                    
                }
                
                if openMedia {
                    MediaPlayer()
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                    
                    Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                        .onTapGesture {
                            withAnimation {
                                openMedia = false
                            }
                        }
                }
                
                if openAction && !actionText.isEmpty {
                    ActionNotification(open: $openAction,
                                       icon: actionIcon,
                                       text: actionText)
                    .zIndex(1)
                    .transition(.move(edge: .bottom))
                    
                    Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                        .onTapGesture {
                            withAnimation {
                                openAction = false
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("DarkGray"))
            .foregroundColor(.white)
            .navigationTitle(Text("Mach Five"))
            .navigationBarHidden(true)
        }
    }
    
    
}


#Preview {
    ContentView()
}

struct VoiceCommandButton: View {
    
    @Binding var open: Bool
    
    var body: some View {
        ZStack {
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            open = true
                        }
                    }){
                        Image(systemName: "mic.fill")
                            .font(.system(size: 24, weight: .semibold, design: .default))
                            .frame(width: 64, height: 64)
                            .background(Color("Green"))
                            .foregroundColor(Color("DarkGray"))
                            .clipShape(Circle())
                            .padding()
                            .shadow(radius: 15)
                    }
                    
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}


struct HomeHeader: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 10){
                Text("Model 3".uppercased())
                    .font(.caption2)
                    .fontWeight(.medium)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .foregroundColor(Color.white)
                    .background(Color("Red"))
                    .clipShape(Capsule())
                Text("Mach Five")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
            }
            Spacer()
            HStack{
                GeneralButton(icon: "lock.fill")
                GeneralButton(icon: "gear")
            }
            
        }
        .padding(.top)
    }
}

struct CarSection: View {
    
    @Binding var openCharging: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .center){
                Button(action: {
                    withAnimation {
                        openCharging = true
                    }
                }){
                    HStack {
                        Image(systemName: "battery.75")
                        Text("237 miles".uppercased())
                    }
                    .font(.system(size:14, weight: .semibold, design: .rounded))
                    .foregroundColor(Color("Green"))
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Parked")
                        .fontWeight(.semibold)
                    Text("Last updated 5 minutes ago")
                        .font(.caption2)
                        .foregroundColor(Color.gray)
                }
                
            }
            Image("Car")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
        }
    }
}

struct CategoryHeader: View {
    var title: String
    var showedit: Bool = false
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                if showedit {
                    Button(action: {}) {
                        Text("Edit")
                            .foregroundColor(Color.gray)
                            .fontWeight(.medium)
                    }
                }
            }
        }
    }
}

struct CategoryView: View {
    
    @Binding var openAction: Bool
    @Binding var actionText: String
    @State var actionIcon: String
    
    @Binding var openCharging: Bool
    @Binding var openMedia: Bool
    
    var title: String
    var showedit: Bool = false
    
    var actionItems: [ActionItem]
    
    var body: some View {
        VStack {
            CategoryHeader(title: title, showedit: showedit)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(alignment: .top){
                    
                    if title == "Quick Shortcuts" {
                        Button(action: {
                            withAnimation {
                                openCharging = true
                            }
                        }){
                            ActionButton(item: chargingShortcut)
                        }
                        
                        Button(action: {
                            withAnimation {
                                openMedia = true
                            }
                        }){
                            ActionButton(item: mediaShortcut)
                        }
                        
                    }
                    
                    ForEach(actionItems, id: \.self){
                        item in
                        Button(action: {
                            withAnimation {
                                openAction = true
                                actionIcon = item.icon
                                actionText = item.text
                            }
                        }){
                            ActionButton(item: item)
                            
                        }
                    }
                }
            }
        }
    }
}

let quickActionItems: [ActionItem] = [
    .init(icon: "fanblades.fill", text: "Fan On"),
    .init(icon: "bolt.car", text: "Close Charge Port")
]

let chargingShortcut = ActionItem(icon: "bolt.fill", text: "Charging")
let mediaShortcut = ActionItem(icon: "music.note", text: "Media Controls")

let recentActions: [ActionItem] = [
    .init(icon: "arrow.up.square", text: "Open Trunk"),
    .init(icon: "fanblades", text: "Fan Off"),
    .init(icon: "person.fill.viewfinder", text: "Summon"),
]

struct AllSettings: View {
    var body: some View {
        VStack{
            CategoryHeader(title: "All Settings")
            LazyVGrid(columns: [GridItem(.fixed(170)), GridItem(.fixed(170))]){
                NavigationLink(destination: CarControlsView()){
                    SettingsBlock(icon: "car.fill", title: "Controls", subtitle: "Car Locked")
                }
                
                SettingsBlock(icon: "fanblades.fill", title: "Climate",subtitle: "Interior 68˚ F", backgroundColor: .blue)
                NavigationLink(destination: LocationView()){
                    SettingsBlock(icon: "location.fill", title: "Location", subtitle: "Empire State Building")
                }
                SettingsBlock(icon: "checkerboard.shield", title: "Security", subtitle: "0 events detected")
                SettingsBlock(icon: "sparkles", title: "Upgrades", subtitle: "3 upgrades available")
                
            }
        }
    }
}

struct SettingsBlock: View {
    var icon: String
    var title: String
    var subtitle: String = ""
    
    var hassubtitle: Bool = false
    
    var backgroundColor: Color = Color.white.opacity(0.05)
    
    var body: some View {
        HStack(alignment: .center, spacing: 2){
            Image(systemName: icon)
            VStack(alignment: .leading, spacing: 5){
                Text(title)
                    .fontWeight(.semibold)
                    .font(.system(size: 14, weight: .semibold, design: .default))
                if !subtitle.isEmpty {
                    Text(subtitle.uppercased())
                        .font(.system(size: 8, weight: .medium, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                }
            }
            .padding(.leading, 5)
            Spacer()
            Image(systemName: "chevron.right")
            
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 16)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.1), lineWidth: 0.5))
    }
}

struct ReorderButton: View {
    var body: some View {
        Button(action: {}){
            Text("Reorder Groups")
                .font(.caption)
                .padding(.vertical, 8)
                .padding(.horizontal, 14)
                .background(Color.gray.opacity(0.05))
                .clipShape(Capsule())
        }
    }
}
