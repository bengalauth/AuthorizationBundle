import Foundation

func bundle_log(_ message: String) {
    let prefix = "[BengalLogin]"
    if let data = "\(prefix) \(message)\n".data(using: .utf8) {
        FileHandle.standardError.write(data)
    }
}
