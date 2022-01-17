import Foundation

// #########################################
// ############ CREATE FILE PATH ###########
// #########################################
let fileName = "Test"
// CREATE FILE AND RETURN URL
let DocumentDirURL = try! FileManager.default.url(for: .desktopDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: true)
let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
print("FilePath: \(fileURL.path)")


// #########################################
// ########### WRITE TO FILE ###############
// #########################################
let writeString = "String that is written to the file"
do {
    try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
} catch let error as NSError {
    print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
}


// #########################################
// ########### READ FILE ###################
// #########################################
var fromFile = ""
do {
    fromFile = try String(contentsOf: fileURL)
} catch let error as NSError {
    print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
}
print("From File: \(fromFile)")
