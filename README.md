#TSP-ReGo Verum
Automated B2B Webshop Verification & Scam Detection Framework

Overview
TSP-ReGo Verum is a centralized, AI-driven API and web interface designed to analyze e-commerce domains for fraudulent infrastructure and deceptive UI patterns. Built for high-volume automated screening, Verum provides a definitive 0-100 Trust Score to help payment gateways, banks, and compliance teams instantly identify scam storefronts before authorizing merchant integrations.

Core Architecture
Unlike client-side browser extensions, Verum operates on a centralized server architecture (Python/Flask backend) to ensure total control, bypass app-store delays, and provide a seamless API endpoint for B2B integration.

The Data Pipeline
The Verum scanning engine orchestrates data collection across multiple layers:

Infrastructure Verification: Queries Whois databases and SSL/TLS certificates to detect high-risk anomalies, such as domains registered within the last 6 months.

Payment Mismatch Detection: Scrapes the DOM to identify deceptive payment signaling—such as displaying Visa or Mastercard logos without the corresponding secure gateway scripts (e.g., Stripe, Quickpay).

Content Pattern Analysis: Extracts visible site text and structure to detect fake urgency timers, unrealistic discount loops, and heavily AI-generated filler copy.

AI-Driven Judgment: Compiles the scraped metadata and DOM patterns into an LLM prompt to generate a final, structured JSON verdict detailing the Trust Score and the primary risk factors.

Tech Stack
Backend Interface: Python 3, Flask

Data Orchestration: requests, beautifulsoup4, python-whois

Frontend UI: Vanilla HTML5, CSS3, JavaScript (Fetch API)

Environment: GitHub Codespaces (100% web-based execution)
