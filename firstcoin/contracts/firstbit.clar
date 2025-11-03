;; title: FirstBit
;; version: 1.0.0
;; summary: A SIP-010 compliant fungible token implementation for FirstBit
;; description: FirstBit is a basic fungible token with minting, burning, transfer, and metadata functions.

;; token definition
(define-fungible-token firstbit)

;; constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))
(define-constant err-insufficient-balance (err u102))
(define-constant err-invalid-amount (err u103))

;; metadata
(define-data-var token-name (string-ascii 32) "FirstBit")
(define-data-var token-symbol (string-ascii 10) "FBIT")
(define-data-var token-decimals uint u6)
(define-data-var token-uri (optional (string-utf8 256)) none)

;; SIP-010 required functions
(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
  (begin
    (asserts! (or (is-eq tx-sender sender) (is-eq contract-caller sender)) err-not-token-owner)
    (ft-transfer? firstbit amount sender recipient)
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
  (ok (ft-get-balance firstbit who))
)

(define-public (get-total-supply)
  (ok (ft-get-supply firstbit))
)

(define-public (get-token-uri)
  (ok (var-get token-uri))
)

;; custom admin/user functions
(define-public (mint (amount uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (asserts! (> amount u0) err-invalid-amount)
    (ft-mint? firstbit amount recipient)
  )
)

(define-public (burn (amount uint) (owner principal))
  (begin
    (asserts! (or (is-eq tx-sender owner) (is-eq contract-caller owner)) err-not-token-owner)
    (asserts! (> amount u0) err-invalid-amount)
    (ft-burn? firstbit amount owner)
  )
)

(define-public (set-token-uri (new-uri (optional (string-utf8 256))))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (var-set token-uri new-uri)
    (ok true)
  )
)

;; initialize with an initial supply to the contract owner (e.g., 1,000,000 FBIT with 6 decimals)
(define-private (init)
  (begin
    (try! (ft-mint? firstbit u1000000000000 contract-owner))
    (ok true)
  )
)

(init)
