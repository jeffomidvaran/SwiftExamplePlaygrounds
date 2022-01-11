import UIKit

/*
     URLSession
        instance is the manager or coordinator the requests
     
     URLSessionTask
         a request is a task
         use the subclasses
*/


// ##################################
// ######### EXAMPLE 1 ##############
// ##################################
let url = URL(string: "https://bit.ly/2LMtByx")!
// using the singleton shared instance dataTask
let task = URLSession.shared.dataTask(with: url) { data, response, error in
    DispatchQueue.global(qos: .background).async {
        if let data = data {
            let _ = UIImage(data: data)
            print("finished getting image")
        } else if let error = error {
            print("HTTP Request Failed \(error)")
        }
    }
}
task.resume()



// ##################################
// ######### EXAMPLE 2 ##############
// ##################################
struct Book: Decodable {
    let title: String
    let author: String
}

// CONFIGURE THE HTTP REQUEST
let url2 = URL(string: "https://bit.ly/3sspdFO")!
var request = URLRequest(url: url2)
request.httpMethod = "GET"
request.allHTTPHeaderFields = [ "X-API-Key": "123456789" ]
request.setValue("application/json", forHTTPHeaderField: "Content-Type")

let task2 = URLSession.shared.dataTask(with: url2) { data, response, error in
    DispatchQueue.global(qos: .background).async {
        if let data = data {
            if let books = try? JSONDecoder().decode([Book].self, from: data) {
                for book in books {
                    print(book)
                }
            } else {
                print("Invalid Response")
            }
        } else if let error = error {
            print("HTTP Request Failed \(error)")
        }
    }
}
task2.resume()

