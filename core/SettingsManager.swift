import Foundation

class BengalSettings {
    static let shared = BengalSettings()

    let avatarPath: String? = nil
    let bgPath: String? = nil
    let bgType: String = "image"
    let bgScaling: String = "fill"
    let cardTransparency: Double = 0.82
    let clockAngle: Double = 270.0
    let clockColor: String = "#FFFFFF|#E0E0E0"
    let clockSize: Int = 22
    let loginButtonAngle: Double = 270.0
    let loginButtonColor: String = "#517DF4|#375DFC"
    let powerButtonBGAngle: Double = 270.0
    let powerButtonBGColor: String = "#000000|#2A2A2A"
    let powerButtonIconAngle: Double = 0.0
    let powerButtonIconColor: String = "#FFFFFF"
    let powerButtonsTransparency: Double = 0.33
    let uiMode: String = "default"
}
