# TSP-ReGo Verum: Zero-Trust MVP Setup Guide

This document provides a step-by-step, reproducible baseline for initializing the TSP-ReGo Verum B2B webshop scanner in a secure, cloud-based environment. It outlines the transition from an empty repository to a running Flask application with strict UI security boundaries.

## Phase 1: Environment Initialization (GitHub Codespaces)

To maintain a strict separation between local hardware and the execution environment, we utilize an isolated cloud container.

1. Navigate to the GitHub repository.
2. Click the green **`<> Code`** button.
3. Select the **`Codespaces`** tab.
4. Click **`Create codespace on main`** to provision the Ubuntu Linux container and launch the web-based VS Code environment.

## Phase 2: Directory Architecture & File Provisioning

Once the Codespace is active, open the integrated terminal (`Ctrl + ~`) and construct the project's directory tree.

```bash
# Create the structural directories
mkdir -p docs static/html static/data static/image static/logo static/script static/style

# Provision the initial core files
touch app.py requirements.txt README.md docs/REQUIREMENTS.md static/html/index.html static/style/style.css static/script/script.js
```

## Phase 3: Dependency Management

Define the Python backend requirements. Add the following to `requirements.txt`:

```text
Flask==3.0.0
requests==2.31.0
beautifulsoup4==4.12.2
python-whois==0.8.0
```

Install the dependencies in the active environment:
```bash
pip install -r requirements.txt
```
*(Note: If the environment drops the Flask installation, manually force it via `pip install flask`.)*

## Phase 4: Core Implementation

### 1. The Presentation Layer (`static/html/index.html`)
This file establishes the UI and enforces initial client-side input validation (max length, URL regex pattern).

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TSP-ReGo Verum | B2B Webshop Scanner</title>
    <link rel="stylesheet" href="/static/style/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>TSP-ReGo Verum</h1>
            <p>Automated Scam-Shop Verification Framework</p>
        </header>
        <main>
            <form id="scanForm" onsubmit="handleFormSubmit(event)">
                <div class="input-section">
                    <input type="url" id="targetUrl" placeholder="https://example-shop.com" required maxlength="2048" autocomplete="off" pattern="https?://.+" title="Please enter a valid URL starting with http:// or https://">
                    <button type="submit" id="scanBtn">Initialize Scan</button>
                </div>
            </form>
            <div id="loading" class="hidden">
                <p>Verum is analyzing target infrastructure and DOM security...</p>
            </div>
            <div id="results" class="results-grid hidden">
                <div class="card">
                    <h3>Infrastructure (Whois)</h3>
                    <pre id="infraData"></pre>
                </div>
            </div>
        </main>
    </div>
    <script src="/static/script/script.js"></script>
</body>
</html>
```

### 2. The Client-Side Logic (`static/script/script.js`)
This script manages the UI state transitions (locking the input to prevent duplicate requests).

```javascript
function setUiLoadingState(isLoading) {
    const scanBtn = document.getElementById('scanBtn');
    const targetUrlInput = document.getElementById('targetUrl');
    const loadingIndicator = document.getElementById('loading');

    if (isLoading) {
        scanBtn.disabled = true;
        targetUrlInput.readOnly = true;
        loadingIndicator.classList.remove('hidden');
        document.getElementById('results').classList.add('hidden');
    } else {
        scanBtn.disabled = false;
        targetUrlInput.readOnly = false;
        loadingIndicator.classList.add('hidden');
    }
}

function handleFormSubmit(event) {
    event.preventDefault();
    const rawUrl = document.getElementById('targetUrl').value.trim();
    
    if (rawUrl.length > 2048) {
        alert("Input URL is too long.");
        return;
    }
    
    setUiLoadingState(true);
    setTimeout(() => {
        setUiLoadingState(false);
    }, 2000);
}
```

### 3. The Backend Controller (`app.py`)
This establishes the Flask web server, securely routing traffic to the static UI assets.

```python
from flask import Flask, send_from_directory, jsonify, request
import os

app = Flask(__name__, static_folder='static')

@app.route('/')
def serve_index():
    return send_from_directory(os.path.join(app.static_folder, 'html'), 'index.html')

@app.route('/static/<path:path>')
def serve_static(path):
    return send_from_directory(app.static_folder, path)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
```

## Phase 5: Operational Control & Versioning

### 1. Booting the Application
Execute the backend process:
```bash
python app.py
```
This process runs in the foreground. GitHub will automatically create a secure HTTPS proxy tunnel for access.

### 2. Managing Multiple Terminals
Because Flask claims the active terminal session, operational tasks (like version control) require concurrent terminal access:
*   Click the **Split Terminal** icon (top right of the terminal panel) to open an adjacent command prompt while the server continues running.

### 3. Committing the Baseline
With the configuration stable, formalize the state in version control using the split terminal:
```bash
git add .
git commit -m "chore: initialized secure zero-trust environment and core UI modules"
git push
```
