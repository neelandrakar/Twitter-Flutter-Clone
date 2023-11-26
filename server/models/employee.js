const mongoose = require('mongoose');

const employeeSchema = mongoose.Schema({

    name: {
        type: String,
        required: true
    },

    reporting_to: {

        type: String,
        required: true
    },

    designation: {

        type: String,
        required: true
    },

    responsible_for: {

        type: Number,
        required: true
    },

    state_id: {

        type: Number,
        required: true
    },

    active: {

        type: Number,
        default: 1
    }
});

const Employee = mongoose.model('Employee',employeeSchema);
module.exports = Employee;