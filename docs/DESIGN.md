# TSP-ReGo Verum — Design Specification
**Document ID:** VERUM-DS-01  
**Security Classification:** Confidential / Proprietary

---

## 1. System Architecture
Verum uses a secure, three-tier centralized web architecture designed to analyze e-commerce storefronts without client-side trust assumptions.

```text
[User Web UI] 
      │  (Fetch API / HTTPS)
      ▼
[API Gateway / Flask Controller]  <───> [Local Data Validation Engine]
      │                                    (SSRF & IP Whitelisting)
      ├───> [WHOIS / Infrastructure Scraper]
      └───> [DOM Parser / BS4 Analysis Engine]
