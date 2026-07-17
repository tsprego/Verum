from flask import Flask, send_from_directory, jsonify, request
import os
# ... (rest of your imports remain the same) ...

# [REQ-SEC-03] Apply security headers and point to the static directory
app = Flask(__name__, static_folder='static')

@app.route('/')
def serve_index():
    # Points Flask specifically to the new html/ subfolder
    return send_from_directory(os.path.join(app.static_folder, 'html'), 'index.html')

# ... (keep the rest of the backend scanner code below) ...
# Serve other static files (like script.js and style.css) if the browser requests them directly
@app.route('/static/<path:path>')
def serve_static(path):
    return send_from_directory(app.static_folder, path)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)