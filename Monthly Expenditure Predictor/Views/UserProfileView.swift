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
    @State private var selectedRow: String?
    @State private var editedValue = ""
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
                            HStack {
                                Text(user.fullName)
                                    .font(.title)
                                    .fontWeight(.bold)
                                Spacer()
                                Button(action: {
                                    // Handle button tap action here
                                    changedValue = ""
                                    selectedRow = "User Name"
                                    vm.showingNameAlert = true

                                    
                                }) {
                                    Image(systemName: "square.and.pencil")
                                        .foregroundColor(.gray)
                                }
                                .alert("Edit Info", isPresented: $vm.showingNameAlert) {
                                    TextField("Name", text: $changedValue)
                                    Button("OK", action: submitName)
                                } message: {
                                    Text("Change User Name")
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
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
                                vm.showingFamilyAlert = true
                            }) {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(.gray)
                            }
                            .alert("Edit Info", isPresented: $vm.showingFamilyAlert) {
                                TextField("No of Family Members", text: $changedValue)
                                Button("OK", action: submitNoOfFamily)
                            } message: {
                                Text("Change No of Family Members")
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        // Email
                        HStack {
                            InfoRow(label: "Email", value: "\(user.userEmail)")
                            Spacer()
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
                                vm.showingAddressAlert = true
                            }) {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(.gray)
                            }
                            .alert("Edit Info", isPresented: $vm.showingAddressAlert) {
                                TextField("Address", text: $changedValue)
                                Button("OK", action: submitAddress)
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
    func submitAddress() {
        vm.showingAddressAlert = false
        submitData(type: 3)
    }

    func submitName() {
        vm.showingNameAlert = false
        submitData(type: 0)
    }

    func submitNoOfFamily() {
        vm.showingFamilyAlert = false
        submitData(type: 1)
    }

    func submitData(type: Int) {
        let container = CloudKitViewModel.ckContainer
        let database = container.publicCloudDatabase

        switch type {
            case 0 :
                vm.userInfo[0].fullName = changedValue
                vm.userInfo.first?.record["user_name"] = changedValue
            case 1 :
                vm.userInfo[0].userNoOfFamilyMember = Int(changedValue) ?? 0
                vm.userInfo.first?.record["no_of_family_member"] = Int(changedValue) ?? 0
            case 2 :
                vm.userInfo[0].userEmail = changedValue
                vm.userInfo.first?.record["user_email"] = changedValue
            case 3 :
                vm.userInfo[0].userAddress = changedValue
                vm.userInfo.first?.record["user_address"] = changedValue
            default :
                break
        }

        // Save the updated record
        database.save(vm.userInfo.first!.record) { (savedRecord, saveError) in
            if let saveError = saveError {
                print("Failed to save record: \(saveError.localizedDescription)")
            } else {
                print("Record updated successfully")
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
