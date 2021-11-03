"use strict";
var __spreadArray = (this && this.__spreadArray) || function (to, from, pack) {
    if (pack || arguments.length === 2) for (var i = 0, l = from.length, ar; i < l; i++) {
        if (ar || !(i in from)) {
            if (!ar) ar = Array.prototype.slice.call(from, 0, i);
            ar[i] = from[i];
        }
    }
    return to.concat(ar || Array.prototype.slice.call(from));
};
exports.__esModule = true;
var gnfsql_1 = require("./gnfsql");
var auth = new gnfsql_1["default"]({ host: "127.0.0.1", user: "root", database: "angola" });
var formStruct = { tables: Array() };
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
            table["fields"] = __spreadArray([], results, true);
            if (index === formStruct.tables.length - 1)
                console.log(formStruct);
        });
    });
});
