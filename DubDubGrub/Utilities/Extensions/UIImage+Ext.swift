//
//  UIImage+Ext.swift
//  DubDubGrub
//
//  Created by Jason Mitchell on 2/24/23.
//

import CloudKit
import UIKit

extension UIImage {

    func convertToCKAsset() -> CKAsset? {

        guard let urlPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = urlPath.appendingPathComponent("selectedAvatarImage")
        guard let imageData = jpegData(compressionQuality: 0.25) else { return nil }

        do {
            try imageData.write(to: fileURL)
            return CKAsset(fileURL: fileURL)
        } catch {
            return nil
        }
    }
}
