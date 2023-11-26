const express = require('express');
const auth = require('../middleware/auth');
const Employee = require('../models/employee');
const employeeRouter = express.Router();

employeeRouter.post('/api/create-employee', auth, async (req,res)=>{

    try{

        const { name, designation, responsible_for, state_id, senior} = req.body;

        console.log(req.body);

        // let immediate_sr = '';

        // immediate_sr.push(senior);

        let employee = new Employee({
            name: name,
            reporting_to: senior,
            designation: designation,
            responsible_for: responsible_for,
            state_id: state_id
        });

        employee = await employee.save();

        res.status(200).json(employee);

    }catch(e){
        res.status(500).json('Error while creating');

    }
});

employeeRouter.get('/api/fetch-hierarchy-data', auth, async(req, res) =>{

    try{

        const employees = await Employee.find({
            active: 1
        });

        async function getAllJuniors(emp_id){


            //Find returns an array
            let allJuniors = await Employee.find({
                reporting_to: emp_id
            });

            let allJuniorsList = [];

            for(let i=0; i<allJuniors.length; i++){

                allJuniorsList.push({
                    jr_id: allJuniors[i].id,
                    type: 'one'
                });
            }

            return allJuniors.length>0 ? allJuniorsList : [] ;
        }

        

        const employeeWithJuniors = await Promise.all(employees.map(async employee => ({
            ...employee.toObject(), // Convert Mongoose document to plain JavaScript object
            'juniors': await getAllJuniors(employee.id)

        })));


        res.status(200).json(employeeWithJuniors);


    }catch(e){
        res.status(500).json('Error while fetching hierarchy data');
    }
});

module.exports = employeeRouter;