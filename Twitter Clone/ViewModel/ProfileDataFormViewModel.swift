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
    @Published var error: String = ""
    @Published var isOnboardingFinished: Bool = false
    
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
                switch complition {
                    
                case .finished:
                    self?.updateUserData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] url in
                self?.avatarPath = url.absoluteString
            }
            .store(in: &subscriptions)
    }
    
    private func updateUserData() {
        guard let displayName,
              let userName,
              let bio,
              let avatarPath,
              let id = Auth.auth().currentUser?.uid else {return}
        
        let updateFields: [String: Any] = [
            "displayName": displayName,
            "userName":userName,
            "bio": bio,
            "avatarPath": avatarPath,
            "isUserOnboarded": true
        ]
        DatabaseManager.shared.collectionUsers(updateFields: updateFields, for: id)
            .sink { [weak self] complition in
                if case .failure(let error) = complition {
                    print(error.localizedDescription)
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] onboardingState in
                self?.isOnboardingFinished = onboardingState
            }
            .store(in: &subscriptions)

    }
}

