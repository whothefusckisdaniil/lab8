import SwiftUI

struct ContentView: View {
    @State var budget = Budget()
    
    var body: some View {
        TabView {
            WalletView(budget: $budget)
                .tabItem {
                    Label("Wallet", systemImage: "wallet.pass.fill")
                }
            ExpensesView(budget: $budget)
                .tabItem {
                    Label("Expenses", systemImage: "minus.circle.fill")
                }
            IncomeView(budget: $budget)
                .tabItem {
                    Label("Income", systemImage: "plus.circle.fill")
                }
            StockView() // Assuming StockView does not require a Budget
                .tabItem {
                    Label("Stocks", systemImage: "chart.bar.fill")
                }
            AccountView(budget: $budget)
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
        }
    }
}
