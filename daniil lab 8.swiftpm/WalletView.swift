import SwiftUI

struct WalletView: View {
    @Binding var budget: Budget
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Balance: \(budget.balance) KZT")
                    .font(.title)
                    .padding()
                
                NavigationLink(destination: ExpenseHistoryView(expenseHistory: budget.expenseHistory)) {
                    VStack(alignment: .leading) {
                        Text("Expenses")
                            .font(.headline)
                        ProgressBar(value: budget.expenses / (budget.expenses + budget.income))
                    }
                    .padding(.horizontal)
                }
                
                NavigationLink(destination: IncomeHistoryView(incomeHistory: budget.incomeHistory)) {
                    VStack(alignment: .leading) {
                        Text("Income")
                            .font(.headline)
                        ProgressBar(value: budget.income / (budget.expenses + budget.income))
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
            .navigationTitle("Budget")
        }
    }
}
