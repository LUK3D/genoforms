import SQL from "./gnfsql";
import {GENO_COLUMN, GENO_SCHEMA,GENO_TABLE} from "./helpers/gnforms_schema";
import { makeForm } from "./helpers/gnforms";
// var auth = new SQL({host:"127.0.0.1",user:"root",database:"angola"})
var auth = new SQL({env:"mssql",host:"LLDESWKSHP0421",user:"sa",password:"abc@123",database:"REALHOPE"})

 
/**
 * Get list of databases on the connection
 * @param _callback Callback function that returns the set of databases as an argument.
 */
 function getDatabases(_callback:(databases:Array<object>)=>any){
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
function getTablesFromDatabase(database:string,_callback:(tables:Array<object>)=>any){
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
function getColumnsFromTables(table:string,_callback:(columns:Array<object>)=>any){
        if(auth.env == "mssql"){
            auth.run(`SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '${table}'`,(results)=>{
                _callback(results.recordset);
                
            })
        }else{
             auth.run(`SHOW FULL COLUMNS FROM = '${table}'`,(results)=>{
                _callback(results["fields"]);
            })
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




setTimeout(() => {
    getTablesFromDatabase("REALHOPE",(tables)=>{
    
        var tables_tmp:Array<GENO_TABLE> = [];
            for(let e = 0; e < tables.length; e++){

                getColumnsFromTables(tables[e]["table_name"],(columns)=>{
                    
                    var table:GENO_TABLE = new GENO_TABLE({name:tables[e]["table_name"],columns:columns.map(x=>new GENO_COLUMN({name:x["COLUMN_NAME"],type:x["DATA_TYPE"],def:x["COLUMN_DEFAULT"],is_nullable:x["IS_NULLABLE"],char_max:x["CHARACTER_MAXIMUM_LENGTH"]}))});
                    tables_tmp.push(table);
                    if(e == tables.length-1){
                        var gns:GENO_SCHEMA = new GENO_SCHEMA({database:"REALHOPE",tables:tables_tmp,lang:"php"})
                        makeForm(gns);
                    }
                })

                
            }
            
        })
}, 500);

 

