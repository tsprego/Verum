import os
# ... (rest of your imports remain the same) ...

# [REQ-SEC-03] Apply security headers and point to the static directory
app = Flask(__name__, static_folder='static')

@app.route('/')
def serve_index():
    # Points Flask specifically to the new html/ subfolder
    return send_from_directory(os.path.join(app.static_folder, 'html'), 'index.html')

# ... (keep the rest of the backend scanner code below) ...
