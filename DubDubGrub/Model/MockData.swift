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

    static var chipotle: CKRecord {
        let record = CKRecord(recordType: RecordType.location, recordID: CKRecord.ID(recordName: "C6B8834F-F380-3A8D-E506-815C263DFDCC"))
        record[DDGLocation.kName] = "Chipotle"
        record[DDGLocation.kAddress] = "1 S Market St Ste 40"
        record[DDGLocation.kDescription] = "Our local San Jose One South Market Chipotle Mexican Grill is cultivating a better world by serving responsibly sourced, classically-cooked, real food."
        record[DDGLocation.kWebsiteURL] = "https://locations.chipotle.com/ca/san-jose/1-s-market-st"
        record[DDGLocation.kLocation] = CLLocation(latitude: 37.334967, longitude: -121.892566)
        record[DDGLocation.kPhoneNumber] = "408-938-0919"

        return record
    }


    static var profile: CKRecord {
        let record = CKRecord(recordType: RecordType.profile)
        record[DDGProfile.kFirstName] = "SuperLongFirstName"
        record[DDGProfile.kLastName] = "SuperLongLastNameJunior"
        record[DDGProfile.kCompanyName] = "Super Long Company Name Incorporated"
        record[DDGProfile.kBio] = "This is my bio, I hope it's not too long I can't check character count."

        return record
    }
}
