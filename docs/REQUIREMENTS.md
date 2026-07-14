# TSP-ReGo Verum — Requirements & Traceability Matrix

This document defines the core security, functional, and infrastructure requirements for the Verum MVP. Every code implementation must map back to one of these IDs.

---

## 1. Functional Requirements (REQ-FUN)

*   **REQ-FUN-01 (URL Input Validation):** The system must accept a target URL from the user interface, validate its structure, and reject malformed requests before processing.
*   **REQ-FUN-02 (Infrastructure Scrape):** The system must fetch Whois data to determine the domain registration date and calculate domain age in days.
*   **REQ-FUN-03 (Deceptive Pattern Scraping):** The system must extract the DOM to analyze raw form structures and check for payment logo presence vs. active secure gateway integrations.

---

## 2. Zero-Trust Security Requirements (REQ-SEC)

*   **REQ-SEC-01 (SSRF Prevention):** The backend must validate that the target URL resolves to a public IP address. It must strictly reject connections to private, loopback (`127.0.0.1`), or local link-local subnets (Zero-Trust network boundary protection).
*   **REQ-SEC-02 (Cross-Site Scripting (XSS) Mitigation):** The frontend UI must never render scraped third-party data using unsafe DOM injection methods like `innerHTML`. All data must be rendered using safe text properties (`textContent`).
*   **REQ-SEC-03 (Secure HTTP Headers):** The Flask API must enforce protective headers (e.g., Content-Security-Policy, X-Content-Type-Options) to prevent execution of unauthorized scripts.
