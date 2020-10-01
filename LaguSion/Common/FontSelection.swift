//
//  FontSelection.swift
//  Common
//
//  Created by Abram Situmorang on 02/08/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import SwiftUI

fileprivate let fontSize: CGFloat = 17

public enum FontSelection: String, CaseIterable {
    case normal = "Default"
    case avenir = "Avenir"
    case avenirNext = "Avenir Next"
    case avenirNextCondensed = "Avenir Next Condensed"
    case georgia = "Georgia"
    case helvetica = "Helvetica"
    case helveticaNeue = "Helvetica Neue"
    case baskerville = "Baskerville"
    case americanTypeWriter = "American Typewriter"
    case futura = "Futura"
    case verdana = "Verdana"
    case gillsans = "Gill Sans"
    
    public var font: Font? {
        switch self {
        case .normal:
            return nil//Font.system(size: self.fontSize)
        case .avenir:
            return Font.custom("Avenir", size: fontSize)
        case .avenirNext:
            return Font.custom("AvenirNext-Regular", size: fontSize)
        case .avenirNextCondensed:
            return Font.custom("AvenirNextCondensed-Regular", size: fontSize)
        case .georgia:
            return Font.custom("Georgia", size: fontSize)
        case .helvetica:
            return Font.custom("Helvetica-Light", size: fontSize)
        case .helveticaNeue:
            return Font.custom("HelveticaNeue-Light", size: fontSize)
        case .baskerville:
            return Font.custom("Baskerville", size: fontSize)
        case .americanTypeWriter:
            return Font.custom("AmericanTypewriter", size: fontSize)
        case .futura:
            return Font.custom("Futura-Medium", size: fontSize)
        case .verdana:
            return Font.custom("Verdana", size: fontSize)
        case .gillsans:
            return Font.custom("GillSans", size: fontSize)
        }
    }
}

