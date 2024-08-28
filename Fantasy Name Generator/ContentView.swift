//
//  ContentView.swift
//  Fantasy Name Generator
//
//  Created by Darien Hallam on 27/8/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var fantasyName: String = "Tap Generate"
    @State private var animateName: Bool = false
    
    // Arrays of name prefixes and suffixes
    let prefixes = ["El", "Gal", "Mor", "Tar", "Zar", "Aer", "Lor", "Fen"]
    let suffixes = ["dorin", "thar", "gorn", "lith", "wyn", "mar", "mon", "axis", "lion"]

    var body: some View {
        ZStack {
            //Background Gradient
            LinearGradient(gradient: Gradient(colors: [Color("Flower"), Color("Soft")]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Fantasy Name Generator")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Midnight"))
                    .padding()
                
                Spacer() //Adds spacing betwen the itle and the name
                
                Text(fantasyName)
                    .font(.system(size: 40, weight: .bold, design: .serif))
                    .foregroundColor(Color("Mint"))
                    .padding()
                    .background(Color(Color("Midnight")).opacity(0.7))
                    .cornerRadius(10)
                    .scaleEffect(animateName ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 0.5), value: animateName)
                    .shadow(radius: 10)
                // Animation for scale effect
                
                Spacer() //Adds spacing betwen the itle and the name
                
                Button(action: {
                    generateName()
                    animateName = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        animateName = false
                    }
                }) {
                    HStack {
                        Image(systemName: "sparkles")
                            .font(.title)
                        Text("Generate")
                            .font(.title)
                            
                    }
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Color(Color("Mint")), Color(Color("Sand"))]),
                                                       startPoint: .leading,
                                                       endPoint: .trailing))
                            .foregroundColor(Color("ButtonText"))
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                }
            .padding()
        }
    }
    
    func generateName() {
        //Generate a random prefix and suffix
        let randomPrefix = prefixes.randomElement() ?? "El"
        let randomSuffix = suffixes.randomElement() ?? "dor"
        
        //Combine them to form the fantasy name
        fantasyName = randomPrefix + randomSuffix
    }
}


#Preview {
    ContentView()
}
