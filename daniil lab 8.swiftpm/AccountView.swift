import SwiftUI

struct AccountView: View {
    @Binding var budget: Budget
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loggedIn: Bool = false
    @State private var editing: Bool = false
    @State private var monthlyIncome: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                if !loggedIn {
                    loginForm
                        .transition(.scale) // Add transition animation
                    Button("Login") {
                        performLogin()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    .transition(.opacity) // Add transition animation
                } else {
                    accountDetails
                        .transition(.slide) // Add transition animation
                }
            }
            .navigationTitle(loggedIn ? "My Account" : "Login")
        }
    }
    
    var loginForm: some View {
        Form {
            customTextField("Name", text: $name)
            customTextField("Email", text: $email)
            customSecureField("Password", text: $password)
        }
    }
    
    var accountDetails: some View {
        Form {
            Section(header: Text("Profile")) {
                Text("Name: \(name)")
                Text("Email: \(email)")
                if editing {
                    TextField("Monthly Income", text: $monthlyIncome)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(DefaultTextFieldStyle())
                } else {
                    Text("Monthly Income: \(monthlyIncome)")
                }
            }
            Section(header: Text("Budget Overview")) {
                Text("Total Income: \(formatCurrency(budget.income))")
                Text("Total Expenses: \(formatCurrency(budget.expenses))")
                Text("Balance: \(formatCurrency(budget.balance))")
                Text("Expenses as a % of Income: \(expensesAsPercentageOfIncome())%")
            }
            Button(editing ? "Save" : "Edit") {
                editing.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    // Custom text field with overlay for round corners
    func customTextField(_ placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.green, lineWidth: 1)
            )
            .padding(.horizontal, 15)
    }
    
    func customSecureField(_ placeholder: String, text: Binding<String>) -> some View {
        SecureField(placeholder, text: text)
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.green, lineWidth: 1)
            )
            .padding(.horizontal, 15)
    }
    
    func performLogin() {
        loggedIn = true
    }
    
    func expensesAsPercentageOfIncome() -> String {
        let percentage = budget.income > 0 ? (budget.expenses / budget.income * 100) : 0
        return String(format: "%.2f", percentage)
    }
    
    func formatCurrency(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: number)) ?? "$0.00"
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(budget: .constant(Budget()))
    }
}
