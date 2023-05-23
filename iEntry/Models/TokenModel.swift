
import Foundation
struct tokenModel : Codable {
	let access_token : String?
	let refresh_token : String?

	enum CodingKeys: String, CodingKey {

		case access_token = "access_token"
		case refresh_token = "refresh_token"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		access_token = try values.decodeIfPresent(String.self, forKey: .access_token)
		refresh_token = try values.decodeIfPresent(String.self, forKey: .refresh_token)
	}

}
