//
//  CKAsset+Ext.swift
//  DubDubGrub
//
//  Created by Jason Mitchell on 2/23/23.
//

import CloudKit
import UIKit

extension CKAsset {
    func convertToUIImage(in dimension: ImageDimension) -> UIImage {
        let placeholder = ImageDimension.getPlaceholder(for: dimension)

        guard let fileURL = self.fileURL else { return placeholder }

        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data) ?? placeholder
        } catch {
            return placeholder
        }
    }
}
