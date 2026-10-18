//
//  AppPlatform.swift
//  ArticleUI
//
//  Created by 茅根啓介 on 2024/10/05.
//

#if !os(tvOS)
    /// A platform that an app is available on, together with the minimum OS version it requires.
    @available(iOS 18, *)
    @available(macOS 15, *)
    @available(visionOS 2, *)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    @frozen
    public enum AppPlatform: Codable, Sendable {
        case iOS(version: String)
        case macOS(version: String)
        case visionOS(version: String)
        case watchOS(version: String)
        case tvOS(version: String)

        private enum CodingKeys: String, CodingKey {
            case platform
            case version
        }

        private enum PlatformKind: String, Codable {
            case iOS
            case macOS
            case visionOS
            case watchOS
            case tvOS
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let version = try container.decodeIfPresent(String.self, forKey: .version) ?? ""
            switch try container.decode(PlatformKind.self, forKey: .platform) {
            case .iOS:
                self = .iOS(version: version)
            case .macOS:
                self = .macOS(version: version)
            case .visionOS:
                self = .visionOS(version: version)
            case .watchOS:
                self = .watchOS(version: version)
            case .tvOS:
                self = .tvOS(version: version)
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case .iOS(let version):
                try container.encode(PlatformKind.iOS, forKey: .platform)
                try container.encode(version, forKey: .version)
            case .macOS(let version):
                try container.encode(PlatformKind.macOS, forKey: .platform)
                try container.encode(version, forKey: .version)
            case .visionOS(let version):
                try container.encode(PlatformKind.visionOS, forKey: .platform)
                try container.encode(version, forKey: .version)
            case .watchOS(let version):
                try container.encode(PlatformKind.watchOS, forKey: .platform)
                try container.encode(version, forKey: .version)
            case .tvOS(let version):
                try container.encode(PlatformKind.tvOS, forKey: .platform)
                try container.encode(version, forKey: .version)
            }
        }
    }
#endif
