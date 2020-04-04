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
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap(_ :)))
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(onLongTap(_ :)))
        
        doubleTap.numberOfTapsRequired = 2
        
        view.addGestureRecognizer(doubleTap)
        view.addGestureRecognizer(longTap)
    }
    
    @objc func onDoubleTap(_ doubleTap: UITapGestureRecognizer) {
        let circleView = Circle(frame: CGRect(origin: CGPoint(), size: CGSize(width: 100, height: 100)))
        circleView.center = doubleTap.location(in: view)
        circleView.alpha = 0.0
        circleView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        view.addSubview(circleView)
        
        UIView.animate(withDuration: 0.2) {
            circleView.alpha = 1.0
            circleView.transform = .identity

        }
        
        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(onTripleTap(_ :)))
        tripleTap.numberOfTapsRequired = 3
        circleView.addGestureRecognizer(tripleTap)
        
        doubleTap.require(toFail: tripleTap)
    }
    
    @objc func onTripleTap(_ tap: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.2, animations: {
            tap.view?.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            tap.view?.alpha = 0.0
        }) { _ in
            tap.view?.removeFromSuperview()
        }
    }
    
    @objc func onLongTap(_ tap: UITapGestureRecognizer) {
        
    }
}
