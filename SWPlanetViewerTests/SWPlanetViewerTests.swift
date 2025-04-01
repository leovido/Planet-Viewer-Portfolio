//
//  SWPlanetViewerTests.swift
//  SWPlanetViewerTests
//
//  Created by Christian Ray Leovido on 01/04/2025.
//

import XCTest
@testable import SWPlanetViewer

final class SWPlanetViewerTests: XCTestCase {
	var planetsService: PlanetsProvider!
	
	override func setUpWithError() throws {
		planetsService = SWService.test
	}
	
	override func tearDownWithError() throws {
		planetsService = nil
	}
	
	func testExample() async throws {
		let planets = try! await planetsService.fetchPlanets()
		
		XCTAssertEqual(planets.count, 1)
		XCTAssertEqual(planets.planets.first!.name, "Tatooine")
	}
}
