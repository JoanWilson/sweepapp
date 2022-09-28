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

    public func breathingAnimation() {

        let breathingNames: [String] = ["RES1", "RES2", "RES3"]
        let breathingImages: [UIImage] = self.animateArrayImageWithArrayString(breathingNames)

        self.marcoCharacter.animationImages = breathingImages
        self.marcoCharacter.animationDuration = 1
        self.marcoCharacter.startAnimating()

    }

    public func zombieAnimation() {

        let zombieNames: [String] = ["BP1", "BP2"]
        let zombieImages: [UIImage] = self.animateArrayImageWithArrayString(zombieNames)

            self.zombieCharacter.animationImages = zombieImages
            self.zombieCharacter.animationDuration = 1
            self.zombieCharacter.startAnimating()

            if self.viewModel.getUncompletedArray().isEmpty == true {

                self.zombieCharacter.stopAnimating()
            }

    }

    public func doAnimate() {

        let attackNames = ["AP1", "AP2", "AP3", "AP4", "AP5", "AP6"]
        let attackImages: [UIImage] = self.animateArrayImageWithArrayString(attackNames)

        self.marcoCharacter.stopAnimating()
        attackAnimation.animationImages = attackImages
        attackAnimation.animationDuration = 0.3
        attackAnimation.animationRepeatCount = 3
        attackAnimation.startAnimating()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.27*3) {

            self.marcoCharacter.startAnimating()
        }

    }

    public func zombieDeath() {

        let deathNames: [String] = ["dp1", "dp2", "dp3", "dp4", "dp5", "dp6",
                                    "dp7", "dp8", "dp9", "dp10", "dp11", "dp12"]
        let deathImages: [UIImage] = self.animateArrayImageWithArrayString(deathNames)

        if viewModel.getUncompletedArray().isEmpty == true {

            self.zombieCharacter.stopAnimating()
            self.deathAnimation.animationImages = deathImages
            self.deathAnimation.animationDuration = 1
            self.deathAnimation.animationRepeatCount = 1
            self.deathAnimation.startAnimating()
        }

    }

    public func zombieRise() {

        let riseNames: [String] = ["rp1", "rp2", "rp3", "rp4", "rp6", "rp7", "rp8", "rp9"]
        let riseImages: [UIImage] = self.animateArrayImageWithArrayString(riseNames)

            self.riseAnimation.animationImages = riseImages
            self.riseAnimation.animationDuration = 0.7
            self.riseAnimation.animationRepeatCount = 1
            self.riseAnimation.startAnimating()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.zombieAnimation()
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
