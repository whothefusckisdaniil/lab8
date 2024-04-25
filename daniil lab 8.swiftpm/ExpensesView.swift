import SwiftUI

struct ExpensesView: View {
    @Binding var budget: Budget
    @State private var expenseAmount: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter expense amount", text: $expenseAmount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: addExpense) {
                Text("Add Expense")
            }
            .buttonStyle(BorderlessButtonStyle())
            .padding()
        }
    }
    
    func addExpense() {
        if let expenseValue = Double(expenseAmount) {
            budget.addExpense(amount: expenseValue) // Call addExpense method on budget
        }
        expenseAmount = ""
    }
}
