//
//  DiagnostcsSheetView.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 27/07/2021.
//

import SwiftUI



struct DiagnosticsSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var diagnostics: [String]
    
//    let getDiagnostics = {
//        return [
//            "Inflammation du nez et de la gorge",
//            "Rhume",
//            "Grippe",
//            "Inflammation des amygdales",
//            "Phlegmon de l'amygdale",
//            "Maladie de reflux",
//            "Maladie du baiser"
//        ]
//
//    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            VStack(){
                VStack() {
                    HStack(){
                        Text("Diagnostics")
                            .font(.largeTitle)
                            .shadow(radius: 10.0, x: 20, y: 10)
                            .foregroundColor(.white)
                            .padding()
                    }
                    

                    HStack(){
                        Image(systemName: "stethoscope")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 20))
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10.0, x: 20, y: 10)
                            .padding(.bottom, 20)
                    }
                    
                }
                
                Spacer()
    
                VStack(){
                    List {
                        ForEach(0..<diagnostics.count, content: { index in
                            Text(diagnostics[index])
                                .padding(.vertical)
                        })
                        .listRowBackground(Color("lightGray"))
                        .opacity(0.7)
                    }.cornerRadius(10)
                    .padding(.top, 10)
                }
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    
                    HStack(){
                        Image(systemName: "xmark.circle")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(30)
                    .shadow(radius: 10.0, x: 20, y: 10)
                }
                    
            }.backgroundDesign()
        }
    }
}

//struct DiagnostcsSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        DiagnosticsSheetView()
//    }
//}
