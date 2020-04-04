import UIKit

class CircleSpawnController: UIViewController, UIGestureRecognizerDelegate {

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        let doubleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.delegate = self
        view.addGestureRecognizer(doubleTapGesture)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
             shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
          return true
    }
    
    @objc func handleTap(_ tap: UITapGestureRecognizer) {
        let size: CGFloat = 100
        let circle = Circle(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        circle.center = tap.location(in: view)
        circle.backgroundColor = UIColor.randomBrightColor()
        circle.layer.cornerRadius = size * 0.5
        circle.alpha = 0
        circle.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        view.addSubview(circle)
        UIView.animate(withDuration: 0.2, animations: {
            circle.alpha = 1
            circle.transform = .identity
        })
        let longPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        let tripleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(removeCircle(_:)))
        tripleTapGesture.numberOfTapsRequired = 3
        circle.addGestureRecognizer(tripleTapGesture)
        circle.addGestureRecognizer(longPress)
    }
    
    @objc func removeCircle(_ tap: UITapGestureRecognizer) {
        guard let view: Circle = (tap.view! as? Circle) else { return  }
        UIView.animate(withDuration: 0.1, animations: {
            view.alpha = 0
            view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) {_ in
            view.removeFromSuperview()
        }
    }
    
    @objc func longPress(_ tap: UITapGestureRecognizer) {
        guard let view: Circle = (tap.view! as? Circle) else { return  }
        if tap.state == .began {
            UIView.animate(withDuration: 0.1, animations: {
                tap.view?.alpha = 0.5
                tap.view?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            })
            view.touch = tap.location(in: tap.view)
        }else if (tap.state == .changed){
            UIView.animate(withDuration: 0.1, animations: {
                tap.view!.frame.origin.x = tap.location(in: self.view).x - view.touch.x * 1.5
                tap.view!.frame.origin.y = tap.location(in: self.view).y - view.touch.y * 1.5
            })
        }else{
            UIView.animate(withDuration: 0.2, animations: {
                tap.view?.alpha = 1
                tap.view?.transform = .identity
            })
        }
    }
}
