import Foundation

struct Stock: Decodable {
    let globalQuote: GlobalQuote
    
    private enum CodingKeys: String, CodingKey {
        case globalQuote = "Global Quote"
    }
}

struct GlobalQuote: Decodable {
    let price: String
    
    private enum CodingKeys: String, CodingKey {
        case price = "05. price"
    }
}
class StockAPI {
    static let shared = StockAPI()
    
    private let apiKey = "OEKKJX31KYED28LB"
    private let baseURL = "https://www.alphavantage.co/query"
    
    func fetchStockPrice(for symbol: String, completion: @escaping (Result<Double, Error>) -> Void) {
        let urlString = "\(baseURL)?function=GLOBAL_QUOTE&symbol=\(symbol)&apikey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(Stock.self, from: data)
                let priceString = decodedData.globalQuote.price
                if let priceDouble = Double(priceString) {
                    completion(.success(priceDouble))
                } else {
                    completion(.failure(NSError(domain: "Invalid price", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
