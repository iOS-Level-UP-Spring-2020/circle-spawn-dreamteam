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
    
    @objc func onTripleTap(_ tripleTap: UITapGestureRecognizer) {
        guard let view = tripleTap.view else { return }
        
        UIView.animate(withDuration: 0.2, animations: {
            view.alpha = 0.0
            view.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }) { _ in
            view.removeFromSuperview()
        }
    }
    
    var diffPoint: CGPoint = .zero

    @objc func onLongTap(_ longTap: UITapGestureRecognizer) {
        guard let circleView = longTap.view else { return }
        
        if longTap.state == .began {
            let trans = CGAffineTransform(translationX: -circleView.bounds.midX, y: -circleView.bounds.midY)
            diffPoint = longTap.location(in: circleView).applying(trans)

            UIView.animate(withDuration: 0.2, animations: {
                circleView.alpha = 0.5
                circleView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            })
        } else if longTap.state == .changed {
            let loc = longTap.location(in: view)
            circleView.center = loc.applying(CGAffineTransform(translationX: -diffPoint.x, y: -diffPoint.y))
        } else if longTap.state == .ended {
            UIView.animate(withDuration: 0.2, animations: {
                circleView.alpha = 1.0
                circleView.transform = .identity
            })
        }
    }
}
