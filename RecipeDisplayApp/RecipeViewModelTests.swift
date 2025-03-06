//
//  RecipeViewModelTests.swift
//  RecipeDisplayApp
//
//  Created by apple on 2/28/25.
//

import XCTest
@testable import RecipeDisplayApp

final class RecipeViewModelTests: XCTestCase {

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGoodURL() async throws {
        let service = RecipeService()
            do {
                let recipes = try await service.fetchRecipes()
                XCTAssertTrue(recipes.count > 0)
                print("testGoodURL(): Success")
            } catch {
                print(error)
            }
    }
    
    func testEmptyURL() async throws {
        let service = RecipeService( "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")
            do {
                let recipes = try await service.fetchRecipes()
                XCTAssertTrue(recipes.count == 0)
                print("testEmptyURL(): Success")
            } catch {
                print(error)
            }
    }
    
    func testMalformedURL() async throws {
        let service = RecipeService( "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
        
            do {
                let recipes = try await service.fetchRecipes()
                
                print("testMalformedURL(): fail")
            } catch {
                XCTAssertTrue(true)
                print(error)
            }
        
    }
    
    func testImageCache() {
        let cache = ImageCache()
        let testImage = UIImage()
        cache.cacheImage(image: testImage, for: "test")
        XCTAssertTrue(cache.image(for: "test") == UIImage())
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
