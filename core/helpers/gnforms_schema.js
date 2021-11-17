"use strict";
exports.__esModule = true;
exports.GENO_COLUMN = exports.GENO_SCHEMA = exports.GENO_TABLE = void 0;
/**
 * Geno data type schema
 */
var GENO_SCHEMA = /** @class */ (function () {
    function GENO_SCHEMA(_a) {
        var database = _a.database, tables = _a.tables, lang = _a.lang;
        this.database = database;
        this.tables = tables;
        this.lang = lang;
    }
    return GENO_SCHEMA;
}());
exports.GENO_SCHEMA = GENO_SCHEMA;
/**
 * Geno Table data type
 */
var GENO_TABLE = /** @class */ (function () {
    function GENO_TABLE(_a) {
        var name = _a.name, columns = _a.columns;
        this.name = name;
        this.columns = columns;
    }
    return GENO_TABLE;
}());
exports.GENO_TABLE = GENO_TABLE;
var GENO_COLUMN = /** @class */ (function () {
    function GENO_COLUMN(_a) {
        var name = _a.name, type = _a.type, def = _a.def, char_max = _a.char_max, is_nullable = _a.is_nullable, key_type = _a.key_type;
        this.name = name;
        this.type = type;
        this.key_type = key_type;
        this["default"] = def;
        this.char_max = char_max;
        this.is_nullable = (is_nullable != 'NO');
    }
    return GENO_COLUMN;
}());
exports.GENO_COLUMN = GENO_COLUMN;
exports["default"] = GENO_TABLE;
