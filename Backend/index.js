const express = require('express');
const con = require('./connect');
const bodyparser = require('body-parser');
const path = require('path');


const app = express();

//body parser used for to convert html form data into database format
app.use(bodyparser.json());
app.use(bodyparser.urlencoded({ extended: true }));

//used for showing data from database to html
app.set('view engine', 'ejs');
app.use(express.static(path.join(__dirname, '../Frontend/static')));



//  ------------------User----------------

//  ------------------Donor Registeration Form----------------
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '../Frontend/static/index.html'));
});
app.get('/about', (req, res) => {
    res.sendFile(path.join(__dirname, '../Frontend/User Pages/about.html'));
});

app.get('/donor-register', (req, res) => {
    res.sendFile(path.join(__dirname, '../Frontend/User Pages/donor-form.html'));
});

app.post('/donor-register', (req, res) => {
    let DName = req.body.Name;
    let DPhone = req.body.Phone;
    let DAge = req.body.Age;
    let DPeriod = req.body.Period;
    let DQues1 = req.body.Ques1;
    let DGender = req.body.Gender;
    let DDisease = req.body.Disease;
    let DBlood = req.body.Blood;


    let Dsql = 'INSERT INTO Donor(Name, Phone, Age, Period , Ques1, Gender, Disease, Blood) values ?';
    let Dvalues = [
        [DName, DPhone, DAge, DPeriod, DQues1, DGender, DDisease, DBlood]
    ];

    con.query(Dsql, [Dvalues], (error, result) => {
        if (error) {
            throw error;
        }
        else {
            console.log('Donor Registered');
            res.redirect('/');
        }
    });

});
//  ------------------Donor Registeration Form----------------



//  ------------------Recipient Registeration Form----------------
app.get('/recipient', (req, res) => {
    res.sendFile(path.join(__dirname, '../Frontend/User Pages/recipient.html'));
});
app.post('/recipient', (req, res) => {
    let RName = req.body.Name;
    let RPhone = req.body.Phone;
    let RGender = req.body.Gender;
    let RReason = req.body.Reason;
    let RBlood = req.body.Blood;


    let Rsql = 'INSERT INTO Recipient(Name, Phone, Gender, Reason, Blood) values ?';
    let Rvalues = [
        [RName, RPhone, RGender, RReason, RBlood]
    ];

    con.query(Rsql, [Rvalues], (error, result) => {
        if (error) {
            throw error;
        }
        else {
            console.log('Recipient Saved');
            res.redirect('/view-donors');
        }
    });

});
//  ------------------Recipient Registeration Form----------------


//  ------------------Blood Matching----------------
app.get('/view-donors', (req, res) => {
    let vsql = 'SELECT Blood FROM recipient ORDER BY RID DESC LIMIT 1;'
    let type;
    con.query(vsql, (error, result) => {
        if (error) {
            throw error;
        }
        else {
            type = result[0].Blood;

            function getCompatibleBloodTypes(inputBloodType) {
                const bloodTypes = {
                    'A+': ['A+', 'A-', 'O+', 'O-'],
                    'A-': ['A-', 'O-'],
                    'B+': ['B+', 'B-', 'O+', 'O-'],
                    'B-': ['B-', 'O-'],
                    'AB+': ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
                    'AB-': ['AB-', 'A-', 'B-', 'O-'],
                    'O+': ['O+', 'O-'],
                    'O-': ['O-']
                };

                return bloodTypes[inputBloodType] || [];
            }

            const userInput = type;

            if (userInput) {
                const inputBloodType = userInput.toUpperCase();
                const compatibleBloodTypes = getCompatibleBloodTypes(inputBloodType);
                let dsql = 'Select Name, Phone, Age, Gender, Blood from donor where Blood in (?)';
                
                con.query(dsql,[compatibleBloodTypes],(error,result)=>{
                    if(error) throw error;

                    res.render(path.join(__dirname, '../Frontend/Admin Pages/Donor Pages/view-donors'), { view_donors: result });
                });
            }
        }
    });
});
//  ------------------Blood Matching----------------



