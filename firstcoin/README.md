# FirstCoin - SIP-010 Fungible Token

FirstCoin is a simple, SIP-010 compliant fungible token implementation built on the Stacks blockchain using Clarity smart contracts.

## 🚀 Features

- **SIP-010 Compliant**: Fully implements the SIP-010 fungible token standard
- **Minting**: Contract owner can mint new tokens
- **Burning**: Token holders can burn their own tokens
- **Transfer**: Standard token transfer functionality with memo support
- **Contract Approval System**: Owner can approve contracts for special operations
- **Token Metadata**: Configurable token name, symbol, decimals, and URI

## 📋 Token Details

- **Name**: FirstCoin
- **Symbol**: FIRST
- **Decimals**: 6
- **Initial Supply**: 1,000,000 FIRST (1,000,000,000,000 micro-units)

## 🛠 Prerequisites

Before you begin, ensure you have the following installed:

- [Clarinet](https://docs.hiro.so/clarinet) - Stacks smart contract development tool
- [Node.js](https://nodejs.org/) - For running tests
- [Git](https://git-scm.com/) - Version control

## ⚡ Quick Start

### 1. Clone and Setup

```bash
# Navigate to the project directory
cd firstcoin

# Install dependencies
npm install
```

### 2. Check Contract Syntax

```bash
# Verify the contract syntax
clarinet check
```

### 3. Run Tests

```bash
# Run the test suite
npm test
```

### 4. Deploy to Devnet

```bash
# Deploy to local devnet
clarinet integrate
```

## 📁 Project Structure

```
firstcoin/
├── contracts/
│   └── firstcoin.clar          # Main FirstCoin contract
├── tests/
│   └── firstcoin.test.ts       # TypeScript test files
├── settings/
│   ├── Devnet.toml            # Devnet configuration
│   ├── Testnet.toml           # Testnet configuration
│   └── Mainnet.toml           # Mainnet configuration
├── Clarinet.toml              # Main project configuration
├── package.json               # Node.js dependencies
└── README.md                  # This file
```

## 🔧 Smart Contract Functions

### Public Functions

#### SIP-010 Standard Functions

- `transfer(amount, sender, recipient, memo)` - Transfer tokens between accounts
- `get-name()` - Returns the token name
- `get-symbol()` - Returns the token symbol  
- `get-decimals()` - Returns the number of decimals
- `get-balance(who)` - Returns the balance of an account
- `get-total-supply()` - Returns the total token supply
- `get-token-uri()` - Returns the token metadata URI

#### Custom Functions

- `mint(amount, recipient)` - Mint new tokens (owner only)
- `burn(amount, owner)` - Burn tokens from an account
- `set-token-uri(new-uri)` - Set the token metadata URI (owner only)
- `approve-contract(contract)` - Approve a contract for operations (owner only)
- `revoke-contract(contract)` - Revoke contract approval (owner only)

### Read-Only Functions

- `is-approved-contract(contract)` - Check if a contract is approved
- `get-contract-owner()` - Returns the contract owner address

## 🧪 Testing

The project includes comprehensive TypeScript tests using Clarinet's testing framework:

```bash
# Run all tests
npm test

# Run tests with coverage
npm run test:coverage

# Run specific test file
npm test -- firstcoin.test.ts
```

## 🚀 Deployment

### Local Devnet

```bash
# Start local devnet
clarinet integrate

# Deploy and interact with contracts
# Use the Clarinet console or web interface
```

### Testnet Deployment

1. Update your `settings/Testnet.toml` configuration
2. Use Clarinet to deploy:

```bash
clarinet publish --testnet
```

### Mainnet Deployment

1. Update your `settings/Mainnet.toml` configuration
2. Deploy to mainnet:

```bash
clarinet publish --mainnet
```

## 💡 Usage Examples

### Transfer Tokens

```clarity
;; Transfer 1000 FIRST tokens (1000000000 micro-units)
(contract-call? .firstcoin transfer u1000000000 tx-sender 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM none)
```

### Check Balance

```clarity
;; Check balance of an address
(contract-call? .firstcoin get-balance 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
```

### Mint Tokens (Owner Only)

```clarity
;; Mint 10000 FIRST tokens to an address
(contract-call? .firstcoin mint u10000000000 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
```

## 🔐 Security Features

- **Owner-only minting**: Only the contract deployer can mint new tokens
- **Self-burn capability**: Users can only burn their own tokens
- **Transfer validation**: Ensures only token owners or approved callers can transfer
- **Contract approval system**: Owner can whitelist contracts for special operations

## 📊 Error Codes

- `u100` - `err-owner-only`: Function can only be called by contract owner
- `u101` - `err-not-token-owner`: Caller is not the token owner
- `u102` - `err-insufficient-balance`: Insufficient token balance
- `u103` - `err-invalid-amount`: Invalid amount (must be greater than 0)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-feature`
3. Make your changes and add tests
4. Commit your changes: `git commit -am 'Add new feature'`
5. Push to the branch: `git push origin feature/new-feature`
6. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Resources

- [Stacks Documentation](https://docs.stacks.co/)
- [Clarity Language Reference](https://docs.stacks.co/clarity/)
- [SIP-010 Standard](https://github.com/stacksgov/sips/blob/main/sips/sip-010/sip-010-fungible-token-standard.md)
- [Clarinet Documentation](https://docs.hiro.so/clarinet/)

## 📧 Support

For questions and support, please open an issue on the GitHub repository or contact the development team.

---

**FirstCoin** - Built with ❤️ on Stacks blockchain