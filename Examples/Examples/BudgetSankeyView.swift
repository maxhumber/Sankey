import SwiftUI

struct Stock: Identifiable, Hashable {
    let id = UUID()
    var label: String = ""
    var color: Color = .random()
}

struct Flow: Identifiable {
    let id = UUID()
    var from: Stock?
    var to: Stock?
    var amount: String = ""
}

extension Color {
    static func random() -> Color {
        Color(hue: Double.random(in: 0...1), saturation: 0.8, brightness: 0.9)
    }
}

enum BudgetSankeyError: Error, LocalizedError {
    case duplicateAccount
    case sameAccountFlow
    case invalidFlowAmount
    
    var errorDescription: String? {
        switch self {
        case .duplicateAccount: "Account names must be unique."
        case .sameAccountFlow: "You must select different accounts for a flow."
        case .invalidFlowAmount: "Amount must be a valid positive number."
        }
    }
}

@Observable
class BudgetSankeyViewModel {
    var accounts: [Stock] = []
    var flows: [Flow] = []
    var newAccount: Stock = .init()
    var newFlow: Flow = .init()
    var alertMessage: String?
    
    func addAccount() {
        do {
            try validate(newAccount)
            accounts.append(newAccount)
            newAccount = .init()
        } catch {
            alertMessage = error.localizedDescription
        }
    }
    
    private func validate(_ newAccount: Stock) throws {
        guard !accounts.contains(where: { $0.label.lowercased() == newAccount.label.lowercased() }) else {
            throw BudgetSankeyError.duplicateAccount
        }
    }
    
    func deleteAccount(at offsets: IndexSet) {
        accounts.remove(atOffsets: offsets)
    }
    
    func addFlow() {
        do {
            try validate(newFlow)
            guard let amount = Double(newFlow.amount), amount > 0 else {
                throw BudgetSankeyError.invalidFlowAmount
            }
            flows.append(newFlow)
            newFlow = .init()
        } catch {
            alertMessage = error.localizedDescription
        }
    }
    
    private func validate(_ newFlow: Flow) throws {
        guard let from = newFlow.from, let to = newFlow.to, from.id != to.id else {
            throw BudgetSankeyError.sameAccountFlow
        }
    }
    
    func deleteFlow(at offsets: IndexSet) {
        flows.remove(atOffsets: offsets)
    }
}

struct BudgetSankeyView: View {
    @State private var viewModel = BudgetSankeyViewModel()
    
    var body: some View {
        content
            .alert("Error", isPresented: .constant(viewModel.alertMessage != nil)) {
                Button("OK", role: .cancel) { viewModel.alertMessage = nil }
            } message: {
                Text(viewModel.alertMessage ?? "No Error")
            }
    }
    
    private var content: some View {
        VStack {
            HStack {
                TextField("Enter account name", text: $viewModel.newAccount.label)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Add Account") {
                    viewModel.addAccount()
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.newAccount.label.isEmpty)
            }
            HStack {
                Picker("From", selection: $viewModel.newFlow.from) {
                    ForEach(viewModel.accounts, id: \.id) { account in
                        Text(account.label)
                            .tag(account as Stock?)
                    }
                    Text("None")
                        .tag(nil as Stock?)
                }
                .pickerStyle(.menu)
                Picker("To", selection: $viewModel.newFlow.to) {
                    ForEach(viewModel.accounts, id: \.id) { account in
                        Text(account.label)
                            .tag(account as Stock?)
                    }
                    Text("None")
                        .tag(nil as Stock?)
                }
                .pickerStyle(.menu)
                TextField("Amount", text: $viewModel.newFlow.amount)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 100)
                Button("Add Flow") {
                    viewModel.addFlow()
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.newFlow.from == nil || viewModel.newFlow.to == nil || viewModel.newFlow.amount.isEmpty)
            }
            List {
                ForEach($viewModel.accounts) { $account in
                    HStack {
                        Text(account.label)
                        ColorPicker("", selection: $account.color, supportsOpacity: false)
                            .labelsHidden()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                    }
                }
                .onDelete(perform: viewModel.deleteAccount)
                ForEach(viewModel.flows) { flow in
                    HStack {
                        Text("\(flow.from?.label ?? "") → \(flow.to?.label ?? "")")
                        Spacer()
                        Text("\(flow.amount)")
                    }
                }
                .onDelete(perform: viewModel.deleteFlow)
            }
            .listStyle(.inset)
        }
    }
}

#Preview {
    BudgetSankeyView()
}
