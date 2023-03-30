//
//  ProfileDataFormViewModel.swift
//  Twitter Clone
//
//  Created by Vladlens Kukjans on 27/03/2023.
//

import UIKit
import Combine
import FirebaseAuth
import FirebaseStorage

class ProfileDataFormViewModel: ObservableObject {
    
    private var subscriptions: Set<AnyCancellable> = []
    
    
    @Published var displayName: String?
    @Published var userName: String?
    @Published var bio: String?
    @Published var avatarPath: String?
    @Published var imageData: UIImage?
    @Published var isFormValid: Bool = false
    @Published var url: URL?
    @Published var error: String = ""
    
    func validateUserProfileForm() {
        guard let displayName = displayName,
              displayName.count > 2,
              let userName = userName,
              userName.count > 2,
              let bio = bio,
              bio.count > 2,
              imageData != nil else {
            isFormValid = false
            return
        }
        isFormValid = true
    }
    
    func uploadAvatar() {
        
        let randomID = UUID().uuidString
        guard let imageData = imageData?.jpegData(compressionQuality: 0.5) else {return}
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        
        StorageManager.shared.uploudProfilePhoto(with: randomID, image: imageData, metaData: metaData)
            .flatMap({ metaData in
                StorageManager.shared.getDownloadedURL(with: metaData.path)
            })
            .sink { [weak self] complition in
                if case .failure(let error) = complition {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] url in
                self?.url = url
            }
            .store(in: &subscriptions)
    }
}

