struct GeoResponse: Decodable {
    let status: String
    let country: String
    let countryCode: String
    let region: String
    let regionName: String
    let city: String
    let zip: String
    let lat: Double
    let lon: Double
    let timezone: String
    let isp: String
    let org: String
    let asDescription: String
    let query: String

    private enum CodingKeys: String, CodingKey {
        case status, country, countryCode, region, regionName, city, zip, lat, lon, timezone, isp, org, query
        case asDescription = "as"
    }
}
