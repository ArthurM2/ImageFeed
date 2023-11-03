import XCTest
@testable import ImageFeed

final class ImageFeedTests: XCTestCase {
    func testFetchPhotos() {
        let service = ImagesListService()
        
        let expectation = self.expectation(description: "Wait for Notification")
        NotificationCenter.default.addObserver(
            forName: ImagesListService.didChangeNotification,
            object: nil,
            queue: .main) { _ in
                expectation.fulfill()
            }
        
        service.fetchPhotosNextPage(page: <#T##Int#>, completion: <#T##(Result<[PhotoResult], Error>) -> Void#>)
    }
}
