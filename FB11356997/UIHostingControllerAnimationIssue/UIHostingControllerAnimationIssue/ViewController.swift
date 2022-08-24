import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    private static let width = CGFloat(200)
    private static let minHeight = CGFloat(200)
    private static let maxHeight = CGFloat(400)
    
    private lazy var containerView = UIView()
    
    private lazy var hostingController: UIViewController = {
        let rootView = ZStack {
            Color.red
            Image(systemName: "hand.tap")
                .foregroundColor(.white)
                .font(.system(size: 50))
        }
        
        let hostingController = UIHostingController(rootView: rootView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .systemGray3
        return hostingController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // (1) Container View
        view.addSubview(containerView)
        
        containerView.frame = CGRect(
            x: view.bounds.width/2 - Self.width/2,
            y: view.bounds.height/2 - Self.maxHeight/2,
            width: Self.width,
            height: Self.minHeight
        )
        
        // (2) Hosting Controller
        self.addChild(hostingController)
        containerView.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: hostingController.view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: hostingController.view.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: hostingController.view.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
        ])
        
        hostingController.didMove(toParent: self)
        
        // (3) Gesture Recognizer
        view.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(didTap)
        ))
    }
    
    @objc private func didTap() {
        let animator = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.333)
        
        animator.addAnimations {
            if self.containerView.frame.size.height == Self.minHeight {
                self.containerView.frame.size.height = Self.maxHeight
            } else {
                self.containerView.frame.size.height = Self.minHeight
            }
        }
        
        animator.startAnimation()
    }

}
