import XCTest

@testable import NativeCN

final class NativeCNTests: XCTestCase {
    func testPackageMetadataIsAvailable() {
        XCTAssertEqual(NativeCN.packageName, "NativeCN")
        XCTAssertEqual(NativeCN.status, "Phase 9 v1 Hardening")
        XCTAssertFalse(NativeCN.isOfficialShadcnProject)
    }
}
