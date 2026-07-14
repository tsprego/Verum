async function runScan() {
    const urlInput = document.getElementById('targetUrl').value;
    const loading = document.getElementById('loading');
    const results = document.getElementById('results');
    const scanBtn = document.getElementById('scanBtn');

    if (!urlInput) {
        alert("Please enter a valid URL.");
        return;
    }

    scanBtn.disabled = true;
    loading.classList.remove('hidden');
    results.classList.add('hidden');

    try {
        const response = await fetch('/api/scan', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ url: urlInput })
        });

        const data = await response.json();

        if (response.ok) {
            // [REQ-SEC-02] Use textContent exclusively to render un-sanitized API output safely
            document.getElementById('infraData').textContent = JSON.stringify(data.infrastructure, null, 2);
            document.getElementById('domData').textContent = JSON.stringify(data.dom_analysis, null, 2);
            results.classList.remove('hidden');
        } else {
            // [REQ-SEC-02] Safely output error strings
            alert(`Error: ${data.error}`);
        }
    } catch (error) {
        alert("Failed securely to connect to TSP-ReGo Verum API.");
    } finally {
        scanBtn.disabled = false;
        loading.classList.add('hidden');
    }
}
