"use strict";
exports.__esModule = true;
var configs_1 = require("./configs");
var auth = new configs_1["default"]({ host: "localhost", user: "root", database: "angola" });
auth.run("Select all from users");
