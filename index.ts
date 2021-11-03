import SQL from "./gnfsql";

// var auth = new SQL({host:"127.0.0.1",user:"root",database:"angola"})
var auth = new SQL({env:"mssql",host:"LLDESWKSHP0421",user:"sa",password:"abc@123",database:"REALHOPE"})


 
var formStruct = {tables:Array<Object>()};


/**
 * Get list of databases on the connection
 * @param _callback Callback function that returns the set of databases as an argument.
 */
 function getDatabases(_callback:Function){
    if(auth.env == "mssql"){
        auth.run("SELECT name FROM master.dbo.sysdatabases",(results)=>{
            _callback(results.recordset);
        })
    }else{
        auth.run("SHOW DATABASES",(error,results)=>{
            _callback(results);
        })
    }
}


function getTablesFromDatabase(table:string,_callback:Function){
    if(auth.env == "mssql"){
        auth.run(`SELECT table_name FROM [${table}].INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'`,(results)=>{
            _callback(results.recordset);
        })
    }else{
        auth.run(`SELECT table_name FROM information_schema.tables WHERE table_schema = ${table}`,(error,results)=>{
            _callback(results);
        })
    }
}


if(auth.env !='mssql'){
   

    //Get list of tables from database
    auth.run("SELECT table_name FROM information_schema.tables WHERE table_schema = 'angola'",(error, results, fields)=>{
        console.log("ERRO:", error)
        //console.log("RESULT:", results)
        formStruct.tables = results;

        formStruct.tables.forEach((table,index) => {
            // Get list of columns from table
            auth.run(`SHOW FULL COLUMNS FROM ${table["table_name"]}`,(error, results, fields)=>{
                console.log("ERRO:", error)
                //console.log("RESULT:", results)
                table["fields"] = [...results];
                if(index === formStruct.tables.length-1)
                    console.log(formStruct);
            })
        });
    })
}else{


}


setTimeout(() => {
     getDatabases((databases)=>{

        for(let index = 0; index < databases.length; index++){

            getTablesFromDatabase(databases[index].name,(tables)=>{
                console.log({"Database":databases[index].name,tables:tables})
            })
        }
     })
}, 500);




 

