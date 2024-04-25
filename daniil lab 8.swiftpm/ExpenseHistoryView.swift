import SwiftUI

struct ExpenseHistoryView: View {
    var expenseHistory: [Double]
    
    var body: some View {
        List {
            ForEach(expenseHistory, id: \.self) { amount in
                Text("Expense: \(amount)")
            }
        }
        .navigationTitle("Expense History")
    }
}
