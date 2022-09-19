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

        let breathingNames: [String] = ["RES1", "RES2", "RES3", "RES4"]
        let breathingImages: [UIImage] = self.animateArrayImageWithArrayString(breathingNames)

        self.marcoCharacter.animationImages = breathingImages
        self.marcoCharacter.animationDuration = 1
        self.marcoCharacter.startAnimating()

    }

    private func zombieAnimation() {

        let zombieNames: [String] = ["R1", "R2", "R3", "R4", "R5", "R6"]
        let zombieImages: [UIImage] = self.animateArrayImageWithArrayString(zombieNames)

        self.zombieCharacter.animationImages = zombieImages
        self.zombieCharacter.animationDuration = 1
        self.zombieCharacter.startAnimating()

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
