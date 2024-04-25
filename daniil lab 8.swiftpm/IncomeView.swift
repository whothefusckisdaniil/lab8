import SwiftUI

struct IncomeView: View {
    @Binding var budget: Budget
    @State private var incomeAmount: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter income amount", text: $incomeAmount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: addIncome) {
                Text("Add Income")
            }
            .buttonStyle(BorderlessButtonStyle())
            .padding()
        }
    }
    
    
    // IncomeView
    func addIncome() {
        if let incomeValue = Double(incomeAmount) {
            budget.addIncome(amount: incomeValue) // Call addIncome method on budget
        }
        incomeAmount = ""
    }
}
