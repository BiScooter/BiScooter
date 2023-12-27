function generateRandomString(length) {
    return Math.random().toString(36).substring(2, 2 + length);
  }
  
  // Example: Generate a random string of length 8
  const randomString = generateRandomString(10);
  console.log(typeof randomString);
  