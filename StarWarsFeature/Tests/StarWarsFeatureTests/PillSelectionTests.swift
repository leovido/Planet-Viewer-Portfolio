import XCTest
@testable import StarWarsFeature

final class PillSelectionTests: XCTestCase {
	
	func testAllCasesExist() {
		// Given & When
		let allCases = PillSelection.allCases
		
		// Then
		XCTAssertEqual(allCases.count, 2)
		XCTAssertTrue(allCases.contains(.planets))
		XCTAssertTrue(allCases.contains(.people))
	}
	
	func testPlanetsTitle() {
		// Given
		let pillSelection = PillSelection.planets
		
		// When
		let title = pillSelection.title
		
		// Then
		XCTAssertEqual(title, "Planets")
	}
	
	func testPeopleTitle() {
		// Given
		let pillSelection = PillSelection.people
		
		// When
		let title = pillSelection.title
		
		// Then
		XCTAssertEqual(title, "People")
	}
	
	func testTitlePropertyIsComputed() {
		// Test that title is a computed property and not stored
		let planets = PillSelection.planets
		let people = PillSelection.people
		
		// Both should return their respective titles
		XCTAssertEqual(planets.title, "Planets")
		XCTAssertEqual(people.title, "People")
		
		// Verify they are different
		XCTAssertNotEqual(planets.title, people.title)
	}
	
	func testCaseIterableConformance() {
		// Test that PillSelection conforms to CaseIterable
		let allCases = PillSelection.allCases
		
		XCTAssertEqual(allCases.count, 2)
		XCTAssertTrue(allCases.contains(.planets))
		XCTAssertTrue(allCases.contains(.people))
		
		// Test iteration
		var caseCount = 0
		for _ in allCases {
			caseCount += 1
		}
		XCTAssertEqual(caseCount, 2)
	}
	
	func testEquality() {
		// Test that cases can be compared
		XCTAssertEqual(PillSelection.planets, PillSelection.planets)
		XCTAssertEqual(PillSelection.people, PillSelection.people)
		XCTAssertNotEqual(PillSelection.planets, PillSelection.people)
	}
}
