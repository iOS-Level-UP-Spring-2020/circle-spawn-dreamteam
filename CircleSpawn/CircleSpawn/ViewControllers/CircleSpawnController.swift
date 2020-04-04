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
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
    }

    @objc func onDoubleTap(_ doubleTap: UITapGestureRecognizer) {
        let circleView = createCircleView(doubleTap)

        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(onTripleTap(_:)))
        tripleTap.numberOfTapsRequired = 3
        circleView.addGestureRecognizer(tripleTap)

        doubleTap.require(toFail: tripleTap)

        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(onLongTap(_:)))
        circleView.addGestureRecognizer(longTap)
    }

    private func createCircleView(_ doubleTap: UITapGestureRecognizer) -> CircleView {
        let circleView = CircleView()
        circleView.center = doubleTap.location(in: view)
        circleView.alpha = 0.0
        circleView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        view.addSubview(circleView)

        UIView.animate(withDuration: 0.2, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, animations: {
            circleView.alpha = 1.0
            circleView.transform = .identity
        })

        return circleView
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

    private var beginTapLocations: [UIView: CGPoint] = [:]

    @objc func onLongTap(_ longTap: UITapGestureRecognizer) {
        guard let circleView = longTap.view else { return }

        switch longTap.state {
        case .possible:
            print("Default state")
        case .began:
            beginTapLocations[circleView] = longTap.location(in: self.view)

            UIView.animate(withDuration: 0.2, animations: {
                circleView.alpha = 0.5
                circleView.transform = CGAffineTransform.moveScaled()
            })
        case .changed:
            let loc = longTap.location(in: self.view)
            let beginLocation = beginTapLocations[circleView]!
            let translation = CGPoint(x: loc.x - beginLocation.x, y: loc.y - beginLocation.y)

            circleView.transform = CGAffineTransform(translationX: translation.x, y: translation.y).moveScaled()
        case .ended:
            let loc = longTap.location(in: self.view)
            let beginLocation = beginTapLocations[circleView]!
            let translation = CGPoint(x: loc.x - beginLocation.x, y: loc.y - beginLocation.y)
            beginTapLocations.removeValue(forKey: circleView)

            circleView.transform = CGAffineTransform.moveScaled()
            circleView.center = circleView.center.applying(CGAffineTransform(translationX: translation.x, y: translation.y))

            UIView.animate(withDuration: 0.2, animations: {
                circleView.alpha = 1.0
                circleView.transform = .identity
            })
        case .cancelled, .failed:
            beginTapLocations.removeValue(forKey: circleView)
            UIView.animate(withDuration: 0.2, animations: {
                circleView.alpha = 1.0
                circleView.transform = .identity
            })
            @unknown default:
            beginTapLocations.removeValue(forKey: circleView)
            print("UIGestureRecognizer.State may have additional unknown values, possibly added in future versions")
        }
    }
}

private extension CGAffineTransform {

    static func moveScaled() -> CGAffineTransform {
        return identity.moveScaled()
    }

    func moveScaled() -> CGAffineTransform {
        return scaledBy(x: 1.3, y: 1.3)
    }
}