//  ------------------Admin----------------

//  ------------------Admin Login Page----------------
app.get('/admin-login', (req, res) => {
    res.sendFile(path.join(__dirname, '../Frontend/Admin Pages/admin-login.html'));
});
app.post('/admin-login', (req, res) => {
    let Aid = req.body.AID;
    let AName = req.body.Name;
    let APassword = req.body.Password;

    let Asql = "SELECT * FROM ADMIN WHERE AID = ? AND Password = ?";

    con.query(Asql, [Aid, APassword], (error, results) => {
        if (error) {
            throw error;
        }
        else {
            if (results.length > 0) {
                res.sendFile(path.join(__dirname, '../Frontend/Admin Pages/admin-landingpage.html'));
            }
            else {
                res.send('Invalid admin id or password');
            }

        }
    });
});
//  ------------------Admin Login Page----------------



//  ------------------Donor List----------------
app.get('/donor-list', (req, res) => {
    let sql = 'Select * from Donor';

    con.query(sql, (error, result) => {
        if (error) throw error;
        res.render(path.join(__dirname, '../Frontend/Admin Pages/Donor Pages/donor-list.ejs'), { donor_list: result });
    });
});
//  ------------------Donor list----------------


//  ------------------Delete Donor----------------
app.get('/delete-donor', (req, res) => {
    let sql = 'Delete from donor where DID = ?'

    let Donor_id = req.query.DID

    con.query(sql, [Donor_id], (error, result) => {
        if (error) {
            throw error;
        }
        else {
            console.log('Donor deleted');
            res.redirect('/donor-list');
        }
    });
});
//  ------------------Delete Donor----------------




//  ------------------recipient list----------------
app.get('/recipient-list', (req, res) => {
    let sql = 'Select * from recipient';

    con.query(sql, (error, result) => {
        if (error) throw error;
        res.render(path.join(__dirname, '../Frontend/Admin Pages/Recipient Pages/recipient-list'), { recipient_list: result });
    });
});
//  ------------------recipient list----------------



//  ------------------Delete recipient----------------
app.get('/delete-recipient', (req, res) => {
    let sql = 'Delete from recipient where RID = ?'

    let recipient_id = req.query.RID

    con.query(sql, [recipient_id], (error, result) => {
        if (error) {
            throw error;
        }
        else {
            console.log('Recipient deleted');
            res.redirect('/recipient-list');
        }
    });
});
//  ------------------Delete recipient----------------

//  ------------------update recipient----------------
app.get('/rollback-recipient', (req, res) => {
    let id  = req.query.RID;
    let sql = 'Delete from deleted_recipient where RID = ?';

    con.query(sql,[id],(error,result)=>{
        if(error) throw error;

        res.redirect('/recipient-logs');
    })   
});
//  ------------------update recipient----------------


//  ------------------Donor RollBack----------------
app.get('/rollback-donor', (req, res) => {
    let id  = req.query.DID;
    let sql = 'Delete from deleted_donor where DID = ?';

    con.query(sql,[id],(error,result)=>{
        if(error) throw error;

        res.redirect('/donor-logs');
    })
});
//  ------------------Donor RollBack----------------

//  ------------------recipient-logs----------------
app.get('/recipient-logs', (req, res) => {
    let sql = 'Select * from recipient_logs';

    con.query(sql, (error, result) => {
        if (error) throw error;

        res.render(path.join(__dirname, '../Frontend/Admin Pages/Recipient Pages/recipient-logs'), { recipient_logs: result });
    });
});
//  ------------------recipient-logs----------------


//  ------------------donor-logs----------------
app.get('/donor-logs', (req, res) => {
    let sql = 'Select * from donor_logs';

    con.query(sql, (error, result) => {
        if (error) throw error;
        res.render(path.join(__dirname, '../Frontend/Admin Pages/Donor Pages/donor-logs.ejs'), { donor_logs: result });
    });
});
//  ------------------donor-logs----------------



//  ------------------Port----------------
PORT = 7000
app.listen(PORT,()=>{
    console.log(`website is live at http://localhost:${PORT}`);
});
