/*
 Abstract:
 Defines a data structure for AIC Objects
 (generally artworks)
*/

import Foundation

struct AICObjectModel {
    // MARK: Properties
    let nid: Int
    
    let thumbnailUrl:URL
    let thumbnailCropRect: CGRect?
    let imageUrl:URL
    let imageCropRect: CGRect?
    let title: String
    
    let audioFiles:[AICAudioFileModel]?
    let audioGuideIDs:[Int]?
    
    let tombstone:String?
    let credits:String?
    
    let imageCopyright:String?
        
    let location:CoordinateWithFloor
}
