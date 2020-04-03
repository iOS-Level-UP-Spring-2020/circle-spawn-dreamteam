import UIKit

class CircleSpawnController: UIViewController, UIGestureRecognizerDelegate {

	override func loadView() {
		view = UIView()
		view.backgroundColor = .white
	}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGR()
    }
    
    private func setupGR() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(onTap(_ :)))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
    }
    
    @objc func onTap(_ tap: UITapGestureRecognizer) {
        let circleView = Circle(frame: CGRect(origin: CGPoint(), size: CGSize(width: 100, height: 100)))
        circleView.center = tap.location(in: view)
        
        view.addSubview(circleView)

    }
}
