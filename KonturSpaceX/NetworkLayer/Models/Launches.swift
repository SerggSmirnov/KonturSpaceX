//
//  Launches.swift
//  KonturSpaceX
//
//  Created by Sergei Smirnov on 17.04.2024.
//

import Foundation

// MARK: - LaunchModelElement

struct Launches: Decodable {
    let fairings: Fairings?
    let links: Links
    let staticFireDateUTC: String?
    let staticFireDateUnix: Int?
    let net: Bool
    let window: Int?
    let rocket: Rocket
    let success: Bool?
    let failures: [Failure]
    let details: String?
    let crew, ships, capsules, payloads: [String]
    let launchpad: Launchpad
    let flightNumber: Int
    let name, dateUTC: String
    let dateUnix: Int
    let dateLocal: String?
    let datePrecision: DatePrecision
    let upcoming: Bool
    let cores: [Core]
    let autoUpdate, tbd: Bool
    let launchLibraryID: String?
    let id: String
}

// MARK: - Core

struct Core: Decodable {
    let core: String?
    let flight: Int?
    let gridfins, legs, reused, landingAttempt: Bool?
    let landingSuccess: Bool?
    let landingType: LandingType?
    let landpad: Landpad?
}

enum LandingType: String, Decodable {
    case asds = "ASDS"
    case ocean = "Ocean"
    case rtls = "RTLS"
}

enum Landpad: String, Decodable {
    case the5E9E3032383Ecb267A34E7C7 = "5e9e3032383ecb267a34e7c7"
    case the5E9E3032383Ecb554034E7C9 = "5e9e3032383ecb554034e7c9"
    case the5E9E3032383Ecb6Bb234E7CA = "5e9e3032383ecb6bb234e7ca"
    case the5E9E3032383Ecb761634E7Cb = "5e9e3032383ecb761634e7cb"
    case the5E9E3032383Ecb90A834E7C8 = "5e9e3032383ecb90a834e7c8"
    case the5E9E3033383Ecb075134E7CD = "5e9e3033383ecb075134e7cd"
    case the5E9E3033383Ecbb9E534E7Cc = "5e9e3033383ecbb9e534e7cc"
}

enum Rocket: String, Decodable {
    case the5E9D0D95Eda69955F709D1Eb = "5e9d0d95eda69955f709d1eb"
    case the5E9D0D95Eda69973A809D1Ec = "5e9d0d95eda69973a809d1ec"
    case the5E9D0D95Eda69974Db09D1Ed = "5e9d0d95eda69974db09d1ed"
}

enum DatePrecision: String, Decodable {
    case day
    case hour
    case month
    case quarter
}

// MARK: - Failure

struct Failure: Decodable {
    let time: Int
    let altitude: Int?
    let reason: String
}

// MARK: - Fairings

struct Fairings: Decodable {
    let reused, recoveryAttempt, recovered: Bool?
    let ships: [String]
}

enum Launchpad: String, Decodable {
    case the5E9E4501F509094Ba4566F84 = "5e9e4501f509094ba4566f84"
    case the5E9E4502F509092B78566F87 = "5e9e4502f509092b78566f87"
    case the5E9E4502F509094188566F88 = "5e9e4502f509094188566f88"
    case the5E9E4502F5090995De566F86 = "5e9e4502f5090995de566f86"
}

// MARK: - Links

struct Links: Decodable {
    let patch: Patch
    let reddit: Reddit
    let flickr: Flickr
    let presskit: String?
    let webcast: String?
    let youtubeID: String?
    let article: String?
    let wikipedia: String?
}

// MARK: - Flickr

struct Flickr: Decodable {
    let small: [String]
    let original: [String]
}

// MARK: - Patch

struct Patch: Decodable {
    let small, large: String?
}

// MARK: - Reddit

struct Reddit: Decodable {
    let campaign: String?
    let launch: String?
    let media, recovery: String?
}
