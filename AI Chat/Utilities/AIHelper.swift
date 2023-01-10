//
//  AIHelper.swift
//  AI Chat
//
//  Created by G2-216 on 10/01/23.
//

import Foundation
import OpenAISwift

@frozen enum Constants {
    static let API_KEY = "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"
}

final class AIHelper {
    static let shared = AIHelper()
    private init() {}
    private var client : OpenAISwift?
    
    public func openAISetup()  {
        self.client = OpenAISwift(authToken: Constants.API_KEY)
    }
    
  public  func getResponse(inputStr: String, completion: @escaping (Result<String,Error>) -> Void){
        
        client?.sendCompletion(with: inputStr, maxTokens: 1000, completionHandler: { result in
            switch result {
            case .success(let model):
                let resultStr = model.choices.first?.text ?? ""
                print(resultStr)
                completion(.success(resultStr))
                
            case .failure(let error):
                print("Failed here...")
                completion(.failure(error))
            }
        })
    }
    
    
}
