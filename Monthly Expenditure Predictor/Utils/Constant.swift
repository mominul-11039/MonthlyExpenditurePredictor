//
//  Constant.swift
//  Monthly Expenditure Predictor
//
//  Created by Md. Mominul Islam on 6/6/23.
//

import Foundation
import SwiftUI

public class Constant {
    // MARK: - App Constants
    public static let appName = "SPENDWISE"
    public static let appSlogan = """
                            The simple and efficient expense tracker app to effortlessly manage your finances on the go
                            """
    public static let appSlogan2 = "Empowering Your Financial Future"
    public static let appIcon = "ExpIcon"
    public static let forwardIcon = "chevron.forward.2"
    
    // MARK: - Scanner
    public static let appLexiconDictionary = ["rent",
                                              "utilities",
                                              "groceries",
                                              "transportation",
                                              "entertainment",
                                              "Product Name",
                                              "Product Quantity",
                                              "Total price",
                                              "Rice",
                                              "Dal",
                                              "Mango",
                                              "Fish",
                                              "Banana",
                                              "Macbook",
                                              "iPhone",
                                              "1",
                                              "XYZ",
                                              "Departmental",
                                              "Store"
    ]
   
    // MARK: - Theme
   public static let primaryBgColor = Color("PrimaryBackgroundColor")
   public static let secondaryBgColor = Color("SecondaryBackgroundColor")
   public static let listBackground = Color("listBackground")
   public static let gradientColor = Color("Gradient")
   public static let appBackground = Color("AppBackground")
   public static let gradientBG = LinearGradient(gradient: Gradient(colors: [primaryBgColor,gradientColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    // MARK: - EmptyRecordView
    public static let selectYearMonthMessage = "Please Select Year & Month"
    public static let selectYearFirstMessage = "Please select year first then month!"
    public static let noExpenseDataMessage = "No expense data available!"
    public static let emptyRecordViewIcon = "list.bullet.rectangle.fill"
    
    // MARK: - User Profile
    public static let  profileButtonIcon = "person.crop.circle"
    public static let avaterImage = "AvaterImage"
    public static let editProfileIcon = "square.and.pencil"
    public static let changeUserNameMessage = "Change User Name"
    public static let familyMemberLabel = "Family Member"
    public static let changeFamilyMemberMessage = "Change No of Family Members"
    public static let emailLable = "Email"
    public static let addressLable = "Address"
    public static let changeAddressMessage = "Change Your Address"
    public static let editAlertTitle = "Edit Info"
    public static let userNameLable =  "User Name"
    
    // MARK: - Couldkit
    public static let cloudKitContainerName = "iCloud.TeamCombine.bjitgroup.upskilldev"
    public static let ckUserNameRecord =  "user_name"
    public static let ckUserAgeRecord =   "user_age"
    public static let ckUserEmailRecord =  "user_email"
    public static let ckUserAddressRecord =  "user_address"
    public static let ckPasswordRecord  = "password"
    public static let ckConfirmPasswordRecord   = "confirm_password"
    public static let ckNoOfFamilyMemberRecord =  "no_of_family_member"
    
    public static let ckProductNameRecord =  "product_name"
    public static let ckCategoryRecord =  "category"
    public static let ckDateRecord =  "date"
    public static let ckProductPriceRecord =  "product_price"
    public static let ckProductQuantityRecord =  "product_quantity"
    
    public static let emailPredicate = "user_email == %@"
    
    public static let expUserRecordType = "expenditure_user"
    public static let expInfoRecordType = "expenditure_info"
    
    // MARK: - ScanView and Submit View
    public static let wrongAlertTitle = "Something went wrong!"
    public static let notAvailableMessage = "Internet may not be available. Please, try again later."
    public static let invalidDocumentTitle = "Invalid Document"
    public static let cameraScannerIcon = "camera.viewfinder"
    public static let invalidDocumentMessage = "The scanned document is not valid! Please try again with a valid document."
    public static let documentViewFinderIcon = "doc.viewfinder.fill"
    public static let emptyImage = "EmptyData"
    
    // MARK: - Textfield placeholder texts
    public static let emailPlaceholderText = "Email"
    public static let passwordPlaceholderText = "Password [At least 6 char]"
    public static let confirmPasswordPlaceholderText = "Confirm Password"
    
    
    // MARK: - Registration and Login
    public static let alreadyExistsAlertMessage = """
                              This email address is already registered. Please use a different email address or try logging in.
                         """
    public static let invalidEmailAlertMessage = "Invalid email or password"
    public static let dontHaveAccount = "Don't have an account?"
    public static let createAccount = "Create New Account"
    public static let wrongAlertTitle1d = "Something went wrong!"
    public static let logoutIcon = "rectangle.portrait.and.arrow.right"
    public static let loggedinUserKey = "MEP_LOGGED_IN_USER_NAME"
   
    
    // MARK: - onBoardingScreen
    public static let onBoardingScreenImage = "InitialScreenImage"
    
}
