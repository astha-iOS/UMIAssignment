//
//  ParserUnitTest.swift
//  UMIAssignmentTests
//
//  Created by Astha yadav on 01/07/21.
//

import XCTest
@testable import UMIAssignment

class ParserUnitTest: XCTestCase {

    func test_paser_pase_json_correctly_to_repoSearchModel() throws {
        let json = try loadFromFile(name: "RespoSearchResponse")
        let repoSearchModel = Parser.convetToRepoSearchModel(json: json)
        XCTAssertNotNil(repoSearchModel)
        XCTAssert(repoSearchModel.totalRepo == 5113933)
        XCTAssert(repoSearchModel.repoItems.count == 2)
    }
    
    func loadFromFile(name: String, withExtension: String = "json") throws -> Dictionary<String,Any> {
       
            let bundle = Bundle(for: type(of: self))
            let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
            let data = try! Data(contentsOf: fileUrl!)
             return try JSONSerialization.jsonObject(with: data, options:.allowFragments) as! Dictionary<String,Any>
    }
}
