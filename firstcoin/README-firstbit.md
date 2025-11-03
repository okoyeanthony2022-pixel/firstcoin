# FirstBit - SIP-010 Fungible Token

FirstBit is a simple, SIP-010 compliant fungible token built on the Stacks blockchain using Clarity and developed with Clarinet.

## 🚀 Features

- SIP-010-compliant interface
- Owner-only minting
- Self-burn by token holders
- Standard transfers with optional memo
- Token metadata: name, symbol, decimals, and token URI

## 📋 Token Details

- Name: FirstBit
- Symbol: FBIT
- Decimals: 6
- Initial Supply: 1,000,000 FBIT (1,000,000,000,000 micro-units) minted to deployer

## 🛠 Prerequisites

- Clarinet — Stacks smart contract toolchain
- Node.js (optional, for tests)
- Git (optional)

## ⚡ Quick Start

```bash
# From the repo root
clarinet check         # Verify contract syntax
clarinet console       # Open REPL to interact locally
clarinet integrate     # Spin up local devnet and deploy
```

## 📁 Project Structure (relevant)

```
contracts/
  firstbit.clar        # FirstBit token contract
Clarinet.toml          # Project configuration (includes firstbit)
README-firstbit.md     # This file
```

## 🔧 Smart Contract Functions

SIP-010 standard:
- transfer(amount, sender, recipient, memo) -> (response bool uint)
- get-name() -> (response (string-ascii 32) uint)
- get-symbol() -> (response (string-ascii 10) uint)
- get-decimals() -> (response uint uint)
- get-balance(who) -> (response uint uint)
- get-total-supply() -> (response uint uint)
- get-token-uri() -> (response (optional (string-utf8 256)) uint)

Custom admin/user:
- mint(amount, recipient) -> (response bool uint)           # owner only
- burn(amount, owner) -> (response bool uint)
- set-token-uri(new-uri) -> (response bool uint)            # owner only

## 🧪 Example Usage (Clarinet console)

```clarity
;; Transfer 1,000 FBIT (1,000,000,000 micro-units)
(contract-call? .firstbit transfer u1000000000 tx-sender 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM none)

;; Balance query
(contract-call? .firstbit get-balance 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)

;; Mint (deployer only)
(contract-call? .firstbit mint u10000000000 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)

;; Set token URI (deployer only)
(contract-call? .firstbit set-token-uri (some "https://example.com/fbit.json"))
```

## 🚀 Deployment

- Local: `clarinet integrate`
- Testnet/Mainnet: configure `settings/Testnet.toml` or `settings/Mainnet.toml` and run `clarinet publish` with the appropriate flag.

## 📄 License

MIT (see repository license).
