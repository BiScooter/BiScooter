# <h1 style="text-align: center;">Setting the working Environment</h1>
## Organization
Created an organization on GITHUB under the name “BiScooter”

## Repo
Created a repo for the “BiScooter” organization called “BiScooter”

## Project Structure
Inside the “BiScooter” repo directory, there are the following directories  
  -	biscooter: the end user program application  
  -	server: contains server side that connects the program with the Database  
  -	db_queries: the queries used to build the Database, filling any necessary records, and
  set the constraints; this helps to have a way to rebuild any part of the Database again in case for any problem  
  
### biscooter
  created by

  ```bash
  flutter create biscooter
  ```

### server
  1 - first created app.js  
  2 - then initialized a new npm project by running the following command in the terminal
  ```bash
  npm init
  ```
  3 - installed the express dependency
  ```bash
  npm install express
  ```
  4- for easier development, installed the nodemon dependency
  ```bash
  npm install --save-dev nodemon
  ```
  5- created the best-practice file structure for a server; adding the following folders and filling them with dummy files  
  - controllers
  - middleware
  - routes
