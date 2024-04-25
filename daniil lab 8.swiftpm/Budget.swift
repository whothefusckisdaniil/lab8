struct Budget {
    var balance: Double = 0.0
    var expenses: Double = 0.0
    var income: Double = 0.0
    var expenseHistory: [Double] = []
    var incomeHistory: [Double] = []
    
    mutating func addExpense(amount: Double) {
        expenses += amount
        balance -= amount
        expenseHistory.append(amount) // Updated line
    }
    
    mutating func addIncome(amount: Double) {
        income += amount
        balance += amount
        incomeHistory.append(amount) // Updated line
    }
}
