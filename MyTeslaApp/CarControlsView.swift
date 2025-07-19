//
//  CarControlsView.swift
//  MyTeslaApp
//
//  Created by Anmol Mangat on 13/07/25.
//

import SwiftUI

let carControls: [ActionItem] = [
    ActionItem(icon:"flashlight.on.fill" ,text: "Flash"),
    ActionItem(icon:"speaker.wave.3.fill" ,text: "Honk"),
    ActionItem(icon:"key.fill" ,text: "Start"),
    ActionItem(icon: "arrow.up.bin",text: "Front Trunk"),
    ActionItem(icon: "arrow.up.square",text: "Trunk")]

struct CarControlsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var toggleValet: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }){
                            GeneralButton(icon: "chevron.left")
                        }
                        Spacer()
                    }
                    Text("Car Controls")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                }
                CustomDivider()
                CarLockButton()
                CustomDivider()
                CarControlActions()
                HStack {
                    Text("Valet Mode")
                        .fontWeight(.medium)
                    Spacer()
                    Toggle("" ,isOn: $toggleValet)
                }
                if toggleValet {
                    Text("Valet Mode Enabled!")
            
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("DarkGray"))
        .foregroundColor(.white)
        .navigationTitle(Text("Mach Five"))
        .navigationBarHidden(true)
        
    }
    
}



#Preview {
    CarControlsView()
}

struct CarLockButton: View {
    var body: some View {
        Button(action: {}){
            FullButton(text: "Unlock Car", icon: "lock.fill")
        }
        
    }
}

struct CarControlActions: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                ActionButton(item: carControls[0])
                Spacer()
                ActionButton(item: carControls[1])
                Spacer()
                ActionButton(item: carControls[2])
                Spacer()
            }
            HStack {
                Spacer()
                ActionButton(item: carControls[3])
                Spacer()
                ActionButton(item: carControls[4])
                Spacer()
                
            }
        }
    }
}
