import {GENO_SCHEMA} from "./gnforms_schema";
var fs = require('fs');
/**
 * Function to chegenerate an html form based on GENO_SCHEMA object.
 * @param schema 
 * @returns 
 */
async function makeForm(schema:GENO_SCHEMA):Promise<String>{
    var html = [];
    var result =   fs.readFileSync(__dirname+`/templates/m/${schema.lang}.txt`,'utf-8');
    schema.tables.forEach(table => {
        table.name
        console.log(table)
    });
    return html.join("\n");
}


export {makeForm};