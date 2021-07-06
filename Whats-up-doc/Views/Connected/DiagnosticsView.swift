
//  DiagnosticsView.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 27/06/2021.
//

import SwiftUI

struct DiagnosticsView: View {
    
    @State var symptoms:[SymptomItem] = [
        SymptomItem(name: "Rhume", id: 1),
        SymptomItem(name: "Toux", id: 2)
    ]
    
    
    @State private var smoker: Bool = false
    
    var body: some View {
        ZStack(alignment: .top){
            VStack() {
                
                HeaderComponent()
                
                Section(header: HeaderSectionView(title: "Symptoms",icon: "heart.fill")) {
                    ScrollView{
                        VStack{
                            ForEach(0..<symptoms.count) { index in
                                ToggleComponent(isChecked: $symptoms[index].isChecked, title: symptoms[index].name)
                            }
                        }
                    }
                }
                Spacer()
                
                Button(action: {
                    submitSymptoms()
                }) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 330, height: 50)
                        .background(isDisabled() ? Color.gray : Color.blue)
                        .cornerRadius(15.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                    
                }
                .disabled(isDisabled())
                
                Spacer()
                
            }.background(
                LinearGradient(gradient: Gradient(colors: [.green, Color("lightGray")]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
            
        }
    }
    
    func submitSymptoms(){
        
    }
    
    func isDisabled() -> Bool{
        true
    }
}

class SymptomItem: ObservableObject {
    let name: String
    @Published var isChecked: Bool = false
    let id: Int
    
    internal init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
}

struct DiagnosticsView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosticsView()
    }
}
