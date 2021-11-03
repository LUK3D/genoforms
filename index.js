"use strict";
var __spreadArrays = (this && this.__spreadArrays) || function () {
    for (var s = 0, i = 0, il = arguments.length; i < il; i++) s += arguments[i].length;
    for (var r = Array(s), k = 0, i = 0; i < il; i++)
        for (var a = arguments[i], j = 0, jl = a.length; j < jl; j++, k++)
            r[k] = a[j];
    return r;
};
exports.__esModule = true;
var gnfsql_1 = require("./gnfsql");
// var auth = new SQL({host:"127.0.0.1",user:"root",database:"angola"})
var auth = new gnfsql_1["default"]({ env: "mssql", host: "LLDESWKSHP0421", user: "sa", password: "abc@123", database: "REALHOPE" });
var formStruct = { tables: Array() };
/**
 * Get list of databases on the connection
 * @param _callback Callback function that returns the set of databases as an argument.
 */
function getDatabases(_callback) {
    if (auth.env == "mssql") {
        auth.run("SELECT name FROM master.dbo.sysdatabases", function (results) {
            _callback(results.recordset);
        });
    }
    else {
        auth.run("SHOW DATABASES", function (error, results) {
            _callback(results);
        });
    }
}
function getTablesFromDatabase(table, _callback) {
    if (auth.env == "mssql") {
        auth.run("SELECT table_name FROM [" + table + "].INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'", function (results) {
            _callback(results.recordset);
        });
    }
    else {
        auth.run("SELECT table_name FROM information_schema.tables WHERE table_schema = " + table, function (error, results) {
            _callback(results);
        });
    }
}
if (auth.env != 'mssql') {
    //Get list of tables from database
    auth.run("SELECT table_name FROM information_schema.tables WHERE table_schema = 'angola'", function (error, results, fields) {
        console.log("ERRO:", error);
        //console.log("RESULT:", results)
        formStruct.tables = results;
        formStruct.tables.forEach(function (table, index) {
            // Get list of columns from table
            auth.run("SHOW FULL COLUMNS FROM " + table["table_name"], function (error, results, fields) {
                console.log("ERRO:", error);
                //console.log("RESULT:", results)
                table["fields"] = __spreadArrays(results);
                if (index === formStruct.tables.length - 1)
                    console.log(formStruct);
            });
        });
    });
}
else {
}
setTimeout(function () {
    getDatabases(function (databases) {
        var _loop_1 = function (index) {
            getTablesFromDatabase(databases[index].name, function (tables) {
                console.log({ "Database": databases[index].name, tables: tables });
            });
        };
        for (var index = 0; index < databases.length; index++) {
            _loop_1(index);
        }
    });
}, 500);
