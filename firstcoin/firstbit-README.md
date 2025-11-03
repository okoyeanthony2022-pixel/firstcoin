# FirstBit - SIP-010 Fungible Token

FirstBit is a SIP-010 compliant fungible token built with Clarity and managed in this Clarinet project.

## Token Details
- Name: FirstBit
- Symbol: FBIT
- Decimals: 6
- Initial Supply: 1,000,000 FBIT (1,000,000,000,000 micro-units) to contract owner on deploy

## Key Functions
- transfer(amount, sender, recipient, memo?)
- get-name(), get-symbol(), get-decimals()
- get-balance(principal), get-total-supply(), get-token-uri()
- mint(amount, recipient) – owner only
- burn(amount, owner)
- set-token-uri(new-uri) – owner only

## Quick Start
```bash
# From repo root
clarinet check           # Validate contracts
clarinet console         # Open REPL to interact locally
```

## Example Calls (in console)
```clarity
;; Transfer 1 FBIT (1_000_000 micro) from tx-sender to RECIPIENT
(contract-call? .firstbit transfer u1000000 tx-sender 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM none)

;; Read balance
(contract-call? .firstbit get-balance 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)

;; Mint (owner only)
(contract-call? .firstbit mint u5000000 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
```

## Deployment
- Local devnet: `clarinet integrate`
- Testnet/Mainnet: configure `settings/*.toml` and run `clarinet publish --testnet|--mainnet`
