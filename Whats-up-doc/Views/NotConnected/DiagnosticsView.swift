//  DiagnosticsView.swift
//  Whats-up-doc
//
//  Created by Aymeric Larvet on 27/06/2021.
//

import SwiftUI

struct DiagnosticsView: View {
    @EnvironmentObject  var userData: UserData
    @State var diagnistics: [String] = []
    @State var showModalDiagnostic: Bool = false
    @State private var isLoading: Bool = false
    
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
        LoadingComponent(isShowing: self.$isLoading) {
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
                            .padding([.leading, .trailing], 5)
                        }
                    }
                    Spacer()
                    
                    Button(action: {
                        submitSymptoms()
                    }) {
                        Text("Diagnostique")
                            .buttonTextDesign()
                            .background(isDisabled(symptoms: symptoms) ? Color.gray : Color.blue)
                            .cornerRadius(15.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                        
                    }
                    .disabled(isDisabled(symptoms: symptoms))
                    .sheet(isPresented: $showModalDiagnostic) {
                        DiagnosticsSheetView(diagnostics: $diagnistics)
                    }
                    
                    Spacer()
                    
                }.background(
                    LinearGradient(gradient: Gradient(colors: [.green, Color("lightGray")]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all))
                
            }
        }
    }
    
    func submitSymptoms(){
        self.isLoading.toggle()
        
        var symptomsId: [Int] = []
        for symptom in symptoms {
            if symptom.isChecked {
                symptomsId.append(symptom.id)
            }
        }
        
        var json = [String:Any]()
        json = [
            "symptoms": symptomsId,
            "yearOfBirth":1984,
            "gender":"male"
        ]
         DiagnosticService.sharedInstance.getDiagnostic(endpoint: "api/diagnosis", json: json) { (result, success) -> Void in
            if success {
                for row in result {
                    if let issuesArray = row["issues"] as? [[String:Any]],
                          let issues = issuesArray.first
                          {
                        guard let name = issues["name"] as? String else {
                            print("Error on unwraping")
                            return
                        }
                        diagnistics.append(name)
                    }


                }
                self.isLoading.toggle()
                self.showModalDiagnostic.toggle()
            }
        }
    }
    
    func isDisabled(symptoms: [SymptomItem]) -> Bool{
        for symptom in symptoms {
            if symptom.isChecked {
                return false
            }
        }
        return true
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

//struct DiagnosticsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DiagnosticsView()
//    }
//}
