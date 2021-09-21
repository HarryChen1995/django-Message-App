//
//  ContentView.swift
//  django Message App
//
//  Created by Hanlin Chen on 9/13/21.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    Text("Hello, world!")
                        .padding().toolbar{
                            Button(action: {}){
                                Text("Logout").font(.system(size: 14)).fontWeight(.bold).padding(6).background(.blue).clipShape(Capsule())
                            }.tint(.white)
                            
                            
                        }
                    
                }.navigationTitle("Title").navigationBarTitleDisplayMode(.inline)

            }
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
