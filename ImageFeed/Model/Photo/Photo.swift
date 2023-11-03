import UIKit

struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    let isLiked: Bool
    
    init(id: String, size: CGSize, createdAt: Date?, welcomeDescription: String?, thumbImageURL: String, largeImageURL: String, isLiked: Bool) {
        self.id = id
        self.size = size
        self.createdAt = createdAt
        self.welcomeDescription = welcomeDescription
        self.thumbImageURL = thumbImageURL
        self.largeImageURL = largeImageURL
        self.isLiked = isLiked
    }
}
//
//extension Photo {
//    init(result photo: PhotoResult) {
//        self.init(
//            id: photo.id,
//            size: CGSize(width: photo.width, height: photo.height),
//            createdAt: Date(),
//            welcomeDescription: photo.description,
//            thumbImageURL: photo.urls.thumb,
//            largeImageURL: photo.urls.full,
//            isLiked: photo.likedByUser
//        )
//    }
//}
