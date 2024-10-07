//
//  Constant.swift
//
//  Created by Macky Ramirez on 10/2/24.
//
import UIKit
let blank_ = ""
enum Collection {
    static let randomStringLength = 4
    static let limit = 100
    static let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
}
enum TitleAppLabel {
    static let emptyStateTitle = "No Data"
    static let titleApp        = "Catminator"
    static let CatImage        = "CatPhoto"
}
enum CustomColor {
    static let backgroundColor = UIColor(named: "BackgroundColor")
}
enum Images {
    static let placeholder     = UIImage(named: "avatar-placeholder")
    static let emptyStateLogo  = UIImage(named: "empty-state-logo")
    static let catLogo         = UIImage(named: "catLogo")
    static let ramdomCatUrl    = "https://cataas.com/cat"
}
enum DeviceTypes {
    enum ScreenSize {
        static let width                = UIScreen.main.bounds.size.width
        static let height               = UIScreen.main.bounds.size.height
        static let maxLength            = max(ScreenSize.width, ScreenSize.height)
        static let minLength            = min(ScreenSize.width, ScreenSize.height)
    }
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale
    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale > scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0
    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}
