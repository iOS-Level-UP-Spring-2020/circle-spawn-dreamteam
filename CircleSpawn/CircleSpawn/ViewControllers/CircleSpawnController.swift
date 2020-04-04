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
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
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
        
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(onLongTap(_ :)))
        circleView.addGestureRecognizer(longTap)
    }
    
    @objc func onTripleTap(_ tap: UITapGestureRecognizer) {
        guard let view = tap.view else { return }
        
        UIView.animate(withDuration: 0.2, animations: {
            view.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            view.alpha = 0.0
        }) { _ in
            view.removeFromSuperview()
        }
    }
    
    @objc func onLongTap(_ tap: UITapGestureRecognizer) {
        guard let view = tap.view else { return }
        
        if tap.state == .began {
            UIView.animate(withDuration: 0.2, animations: {
                view.alpha = 0.5
                view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            })
        } else if tap.state == .ended {
            UIView.animate(withDuration: 0.2, animations: {
                view.alpha = 1.0
                view.transform = .identity
            })
        }
    }
}
