import Foundation

/// PError with some general error types
enum PError: LocalizedError, Equatable {
    case codingError
    case unknown
    case noData
    case serverError
    
    public var errorDescription: String? {
        switch self {
        case .codingError:
            return "L10n.Common.Error.coding"
        case .unknown:
            return "L10n.Common.Error.unknown"
        case .noData:
            return "L10n.Common.Error.noData"
        case .serverError:
            return "L10n.Common.Error.serverError"
        }
    }
}
