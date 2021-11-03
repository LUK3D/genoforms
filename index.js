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
var auth = new gnfsql_1["default"]({ type: "mssql", host: "LLDESWKSHP0421", user: "sa", password: "abc@123", database: "REALHOPE" });
var formStruct = { tables: Array() };
if (auth.type != 'mssql') {
    // Get list of databases on the connection
    auth.run("SHOW DATABASES", function (error, results) {
        console.log("DATABASES: ", results);
    });
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
    setTimeout(function () {
        auth.run("SELECT name FROM master.dbo.sysdatabases", function (results) {
            console.log("DATABASES: ", results);
        });
    }, 500);
}
