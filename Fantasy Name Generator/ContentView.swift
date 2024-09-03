//
//  ContentView.swift
//  Fantasy Name Generator
//

import SwiftUI

struct ContentView: View {
    @State private var fantasyName: String = "Tap Generate"
    @State private var lastPrefix: String? = nil
    @State private var lastSuffix: String? = nil
    @State private var animateName: Bool = false
    @State private var generatedNames: Set<String> = []
    
    // Arrays of name prefixes and suffixes
    let prefixes = ["El", "Gal", "Mor", "Tar", "Zar", "Aer", "Lor", "Fen"]
    let suffixes = ["dorin", "thar", "gorn", "lith", "wyn", "mar", "mon", "axis", "lion"]
    let middleSegments = ["an", "or", "en", "us", "al", "ir", "un", "eth"]  // Optional middle segments
    
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
                    generateUniqueName()
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
    
    func generateUniqueName() {
        var newName: String
        var randomPrefix: String
        var randomSuffix: String
        
        repeat {
            // Generate a new prefix, optional middle, and suffix
            randomPrefix = prefixes.filter { $0 != lastPrefix }.randomElement() ?? prefixes.randomElement()!
            randomSuffix = suffixes.filter { $0 != lastSuffix }.randomElement() ?? suffixes.randomElement()!
            let randomMiddle = Bool.random() ? middleSegments.randomElement() ?? "" : ""  // Randomly decide to add a middle segment
            
            // Combine to form the new name with optional middle segment
            newName = randomPrefix + randomMiddle + randomSuffix
            
            // Optionally randomize capitalization
            if Bool.random() {
                newName = newName.capitalized
            }
        } while  generatedNames.contains(newName)
                    
            // Store the last used prefix and suffix with correct lengths
            lastPrefix = String(newName.prefix(randomPrefix.count))
            lastSuffix = String(newName.suffix(randomSuffix.count))
            generatedNames.insert(newName)
                    
                    // Update the displayed fantasy name
                    fantasyName = newName
        }
    }
        
        
        
        #Preview {
            ContentView()
        }
        
    
