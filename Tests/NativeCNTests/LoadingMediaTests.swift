import SwiftUI
import XCTest

@testable import NativeCN

final class LoadingMediaTests: XCTestCase {
    func testAvatarSizesMatchExpectedScale() {
        XCTAssertEqual(CNAvatar.Size.sm.length, 32)
        XCTAssertEqual(CNAvatar.Size.md.length, 40)
        XCTAssertEqual(CNAvatar.Size.lg.length, 56)
        XCTAssertEqual(CNAvatar.Size.xl.length, 72)
    }

    func testAvatarSizesExposeFallbackTextStyles() {
        XCTAssertEqual(CNAvatar.Size.sm.textStyle, .caption)
        XCTAssertEqual(CNAvatar.Size.md.textStyle, .caption)
        XCTAssertEqual(CNAvatar.Size.lg.textStyle, .headline)
        XCTAssertEqual(CNAvatar.Size.xl.textStyle, .title3)
    }

    func testSkeletonShapeCasesCoverRequiredShapes() {
        XCTAssertEqual(CNSkeleton.Shape.allCases, [.rectangle, .roundedRectangle, .circle])
    }

    func testProgressClampsValuesIntoSupportedRange() {
        XCTAssertEqual(CNProgress.clamped(-0.5), 0)
        XCTAssertEqual(CNProgress.clamped(0.42), 0.42)
        XCTAssertEqual(CNProgress.clamped(1.5), 1)
    }

    func testProgressInstanceExposesClampedValue() {
        let progress = CNProgress(value: 1.25, label: "Upload")

        XCTAssertEqual(progress.clampedValue, 1)
    }

    func testLoadingMediaComponentsCompileTogetherInLoadingScreen() {
        _ = LoadingMediaSmokeView()
    }
}

private struct LoadingMediaSmokeView: View {
    var body: some View {
        CNThemeProvider {
            CNCard {
                CNCardHeader {
                    CNCardTitle("Loading")
                    CNCardDescription("Profile data is loading.")
                }

                CNCardContent {
                    VStack(alignment: .leading) {
                        HStack {
                            CNAvatar(fallback: "JD", size: .lg)
                            VStack(alignment: .leading) {
                                CNSkeleton(width: 160, height: 16)
                                CNSkeleton(width: 220, height: 16)
                            }
                        }

                        CNProgress(value: 0.4, label: "Profile loading progress")
                        CNSpinner(size: 20)
                    }
                }
            }
        }
    }
}
