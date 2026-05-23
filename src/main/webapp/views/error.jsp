<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Error</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <style>
    body { background-color: #f8f9fa; }
    .error-container {
      max-width: 600px;
      margin: 100px auto;
      text-align: center;
    }
    .error-code {
      font-size: 6rem;
      font-weight: bold;
      color: #dc3545;
    }
  </style>
</head>
<body>
<div class="error-container">
  <div class="error-code">${errorCode}</div>
  <h3 class="mt-3">Oops! Something went wrong.</h3>
  <p class="text-muted">${errorMessage}</p>
  <a href="/" class="btn btn-primary mt-3">Go to Home</a>
  <a href="javascript:history.back()" class="btn btn-secondary mt-3">Go Back</a>
</div>
</body>
</html>
