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
        auth.run("SELECT name FROM master.dbo.sysdatabases WHERE dbid > 4", function (results) {
            _callback(results.recordset);
        });
    }
    else {
        auth.run("SHOW DATABASES", function (error, results) {
            _callback(results);
        });
    }
}
/**
 * Function to fetch all tabales from given database.
 * @param database The name of the database
 * @param _callback Callback function that will be fired with the set of tables as argument
 */
function getTablesFromDatabase(database, _callback) {
    if (auth.env == "mssql") {
        auth.run("SELECT table_name FROM [" + database + "].INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'", function (results) {
            _callback(results.recordset);
        });
    }
    else {
        auth.run("SELECT table_name FROM information_schema.tables WHERE table_schema = " + database, function (error, results) {
            _callback(results);
        });
    }
}
/**
 * Get list of columns from table
 * @param table
 * @param _callback
 */
function getColumnsFromTables(table, _callback) {
    auth.run("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '" + table + "'", function (results) {
        _callback(results);
    });
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
                var res = { "Database": databases[index].name, tables: tables };
                var _loop_2 = function (e) {
                    getColumnsFromTables(tables[e].table_name, function (columns) {
                        res.tables[e]["columns"] = __spreadArrays(columns.recordset);
                        if (e == tables.length - 1)
                            console.log(JSON.stringify(res));
                    });
                };
                for (var e = 0; e < tables.length; e++) {
                    _loop_2(e);
                }
            });
        };
        for (var index = 0; index < databases.length; index++) {
            _loop_1(index);
        }
    });
}, 500);
