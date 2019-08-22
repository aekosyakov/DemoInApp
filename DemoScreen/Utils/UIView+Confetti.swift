//
//  UIView+Confetti.swift
//  DemoScreen
//
//  Copyright © 2019 Alexander Kosyakov. All rights reserved.
//

import UIKit
import AVFoundation

enum Colors {

    static let red = UIColor(hex:0xF7434C)
    static let blue = UIColor(hex: 0x3169D9)
    static let green = UIColor(hex: 0x31DF57)
    static let yellow = UIColor(hex: 0xFFDB57)

}

enum EmitterImage {
    case box, triangle, circle, swirl

    var image: UIImage? {
        switch self {
        case .box:
            return "Box".image
        case .triangle:
            return "Triangle".image
        case .circle:
            return "Circle".image
        case .swirl:
            return "Spiral".image
        }
    }

}

extension UIView {

    func displayEmitterCells() {
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: frame.size.width / 2, y: -10)
        emitter.emitterShape = .line
        emitter.emitterSize = CGSize(width: frame.size.width, height: 2)
        emitter.emitterCells = generateEmitterCells()
        layer.addSublayer(emitter)

        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { self.removeEmitterLayer() }
    }

    func removeEmitterLayer() {
        layer.sublayers?.compactMap { $0 as? CAEmitterLayer }
            .forEach {
                $0.removeAllAnimations()
                $0.removeFromSuperlayer()
            }
    }

    private
    func generateEmitterCells() -> [CAEmitterCell] {
        var colors: [UIColor] = [.red, .blue, .green, .yellow]
        var images: [EmitterImage] = [.box, .triangle, .circle, .swirl]
        var velocities: [CGFloat] = [130, 170, 150, 180]
        var cells: [CAEmitterCell] = []

        repeat {
            let randomIndex = Int(arc4random_uniform(4))
            let cell = CAEmitterCell()
            cell.birthRate = 1
            cell.lifetime = 10
            cell.velocity = velocities[randomIndex]
            cell.velocityRange = cell.velocity / 2
            cell.emissionLongitude = .pi
            cell.emissionRange = 0.5
            cell.alphaSpeed = -1.0/10
            cell.spinRange = .pi * 6
            cell.color = colors[randomIndex].cgColor
            cell.contents = images[randomIndex].image?.cgImage
            cell.scaleRange = 0.25
            cell.scale = 0.1
            cells.append(cell)
        } while cells.count < 35

        return cells
    }

}
