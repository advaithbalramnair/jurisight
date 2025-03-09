module.exports = {
  apps: [
    {
      name: "node-app",
      script: "index.js",
      exec_mode: "fork",
      autorestart: true,
      out_file: "/app/logs/node-out.log",
      error_file: "/app/logs/node-error.log",
      env: {
        PORT: 3000,
        NODE_ENV: "production"
      }
    },
    {
      name: "flask-app",
      script: "chatbot.py",
      interpreter: "python3",
      exec_mode: "fork",
      autorestart: true,
      min_uptime: 60000,
      out_file: "/app/logs/flask-out.log",
      error_file: "/app/logs/flask-error.log",
      env: {
        PORT: 5000,
        FLASK_ENV: "production",
        FLASK_APP: "chatbot.py"
      }
    }
  ]
};
