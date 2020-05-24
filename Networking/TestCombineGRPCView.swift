//
//  TestCombineGRPCView.swift
//  LaguSion
//
//  Created by Abram Situmorang on 10/05/20.
//  Copyright © 2020 Abram Situmorang. All rights reserved.
//

import Combine
import SwiftUI

class TestViewModel: ObservableObject {
    // Input
    @Published var input: String = ""
    
    // Output
    @Published var response = "No Responses yet"
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var echoResponse: AnyPublisher<String, Never> {
        $input
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { $0 != "" }
            .map { input -> EchoRequest in
                return EchoRequest.with { request in
                    request.message = input
                }
            }
            .flatMap { (echoRequest) -> AnyPublisher<String, Never> in
                GRPCServiceManager.shared.executor
                    .call(GRPCServiceManager.shared.echoClient.sayItBackOnce)(echoRequest)
                    .map { (response) -> String in
                        return response.message
                    }
                    .catch { _ -> Just<String> in
                        return Just("Failed request")
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func readPropertyList() {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        var plistData: [String: AnyObject] = [:] //Our data
        let plistPath: String? = Bundle.main.path(forResource: "Info", ofType: "plist")! //the path of the data
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {//convert the data to a dictionary and handle errors.
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
            print(plistData)

        } catch {
            print("Error reading plist: \(error), format: \(propertyListFormat)")
        }
    }
    
    init() {
        readPropertyList()
        echoResponse
            .assignNoRetain(to: \.response, on: self)
            .store(in: &cancellableSet)
    }
}

struct TestCombineGRPCView: View {
    @ObservedObject private var viewModel = TestViewModel()
    
    var body: some View {
        Form {
            Section {
                TextField("Input", text: $viewModel.input)
                    .autocapitalization(.none)
            }
            Section {
                Text(viewModel.response)
            }
        }
    }
}

struct TestCombineGRPCView_Previews: PreviewProvider {
    static var previews: some View {
        TestCombineGRPCView()
    }
}
