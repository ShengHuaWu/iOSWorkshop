import Foundation
import JSONReader

let containers = try! JSONReader().readFile()

for container in containers {
    let request = container.request
    let urlString = "https://api.stripe.com" + request.url + "?" + request.body
    let url = URL(string: urlString)!
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method
    urlRequest.allHTTPHeaderFields = request.headers
        
    URLSession.shared.dataTask(with: urlRequest) { _, response, error in
        if let error = error {
            print("Error occurs when calling \(url) with body: \(request.body): \(error.localizedDescription)")
            return
        }
        
        guard let httpURLResposne = response as? HTTPURLResponse else {
            print("Response type is invalid")
            return
        }
        
        let code = httpURLResposne.statusCode
        let expectedResponseCode = container.response.code
        if expectedResponseCode == code {
            print("Response of \(url) is valid")
        } else {
            print("Response of \(url) is invalid: expect \(expectedResponseCode) but receive \(code)")
        }
    }.resume()
}

// This is a temporary solution for waiting the requests
// https://stackoverflow.com/questions/31944011/how-to-prevent-a-command-line-tool-from-exiting-before-asynchronous-operation-co
RunLoop.main.run(until: .now + 20)
