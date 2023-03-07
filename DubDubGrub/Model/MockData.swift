//
//  MockData.swift
//  DubDubGrub
//
//  Created by Jason Mitchell on 2/21/23.
//

import CloudKit

struct MockData {

    static var location: CKRecord {
        let record = CKRecord(recordType: RecordType.location)
        record[DDGLocation.kName] = "Jason's Bar and Grill"
        record[DDGLocation.kAddress] = "123 Main Street"
        record[DDGLocation.kDescription] = "This is a test description. Isn't it awesome. Not sure how long to make it to test the 3 lines. A little more should do!"
        record[DDGLocation.kWebsiteURL] = "https://jasonmitchell.io"
        record[DDGLocation.kLocation] = CLLocation(latitude: 37.331516, longitude: -121.891054)
        record[DDGLocation.kPhoneNumber] = "111-111-1111"

        return record
    }


    static var profile: CKRecord {
        let record = CKRecord(recordType: RecordType.profile)
        record[DDGProfile.kFirstName] = "Test"
        record[DDGProfile.kLastName] = "User"
        record[DDGProfile.kCompanyName] = "Best Company Ever"
        record[DDGProfile.kBio] = "This is my bio, I hope it's not too long I can't check character count."

        return record
    }
}
