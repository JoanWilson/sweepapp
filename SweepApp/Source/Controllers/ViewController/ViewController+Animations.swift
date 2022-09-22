//
//  ViewController+Animations.swift
//  SweepApp
//
//  Created by Nicolas Barbosa on 19/09/22.
//

import Foundation
import UIKit

extension ViewController {

    public func startAnimations() {

        self.breathingAnimation()
        self.zombieAnimation()

    }

    private func breathingAnimation() {

        let breathingNames: [String] = ["RES1", "RES2", "RES3"]
        let breathingImages: [UIImage] = self.animateArrayImageWithArrayString(breathingNames)

        self.marcoCharacter.animationImages = breathingImages
        self.marcoCharacter.animationDuration = 1
        self.marcoCharacter.startAnimating()

    }

    private func zombieAnimation() {

        let zombieNames: [String] = ["BP1", "BP2"]
        let zombieImages: [UIImage] = self.animateArrayImageWithArrayString(zombieNames)

        self.zombieCharacter.animationImages = zombieImages
        self.zombieCharacter.animationDuration = 1
        self.zombieCharacter.startAnimating()

    }

    public func doAnimate() {

        self.marcoCharacter.stopAnimating()
        let attackNames = ["AP1", "AP2", "AP3", "AP4", "AP5", "AP6"]
        let attackImages: [UIImage] = self.animateArrayImageWithArrayString(attackNames)

        attackAnimation.animationImages = attackImages
        attackAnimation.animationDuration = 0.3
        attackAnimation.animationRepeatCount = 3
        attackAnimation.startAnimating()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.27*3) {

            self.marcoCharacter.startAnimating()
        }

    }

    private func animateArrayImageWithArrayString(
        _ arrayString: [String]
    ) -> [UIImage] {

        var animatedArray: [UIImage] = []

        for index in 0..<arrayString.count {

            animatedArray.append(UIImage(named: arrayString[index])!)
        }

        return animatedArray
    }
}
