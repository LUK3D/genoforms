"use strict";
exports.__esModule = true;
/**
 * Authentication class used to create an autorization object with all necessary data.
 * @param host Hostname Ex: localhost:8080
 * @param user Database username Ex: root
 * @param database The name of the database that you want to connect with
 */
var SQL = /** @class */ (function () {
    function SQL(_a) {
        var host = _a.host, user = _a.user, password = _a.password, database = _a.database;
        this.host = host;
        this.user = user;
        this.password = password;
        this.database = database;
    }
    SQL.prototype.run = function (query) {
        console.log("Your Query: ", query, this.host, this.user);
    };
    return SQL;
}());
exports["default"] = SQL;
