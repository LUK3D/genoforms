import {GENO_SCHEMA} from "./gnforms_schema";
var fs = require('fs');


function geerateFilename():string{

    var currentdate = new Date(); 
    var datetime =  currentdate.getDate() + "-"
                + (currentdate.getMonth()+1)  + "-" 
                + currentdate.getFullYear() + "_"  
                + currentdate.getHours() + "-"  
                + currentdate.getMinutes() + "-" 
                + currentdate.getSeconds();

    return datetime;
}



/**
 * Function to chegenerate an html form based on GENO_SCHEMA object.
 * @param schema 
 * @returns 
 */
async function makeForm(schema:GENO_SCHEMA):Promise<String>{
    var html = [];
    var result =   fs.readFileSync(__dirname+`/templates/m/${schema.lang}.txt`,'utf-8');
    schema.tables.forEach(table => {
        console.log(result)
    });
    return html.join("\n");
}

async function logFile(dados:string){
    fs.writeFile(__dirname+'/.logs/log-'+geerateFilename()+".txt", dados,function(err){
        if(err) throw err;
        console.log("LOG SAVED SUCCESSFULLY!")
    });
}

export {makeForm,logFile};