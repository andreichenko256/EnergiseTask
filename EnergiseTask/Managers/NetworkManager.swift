import Alamofire
final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
}

extension NetworkManager {
    func fetchGeoData(completion: @escaping (Result<GeoResponse, Error>) -> Void) {
        let url = K.API.ipApiUrl
        AF.request(url)
            .validate()
            .responseDecodable(of: GeoResponse.self) { response in
                switch response.result {
                case .success(let geoData):
                    completion(.success(geoData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