//Font selection:
//Copperplate-Light
//Copperplate
//Copperplate-Bold
//AppleSDGothicNeo-Thin
//AppleSDGothicNeo-Light
//AppleSDGothicNeo-Regular
//AppleSDGothicNeo-Bold
//AppleSDGothicNeo-SemiBold
//AppleSDGothicNeo-UltraLight
//AppleSDGothicNeo-Medium
//Thonburi
//Thonburi-Light
//Thonburi-Bold
//GillSans-Italic
//GillSans-SemiBold
//GillSans-UltraBold
//GillSans-Light
//GillSans-Bold
//GillSans
//GillSans-SemiBoldItalic
//GillSans-BoldItalic
//GillSans-LightItalic
//MarkerFelt-Thin
//MarkerFelt-Wide
//HiraMaruProN-W4
//CourierNewPS-ItalicMT
//CourierNewPSMT
//CourierNewPS-BoldItalicMT
//CourierNewPS-BoldMT
//KohinoorTelugu-Regular
//KohinoorTelugu-Medium
//KohinoorTelugu-Light
//AvenirNextCondensed-Heavy
//AvenirNextCondensed-MediumItalic
//AvenirNextCondensed-Regular
//AvenirNextCondensed-UltraLightItalic
//AvenirNextCondensed-Medium
//AvenirNextCondensed-HeavyItalic
//AvenirNextCondensed-DemiBoldItalic
//AvenirNextCondensed-Bold
//AvenirNextCondensed-DemiBold
//AvenirNextCondensed-BoldItalic
//AvenirNextCondensed-Italic
//AvenirNextCondensed-UltraLight
//TamilSangamMN
//TamilSangamMN-Bold
//HelveticaNeue-UltraLightItalic
//HelveticaNeue-Medium
//HelveticaNeue-MediumItalic
//HelveticaNeue-UltraLight
//HelveticaNeue-Italic
//HelveticaNeue-Light
//HelveticaNeue-ThinItalic
//HelveticaNeue-LightItalic
//HelveticaNeue-Bold
//HelveticaNeue-Thin
//HelveticaNeue-CondensedBlack
//HelveticaNeue
//HelveticaNeue-CondensedBold
//HelveticaNeue-BoldItalic
//TimesNewRomanPS-ItalicMT
//TimesNewRomanPS-BoldItalicMT
//TimesNewRomanPS-BoldMT
//TimesNewRomanPSMT
//Georgia-BoldItalic
//Georgia-Italic
//Georgia
//Georgia-Bold
//SinhalaSangamMN-Bold
//SinhalaSangamMN
//ArialRoundedMTBold
//Kailasa-Bold
//Kailasa
//KohinoorDevanagari-Regular
//KohinoorDevanagari-Light
//KohinoorDevanagari-Semibold
//KohinoorBangla-Regular
//KohinoorBangla-Semibold
//KohinoorBangla-Light
//NotoSansOriya-Bold
//NotoSansOriya
//ChalkboardSE-Bold
//ChalkboardSE-Light
//ChalkboardSE-Regular
//NotoSansKannada-Bold
//NotoSansKannada-Light
//NotoSansKannada-Regular
//AppleColorEmoji
//PingFangTC-Regular
//PingFangTC-Thin
//PingFangTC-Medium
//PingFangTC-Semibold
//PingFangTC-Light
//PingFangTC-Ultralight
//GeezaPro-Bold
//GeezaPro
//DamascusBold
//DamascusLight
//Damascus
//DamascusMedium
//DamascusSemiBold
//Noteworthy-Bold
//Noteworthy-Light
//Avenir-Oblique
//Avenir-HeavyOblique
//Avenir-Heavy
//Avenir-BlackOblique
//Avenir-BookOblique
//Avenir-Roman
//Avenir-Medium
//Avenir-Black
//Avenir-Light
//Avenir-MediumOblique
//Avenir-Book
//Avenir-LightOblique
//KohinoorGujarati-Light
//KohinoorGujarati-Bold
//KohinoorGujarati-Regular
//DiwanMishafi
//AcademyEngravedLetPlain
//PartyLetPlain
//Futura-CondensedExtraBold
//Futura-Medium
//Futura-Bold
//Futura-CondensedMedium
//Futura-MediumItalic
//ArialHebrew-Bold
//ArialHebrew-Light
//ArialHebrew
//Farah
//MuktaMahee-Light
//MuktaMahee-Bold
//MuktaMahee-Regular
//NotoSansMyanmar-Regular
//NotoSansMyanmar-Bold
//NotoSansMyanmar-Light
//Arial-BoldMT
//Arial-BoldItalicMT
//Arial-ItalicMT
//ArialMT
//Chalkduster
//Kefa-Regular
//HoeflerText-Italic
//HoeflerText-Black
//HoeflerText-Regular
//HoeflerText-BlackItalic
//Optima-ExtraBlack
//Optima-BoldItalic
//Optima-Italic
//Optima-Regular
//Optima-Bold
//Galvji-Bold
//Galvji
//Palatino-Italic
//Palatino-Roman
//Palatino-BoldItalic
//Palatino-Bold
//MalayalamSangamMN-Bold
//MalayalamSangamMN
//AlNile
//AlNile-Bold
//LaoSangamMN
//BradleyHandITCTT-Bold
//HiraMinProN-W3
//HiraMinProN-W6
//PingFangHK-Medium
//PingFangHK-Thin
//PingFangHK-Regular
//PingFangHK-Ultralight
//PingFangHK-Semibold
//PingFangHK-Light
//Helvetica-Oblique
//Helvetica-BoldOblique
//Helvetica
//Helvetica-Light
//Helvetica-Bold
//Helvetica-LightOblique
//Courier-BoldOblique
//Courier-Oblique
//Courier
//Courier-Bold
//Cochin-Italic
//Cochin-Bold
//Cochin
//Cochin-BoldItalic
//TrebuchetMS-Bold
//TrebuchetMS-Italic
//Trebuchet-BoldItalic
//TrebuchetMS
//DevanagariSangamMN
//DevanagariSangamMN-Bold
//Rockwell-Italic
//Rockwell-Regular
//Rockwell-Bold
//Rockwell-BoldItalic
//SnellRoundhand
//SnellRoundhand-Bold
//SnellRoundhand-Black
//ZapfDingbatsITC
//BodoniSvtyTwoITCTT-Bold
//BodoniSvtyTwoITCTT-BookIta
//BodoniSvtyTwoITCTT-Book
//Verdana-Italic
//Verdana
//Verdana-Bold
//Verdana-BoldItalic
//AmericanTypewriter-CondensedBold
//AmericanTypewriter-Condensed
//AmericanTypewriter-CondensedLight
//AmericanTypewriter
//AmericanTypewriter-Bold
//AmericanTypewriter-Semibold
//AmericanTypewriter-Light
//AvenirNext-Medium
//AvenirNext-DemiBoldItalic
//AvenirNext-DemiBold
//AvenirNext-HeavyItalic
//AvenirNext-Regular
//AvenirNext-Italic
//AvenirNext-MediumItalic
//AvenirNext-UltraLightItalic
//AvenirNext-BoldItalic
//AvenirNext-Heavy
//AvenirNext-Bold
//AvenirNext-UltraLight
//Baskerville-SemiBoldItalic
//Baskerville-SemiBold
//Baskerville-BoldItalic
//Baskerville
//Baskerville-Bold
//Baskerville-Italic
//KhmerSangamMN
//Didot-Bold
//Didot
//Didot-Italic
//SavoyeLetPlain
//BodoniOrnamentsITCTT
//Symbol
//Charter-BlackItalic
//Charter-Bold
//Charter-Roman
//Charter-Black
//Charter-BoldItalic
//Charter-Italic
//Menlo-BoldItalic
//Menlo-Bold
//Menlo-Italic
//Menlo-Regular
//NotoNastaliqUrdu
//NotoNastaliqUrdu-Bold
//BodoniSvtyTwoSCITCTT-Book
//DINAlternate-Bold
//Papyrus-Condensed
//Papyrus
//HiraginoSans-W3
//HiraginoSans-W6
//HiraginoSans-W7
//PingFangSC-Medium
//PingFangSC-Semibold
//PingFangSC-Light
//PingFangSC-Ultralight
//PingFangSC-Regular
//PingFangSC-Thin
//MyanmarSangamMN
//MyanmarSangamMN-Bold
//AppleSymbols
//Zapfino
//BodoniSvtyTwoOSITCTT-BookIt
//BodoniSvtyTwoOSITCTT-Book
//BodoniSvtyTwoOSITCTT-Bold
//EuphemiaUCAS
//EuphemiaUCAS-Italic
//EuphemiaUCAS-Bold
//DINCondensed-Bold

