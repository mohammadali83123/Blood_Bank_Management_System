# Database Project

## Blood Bank Management System

### 🚀 How to Run the Project

1. **Clone the Repository**

```bash
git clone https://github.com/mohammadali83123/Blood_Bank_Management_System.git
```

2. **Start XAMPP Controller**

- Make sure that both **Apache** and **MySQL** are running.

3. **Set Up the Database**

- Open your browser and go to:  
  ```
  http://localhost/phpmyadmin/
  ```
- Create a new database and name it:  
  ```
  bbms
  ```
- Import the `BBMS.sql` file from the `db` folder into the `bbms` database.

4. **Start the Backend Server**

```bash
cd Blood_Bank_Management_System/Backend
nodemon index.js
```

> ✅ Make sure `nodemon` is installed globally. You can install it using:
> ```bash
> npm install -g nodemon
> ```

---
