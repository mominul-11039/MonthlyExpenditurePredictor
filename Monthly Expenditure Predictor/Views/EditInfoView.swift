//
//  EditInfoView.swift
//  Monthly Expenditure Predictor
//
//  Created by BJIT on 5/7/23.
//

import SwiftUI

struct EditInfoView: View {
    @State private var showingAlert = false
    @State private var name = ""

    var body: some View {
        Button("Enter name") {
            showingAlert.toggle()
        }
        .alert("Enter your name", isPresented: $showingAlert) {
            TextField("Enter your name", text: $name)
            Button("OK", action: submit)
        } message: {
            Text("Xcode will print whatever you type.")
        }
    }

    func submit() {
        print("You entered \(name)")
    }
}

//struct EditInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditInfoView()
//    }
//}
