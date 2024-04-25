import SwiftUI

struct StockView: View {
    @State private var symbol: String = ""
    @State private var price: Double?
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter stock symbol", text: $symbol)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: fetchStockPrice) {
                Text("Get Stock Price")
            }
            .buttonStyle(BorderlessButtonStyle())
            .padding()
            
            if isLoading {
                ProgressView()
                    .padding()
            } else if let price = price {
                Text("Price of \(symbol): \(price)")
                    .padding()
            }
        }
        .alert(isPresented: .constant(!errorMessage.isEmpty)) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
        .navigationTitle("Stocks")
    }
    
    private func fetchStockPrice() {
        isLoading = true
        StockAPI.shared.fetchStockPrice(for: symbol) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let stockPrice):
                    price = stockPrice
                    errorMessage = "" // Clear any previous error message
                case .failure(let error):
                    print("Failed to fetch stock price: \(error)")
                    price = nil // Ensure price is nil in case of failure
                    errorMessage = "Failed to fetch stock price. Please try again."
                }
            }
        }
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView()
    }
}
