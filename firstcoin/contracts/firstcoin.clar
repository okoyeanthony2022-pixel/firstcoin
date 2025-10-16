;; title: FirstCoin
;; version: 1.0.0
;; summary: A simple fungible token implementation for FirstCoin
;; description: FirstCoin is a basic SIP-010 compliant fungible token with minting, burning, and transfer capabilities

;; traits
;; SIP-010 trait implementation would go here when deploying to mainnet
;; (impl-trait 'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE.sip-010-trait-ft-standard.sip-010-trait)

;; token definitions
(define-fungible-token firstcoin)

;; constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))
(define-constant err-insufficient-balance (err u102))
(define-constant err-invalid-amount (err u103))

;; data vars
(define-data-var token-name (string-ascii 32) "FirstCoin")
(define-data-var token-symbol (string-ascii 10) "FIRST")
(define-data-var token-decimals uint u6)
(define-data-var token-uri (optional (string-utf8 256)) none)
(define-data-var total-supply uint u0)

;; data maps
(define-map approved-contracts principal bool)

;; public functions

;; SIP-010 Functions
(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
  (begin
    (asserts! (or (is-eq tx-sender sender) (is-eq contract-caller sender)) err-not-token-owner)
    (ft-transfer? firstcoin amount sender recipient)
  )
)

(define-public (get-name)
  (ok (var-get token-name))
)

(define-public (get-symbol)
  (ok (var-get token-symbol))
)

(define-public (get-decimals)
  (ok (var-get token-decimals))
)

(define-public (get-balance (who principal))
  (ok (ft-get-balance firstcoin who))
)

(define-public (get-total-supply)
  (ok (ft-get-supply firstcoin))
)

(define-public (get-token-uri)
  (ok (var-get token-uri))
)

;; Mint function - only contract owner can mint
(define-public (mint (amount uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (asserts! (> amount u0) err-invalid-amount)
    (ft-mint? firstcoin amount recipient)
  )
)

;; Burn function - token holder can burn their own tokens
(define-public (burn (amount uint) (owner principal))
  (begin
    (asserts! (or (is-eq tx-sender owner) (is-eq contract-caller owner)) err-not-token-owner)
    (asserts! (> amount u0) err-invalid-amount)
    (ft-burn? firstcoin amount owner)
  )
)

;; Set token URI - only contract owner
(define-public (set-token-uri (new-uri (optional (string-utf8 256))))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (var-set token-uri new-uri)
    (ok true)
  )
)

;; Approve contract for transfers
(define-public (approve-contract (contract principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (map-set approved-contracts contract true)
    (ok true)
  )
)

;; Revoke contract approval
(define-public (revoke-contract (contract principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (map-delete approved-contracts contract)
    (ok true)
  )
)

;; read only functions

(define-read-only (is-approved-contract (contract principal))
  (default-to false (map-get? approved-contracts contract))
)

(define-read-only (get-contract-owner)
  contract-owner
)

;; private functions

;; Initialize the contract with initial supply
(define-private (init)
  (begin
    (try! (ft-mint? firstcoin u1000000000000 contract-owner)) ;; Initial supply: 1,000,000 tokens (with 6 decimals)
    (var-set total-supply u1000000000000)
    (ok true)
  )
)

;; Initialize contract on deployment
(init)
