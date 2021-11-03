"use strict";
exports.__esModule = true;
var gnfsql_1 = require("./gnfsql");
var gnforms_schema_1 = require("./helpers/gnforms_schema");
var gnforms_1 = require("./helpers/gnforms");
// var auth = new SQL({host:"127.0.0.1",user:"root",database:"angola"})
var auth = new gnfsql_1["default"]({ env: "mssql", host: "LLDESWKSHP0421", user: "sa", password: "abc@123", database: "REALHOPE" });
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
    if (auth.env == "mssql") {
        auth.run("SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '" + table + "'", function (results) {
            _callback(results.recordset);
        });
    }
    else {
        auth.run("SHOW FULL COLUMNS FROM = '" + table + "'", function (results) {
            _callback(results["fields"]);
        });
    }
}
// setTimeout(() => {
//      getDatabases((databases)=>{
//         for(let index = 0; index < databases.length; index++){
//             getTablesFromDatabase(databases[index]["name"],(tables)=>{
//             var res = {"Database":databases[index]["name"],tables:tables};
//                 for(let e = 0; e < tables.length; e++){
//                     getColumnsFromTables(tables[e]["table_name"],(columns)=>{
//                         res.tables[e]["columns"] = [...columns];
//                         if(e == tables.length-1)
//                         console.log(JSON.stringify(res))
//                     })
//                 }
//             })
//         }
//      })
// }, 500);
setTimeout(function () {
    getTablesFromDatabase("REALHOPE", function (tables) {
        var tables_tmp = [];
        var _loop_1 = function (e) {
            getColumnsFromTables(tables[e]["table_name"], function (columns) {
                var table = new gnforms_schema_1.GENO_TABLE({ name: tables[e]["table_name"], columns: columns.map(function (x) { return new gnforms_schema_1.GENO_COLUMN({ name: x["COLUMN_NAME"], type: x["DATA_TYPE"], def: x["COLUMN_DEFAULT"], is_nullable: x["IS_NULLABLE"], char_max: x["CHARACTER_MAXIMUM_LENGTH"] }); }) });
                tables_tmp.push(table);
                if (e == tables.length - 1) {
                    var gns = new gnforms_schema_1.GENO_SCHEMA({ database: "REALHOPE", tables: tables_tmp, lang: "php" });
                    gnforms_1.makeForm(gns);
                }
            });
        };
        for (var e = 0; e < tables.length; e++) {
            _loop_1(e);
        }
    });
}, 500);
