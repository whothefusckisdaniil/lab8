import SwiftUI

struct IncomeHistoryView: View {
    var incomeHistory: [Double]
    
    var body: some View {
        List {
            ForEach(incomeHistory, id: \.self) { amount in
                Text("Income: \(amount)")
            }
        }
        .navigationTitle("Income History")
    }
}
