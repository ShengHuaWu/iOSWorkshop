import Foundation
import JSONReader

let containers = try! JSONReader().readFile()
for container in containers {
    sendRequest(container.request) { result in
        switch result {
        case let .success(response):
            let expectedResponseCode = container.response.code
            if expectedResponseCode == response.code {
                print("Response is valid")
            } else {
                print("Response is invalid: expect \(expectedResponseCode) but receive \(response.code)")
            }
            
        case .failure:
            // TODO: error handling
            break
        }
    }
}

// This is a temporary solution for waiting the requests
// https://stackoverflow.com/questions/31944011/how-to-prevent-a-command-line-tool-from-exiting-before-asynchronous-operation-co
RunLoop.main.run(until: .now + 10)
