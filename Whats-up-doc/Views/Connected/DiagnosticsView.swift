//  DiagnosticsView.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 27/06/2021.
//

import SwiftUI

struct DiagnosticsView: View {
    
    @State var symptoms:[SymptomItem] = [
        SymptomItem(name: "Gorge irritée", id: 13),
        SymptomItem(name: "Nez qui coule", id: 14),
        SymptomItem(name: "Nez encombré", id: 28),
        SymptomItem(name: "Eternuements", id: 95),
        SymptomItem(name: "Douleur dans les membres", id: 12),
        SymptomItem(name: "Douleur thoracique", id: 17),
        SymptomItem(name: "Nausée", id: 44),
        SymptomItem(name: "Brûlures d'estomac", id: 45),
        SymptomItem(name: "Palpitations", id: 37),
        SymptomItem(name: "Rythme cardiaque irrégulier", id: 986),
        SymptomItem(name: "Toux", id: 15)
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
                    Text("Diagnostique")
                        .buttonTextDesign()
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
