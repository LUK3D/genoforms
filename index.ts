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
        auth.run("SELECT name FROM master.dbo.sysdatabases WHERE dbid > 4",(results)=>{
            _callback(results.recordset);
        })
    }else{
        auth.run("SHOW DATABASES",(error,results)=>{
            _callback(results);
        })
    }
}
/**
 * Function to fetch all tabales from given database.
 * @param database The name of the database
 * @param _callback Callback function that will be fired with the set of tables as argument
 */
function getTablesFromDatabase(database:string,_callback:Function){
    if(auth.env == "mssql"){
        auth.run(`SELECT table_name FROM [${database}].INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'`,(results)=>{
            _callback(results.recordset);
        })
    }else{
        auth.run(`SELECT table_name FROM information_schema.tables WHERE table_schema = ${database}`,(error,results)=>{
            _callback(results);
        })
    }
}

/**
 * Get list of columns from table
 * @param table 
 * @param _callback 
 */
function getColumnsFromTables(table:string,_callback:Function){
        auth.run(`SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '${table}'`,(results)=>{
            _callback(results);
        })
    
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
            var res = {"Database":databases[index].name,tables:tables};
    
                for(let e = 0; e < tables.length; e++){

                    getColumnsFromTables(tables[e].table_name,(columns)=>{
                        res.tables[e]["columns"] = [...columns.recordset];
                        if(e == tables.length-1)
                        console.log(JSON.stringify(res))
                    })

                    
                }

               

                
            })

            
        }
     })
}, 500);




 

