const express = require('express');
const path = require('path');
const fs = require('fs');
const { exec } = require('child_process');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Serve static files
app.use(express.static('public'));

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'healthy', timestamp: new Date().toISOString() });
});

// Vulnerable route: SQL injection potential
app.post('/login', (req, res) => {
  const { username, password } = req.body;
  
  // Vulnerable: Direct string concatenation (SQL injection)
  const query = `SELECT * FROM users WHERE username = '${username}' AND password = '${password}'`;
  
  res.json({ message: 'Login processed', query: query });
});

// Vulnerable route: Command injection
app.post('/ping', (req, res) => {
  const { host } = req.body;
  
  // Vulnerable: Command injection
  exec(`ping -c 1 ${host}`, (error, stdout, stderr) => {
    if (error) {
      res.status(500).json({ error: error.message });
      return;
    }
    res.json({ result: stdout });
  });
});

// Vulnerable route: Path traversal
app.get('/file/:filename', (req, res) => {
  const { filename } = req.params;
  
  // Vulnerable: Path traversal
  const filePath = path.join(__dirname, 'files', filename);
  
  fs.readFile(filePath, 'utf8', (err, data) => {
    if (err) {
      res.status(404).json({ error: 'File not found' });
      return;
    }
    res.json({ content: data });
  });
});

// Vulnerable route: XSS potential
app.get('/search', (req, res) => {
  const { q } = req.query;
  
  // Vulnerable: Direct output without sanitization
  const html = `
    <html>
      <body>
        <h1>Search Results</h1>
        <p>You searched for: ${q}</p>
      </body>
    </html>
  `;
  
  res.send(html);
});

// Vulnerable route: Insecure deserialization
app.post('/data', (req, res) => {
  try {
    // Vulnerable: eval() usage
    const result = eval(`(${req.body.data})`);
    res.json({ processed: result });
  } catch (error) {
    res.status(400).json({ error: 'Invalid data format' });
  }
});

// Default route
app.get('/', (req, res) => {
  res.json({
    message: 'Vulnerable Demo Application',
    endpoints: [
      'GET /health - Health check',
      'POST /login - Login (SQL injection vulnerable)',
      'POST /ping - Ping host (command injection vulnerable)',
      'GET /file/:filename - Read file (path traversal vulnerable)',
      'GET /search?q=term - Search (XSS vulnerable)',
      'POST /data - Process data (code injection vulnerable)'
    ]
  });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Vulnerable demo app listening on port ${PORT}`);
  console.log(`Environment: ${process.env.NODE_ENV || 'development'}`);
});