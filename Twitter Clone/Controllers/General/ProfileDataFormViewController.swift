//
//  ProfileDataFormViewController.swift
//  Twitter Clone
//
//  Created by Vladlens Kukjans on 26/03/2023.
//

import UIKit

class ProfileDataFormViewController: UIViewController {
    
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.alwaysBounceVertical = true
        scroll.keyboardDismissMode = .onDrag
        scroll.translatesAutoresizingMaskIntoConstraints = true
        return scroll
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        addConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.frame = view.bounds
        
    }

}
extension ProfileDataFormViewController {
    func addConstraints() {
        NSLayoutConstraint.activate([
        
        
        ]
        )
    }
}
