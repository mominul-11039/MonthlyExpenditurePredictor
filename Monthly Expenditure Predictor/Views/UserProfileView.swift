//
//  UserProfileView.swift
//  Monthly Expenditure Predictor
//
//  Created by SADAT AHMED on 2023/06/16.
//

import SwiftUI
import CloudKit

struct UserProfileView: View {
    // MARK: - PROPERTIES
    @State private var isShimmering = false
    @ObservedObject var vm: ProfileViewModel = ProfileViewModel()
    @State private var viewModel = ProfileViewModel()
    @State private var isShowingActionSheet = false
    @State private var selectedRow: String?
    @State private var editedValue = ""
    @State private var showingFamilyAlert = false
    @State private var showingEmailAlert = false
    @State private var showingAddressAlert = false
    @State private var changedValue = ""
    @State private var isButtonVisible = false
    
    // MARK: - VIEW
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.userInfo, id: \.self) { user in
                    Section(header: Text("Profile")) {
                        VStack {
                            ZStack {
                                Image("AvaterImage")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150, height: 150)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 60)
                                            .fill(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [.clear, .white.opacity(0.4), .clear]),
                                                    startPoint: UnitPoint(x: 0.7, y: 0.7),
                                                    endPoint: UnitPoint(x: 0.3, y: 0.3)
                                                )
                                            )
                                            .mask(
                                                Rectangle()
                                                    .frame(width: 150, height: 150)
                                                    .offset(x: isShimmering ? -400 : 400, y: 0)
                                            )
                                    )
                                    .animation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false))
                                Circle()
                                    .frame(width: 45)
                                    .padding(.top, 70)
                                    .padding(.leading, 70)
                                    .foregroundColor(.black.opacity(0.4))
                                    .overlay(
                                        ZStack {
                                            Text("\(user.userAge)")
                                                .frame(width: 45)
                                                .padding(.top, 70)
                                                .padding(.leading, 70)
                                                .foregroundColor(isButtonVisible ? Color.black.opacity(0.1) : .white)
                                                .font(.system(size: 19, weight: .bold, design: .rounded))

                                            if isButtonVisible {
                                                Button(action: {
                                                    // Handle button tap action here
                                                }) {
                                                    Image(systemName: "square.and.pencil")
                                                        .foregroundColor(.white)
                                                }
                                                .buttonStyle(PlainButtonStyle())
                                                .offset(x: 35, y: 40)
                                            }
                                        }
                                    )
                                    .onTapGesture {
                                        isButtonVisible.toggle()
                                    }


                            }
                            
                            Text(user.fullName)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .onAppear {
                            isShimmering = true
                        }
                    }
                    
                    Section(header: Text("Personal Information")) {
                        // Family Members
                        HStack {
                            InfoRow(label: "Family Member", value: "\(user.userNoOfFamilyMember)")
                            Spacer()
                            Button(action: {
                                // Handle button tap action here
                                changedValue = ""
                                selectedRow = "Family Member"
                                showingFamilyAlert.toggle()

                                
                            }) {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(.gray)
                            }
                            .alert("Edit Info", isPresented: $showingFamilyAlert) {
                                TextField("No of Family Members", text: $changedValue)
                                Button("OK", action: submit)
                            } message: {
                                Text("Change No of Family Members")
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        // Email
                        HStack {
                            InfoRow(label: "Email", value: "\(user.userEmail)")
                            Spacer()
                            Button(action: {
                                // Handle button tap action here
                                selectedRow = "Email"
                                isShowingActionSheet = true
                                showingEmailAlert.toggle()
                                changedValue = ""

                            }) {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(.gray)
                            }
                            .alert("Edit Info", isPresented: $showingEmailAlert) {
                                TextField("Email", text: $changedValue)
                                Button("OK", action: submitEmail)
                            } message: {
                                Text("Change Your Email")
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        //InfoRow(label: "Phone", value: "+1 123-456-7890")
                    }

                    Section(header: Text("Address")) {
                        HStack {
                            Text(user.userAddress)
                                .multilineTextAlignment(.center)
                            Spacer()
                            Button(action: {
                                // Handle button tap action here
                                changedValue = ""
                                selectedRow = "Address"
                                isShowingActionSheet = true
                                showingAddressAlert.toggle()

                            }) {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(.gray)
                            }
                            .alert("Edit Info", isPresented: $showingAddressAlert) {
                                TextField("Address", text: $changedValue)
                                Button("OK", action: submit)
                            } message: {
                                Text("Change Your Address")
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .listStyle(.grouped)
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.large)
        .onChange(of: UserDefaults.standard.string(forKey: "MEP_LOGGED_IN_USER_NAME")) { _ in
            viewModel = ProfileViewModel()
        }
    }


    //    func submitFamilyMember() {
    //        print("You entered \(changedValue)")
    //        let record = CKRecord(recordType: "expenditure_info")
    //        record["user_email"] = changedValue
    //    }
    func submitEmail() {
        let container = CloudKitViewModel.ckContainer
        let database = container.publicCloudDatabase

        let email = String(UserDefaults.standard.string(forKey: "MEP_LOGGED_IN_USER_NAME") ?? "")
        print("email", email)

        let predicate = NSPredicate(format: "user_email == %@", email)
        let query = CKQuery(recordType: "expenditure_user", predicate: predicate)

        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Failed to fetch records: \(error.localizedDescription)")
                return
            }

            guard let record = records?.first else {
                print("record",records?.first)
                print("Record not found")
                return
            }

            // Update the record's fields
            record["user_email"] = changedValue

            // Save the updated record
            database.save(record) { (savedRecord, saveError) in
                if let saveError = saveError {
                    print("Failed to save record: \(saveError.localizedDescription)")
                } else {
                    print("Record updated successfully")
                    UserDefaults.standard.set(changedValue, forKey: "MEP_LOGGED_IN_USER_NAME")
                }
            }
        }
    }

    func submit() {
        print("You entered \(changedValue)")
    }
}
struct InfoRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .fontWeight(.bold)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - PREVIEW
struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(vm: ProfileViewModel())
    }
}
