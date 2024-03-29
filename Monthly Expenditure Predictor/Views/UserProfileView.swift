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
    @EnvironmentObject var sessionManager: SessionManager
    @State private var isShimmering = false
    @ObservedObject var vm: ProfileViewModel = ProfileViewModel()
    @State private var viewModel = ProfileViewModel()
    @State private var selectedRow: String?
    @State private var editedValue = ""
    @State private var changedValue = ""
    @State private var isButtonVisible = false
    
    // MARK: - VIEW
    var body: some View {

        List {
            ForEach(vm.userInfo, id: \.self) { user in
                // MARK: - Profile Section
                Section(header: Text("Profile")) {
                    VStack {
                        ZStack {
                            Image(Constant.avaterImage)
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
                                                Image(systemName:  Constant.editProfileIcon)
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
                                selectedRow = Constant.userNameLable
                                vm.showingNameAlert = true

                                
                            }) {
                                Image(systemName:  Constant.editProfileIcon)
                                    .foregroundColor(.gray)
                            }
                            .alert(Constant.editAlertTitle, isPresented: $vm.showingNameAlert) {
                                TextField("Name", text: $changedValue)
                                Button("OK", action: submitName)
                            } message: {
                                Text(Constant.changeUserNameMessage)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .onAppear {
                        isShimmering = true
                    }
                }
                // MARK: - Personal Details
                Section(header: Text("Personal Information")) {
                    // MARK: Family Member
                    HStack {
                        InfoRow(label: Constant.familyMemberLabel, value: "\(user.userNoOfFamilyMember)")
                        Spacer()
                        Button(action: {
                            // Handle button tap action here
                            changedValue = ""
                            selectedRow = Constant.familyMemberLabel
                            vm.showingFamilyAlert = true
                        }) {
                            Image(systemName: Constant.editProfileIcon)
                                .foregroundColor(.gray)
                        }
                        .alert(Constant.editAlertTitle, isPresented: $vm.showingFamilyAlert) {
                            TextField("No of Family Members", text: $changedValue)
                            Button("OK", action: submitNoOfFamily)
                        } message: {
                            Text(Constant.changeFamilyMemberMessage)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    // MARK: Email
                    HStack {
                        InfoRow(label: Constant.emailLable, value: "\(user.userEmail)")
                        Spacer()
                    }
                    //InfoRow(label: "Phone", value: "+1 123-456-7890")
                }
                // MARK: Adrress Section
                Section(header: Text(Constant.addressLable)) {
                    HStack {
                        Text(user.userAddress)
                            .multilineTextAlignment(.center)
                        Spacer()
                        Button(action: {
                            // Handle button tap action here
                            changedValue = ""
                            selectedRow = Constant.addressLable
                            vm.showingAddressAlert = true
                        }) {
                            Image(systemName: Constant.editProfileIcon)
                                .foregroundColor(.gray)
                        }
                        .alert(Constant.editAlertTitle, isPresented: $vm.showingAddressAlert) {
                            TextField(Constant.addressLable, text: $changedValue)
                            Button("OK", action: submitAddress)
                        } message: {
                            Text(Constant.changeAddressMessage)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }

                LogoutButtonView()
                    .environmentObject(sessionManager)
            }
            .listStyle(.grouped)
        }
        .padding(EdgeInsets(top: 60, leading: 0, bottom: 60, trailing: 0))
    }
    // MARK: Submit information functions
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

    // MARK: - Submit Data to CK
    func submitData(type: Int) {
        let container = CloudKitViewModel.ckContainer
        let database = container.publicCloudDatabase

        switch type {
            case 0 :
                vm.userInfo[0].fullName = changedValue
            vm.userInfo.first?.record[Constant.ckUserNameRecord] = changedValue
            case 1 :
                vm.userInfo[0].userNoOfFamilyMember = Int(changedValue) ?? 0
            vm.userInfo.first?.record[Constant.ckNoOfFamilyMemberRecord] = Int(changedValue) ?? 0
            case 2 :
                vm.userInfo[0].userEmail = changedValue
            vm.userInfo.first?.record[Constant.ckUserEmailRecord] = changedValue
            case 3 :
                vm.userInfo[0].userAddress = changedValue
            vm.userInfo.first?.record[Constant.ckUserAddressRecord] = changedValue
            default :
                break
        }

        // Save the updated record
        database.save(vm.userInfo.first!.record) { (savedRecord, saveError) in
            if let saveError = saveError {
                // TODO: Show alert accordingly
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

// MARK: Infro Row
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
                .padding(.trailing, 5)
        }
    }
}

// MARK: - PREVIEW
struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(vm: ProfileViewModel())
    }
}
