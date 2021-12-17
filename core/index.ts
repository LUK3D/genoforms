import SQL from "./gnfsql";
import {GENO_COLUMN, GENO_SCHEMA,GENO_TABLE} from "./helpers/gnforms_schema";
import { logFile, makeForm } from "./helpers/gnforms";
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
        auth.run(`SELECT table_name FROM information_schema.tables WHERE table_schema = '${database}'`,(results)=>{
            _callback(results);
        })
    }
}
/**
 * Function to fetch all procedures from given database.
 * @param database The name of the database
 * @param _callback Callback function that will be fired with the set of tables as argument
 */
function getProceduresFromDatabase(database:string,_callback:(tables:Array<object>)=>any){
        auth.run(`SELECT SPECIFIC_CATALOG, SPECIFIC_NAME, ROUTINE_NAME,ROUTINE_DEFINITION  FROM ${database}.INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = 'PROCEDURE'`,(results)=>{
            _callback(results.recordset);
        });
}

/**
 * Get list of columns from table
 * @param table 
 * @param _callback 
 */
function getColumnsFromTables(table:string,_callback:(columns:Array<object>)=>any){
     
        auth.run(`SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '${table}'`,(results)=>{
            if(auth.env == "mssql"){
                _callback(results["fields"]);
            }else{
                _callback(results);
            }
        })
        
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

    // getTablesFromDatabase("angola",(tables)=>{
    
    //     var tables_tmp:Array<GENO_TABLE> = [];
    //         for(let e = 0; e < tables.length; e++){

    //             getColumnsFromTables(tables[e]["table_name"],(columns)=>{
    //                 console.log("Colunas",columns)
    //                if(columns){
    //                 var table:GENO_TABLE = new GENO_TABLE({name:tables[e]["table_name"],columns:columns.map(x=>new GENO_COLUMN({name:x["COLUMN_NAME"],type:x["DATA_TYPE"],def:x["COLUMN_DEFAULT"],is_nullable:x["IS_NULLABLE"],char_max:x["CHARACTER_MAXIMUM_LENGTH"]||x["CHARACTER_MAXIMUM_LENGTH"]}))});
    //                 tables_tmp.push(table);
    //                }

    //                if(e == tables.length-1){
    //                 var gns:GENO_SCHEMA = new GENO_SCHEMA({database:"REALHOPE",tables:tables_tmp,lang:"php"})
    //                     makeForm(gns);
    //                 }
    //             })

                
    //         }
            
            
    //     })
    // return ;
    // getTablesFromDatabase("MASI_TESTES",(tables)=>{
    
    //     var tables_tmp:Array<GENO_TABLE> = [];
    //         for(let e = 0; e < tables.length; e++){

    //             getColumnsFromTables(tables[e]["table_name"],(columns)=>{
                    
    //                 var table:GENO_TABLE = new GENO_TABLE({name:tables[e]["table_name"],columns:columns.map(x=>new GENO_COLUMN({name:x["COLUMN_NAME"],type:x["DATA_TYPE"],def:x["COLUMN_DEFAULT"],is_nullable:x["IS_NULLABLE"],char_max:x["CHARACTER_MAXIMUM_LENGTH"]}))});
    //                 tables_tmp.push(table);
    //                 if(e == tables.length-1){
    //                     var gns:GENO_SCHEMA = new GENO_SCHEMA({database:"MASI_TESTES",tables:tables_tmp,lang:"php"})
    //                     makeForm(gns);
    //                 }
    //             })

                
    //         }
            
    //     })


    var regex_to_get_properties = /(?<=\]\s+).*?(AS)/mgs;


    var new_tables = [
        {name:"GUIDE", type:"uniqueidentifier", default:"newid()"},
        {name:"NM_UTILIZADOR", type:"varchar(200)", default:null},
        {name:"COD_UTILIZADOR", type:"int", reference:{table:"UTILIZADORES", column:"ID_UTILIZADOR"}, default:null},
        {name:"NM_UTILIZADOR_ALT", type:"varchar(200)", default:null},
        {name:"COD_UTILIZADOR_ALT", type:"int", reference:{table:"UTILIZADORES", column:"ID_UTILIZADOR"}, default:null},
        {name:"DT_CAD", type:"datetime2(7)", default:"getdate()"},
        {name:"DT_ALT", type:"datetime2(7)", default:"getdate()"},
       // {name:"FL_EXCLU", type:"int", default:"0"},

    ];


//     getProceduresFromDatabase("MASI_TESTES",(procedures)=>{
//         var final = [];
//         procedures.forEach(el => {
//             var v1 = el.ROUTINE_DEFINITION.split(/^\s*\n/gm).join("");
//             v1 = v1.split("CREATE").join("\nCREATE");

//             var newCols = [];

//             new_tables.forEach(column => {
//                 newCols.push(`@${column.name} ${column.type}`)
//             });

            
//             v1 = v1.split(/(\] @ID)/mg).join(']\t'+newCols.join(',\n\t')+'\t@ID');
//             v1 =  v1.split(/(^\s*@ID).[a-zA-Z]* /mgs).join('\n\t'+newCols.join(',\n\t')+',\t@ID');

//             v1 = v1.split('@ID]').join(',\n').split('	,\n ,').join(',').split(')	@').join('),\n\t@');
//             v1 = v1.replace(/^(.*?)$\s+?^(?=.*^\1$)/gms,'\n');

//             if(final.indexOf(v1)==-1){
//                 final.push("--------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n")
//                 final.push(v1);
//                 final.push("--------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n")
//             }
            
//         });

//         logFile(final.join("\n"));
//         //logFile(JSON.stringify(procedures))
//         // console.log(procedures);
//     })

// return ;

    var sqlStringWithRef = "ALTER TABLE {TABLE} ADD {COLUMN} {COLUMN_TYPE} {DEFAULT} REFERENCES {FOREIGN_TABLE}({FOREIGN_ID});"
    var sqlString = "ALTER TABLE {TABLE} ADD {COLUMN} {COLUMN_TYPE} {DEFAULT};"
    

    let finalSql = [];
    getTablesFromDatabase("MASI_TESTES",(tables)=>{

        for (let i = 0; i < tables.length; i++) {
            const element = tables[i];
            let tmpSql = [];
            if(element.table_name =="UTILIZADORES"){

                new_tables.forEach(el => {
                    let sqltmp;
                    if(el.reference){
                         sqltmp = sqlStringWithRef
                        .split('{TABLE}').join(element.table_name)
                        .split('{COLUMN}').join(el.name)
                        .split('{COLUMN_TYPE}').join(el.type)
                        .split('{FOREIGN_TABLE}').join(el.reference.table)
                        .split('{FOREIGN_ID}').join(el.reference.column);
                    }else{
                         sqltmp =sqlString
                        .split('{TABLE}').join(element.table_name)
                        .split('{COLUMN}').join(el.name)
                        .split('{COLUMN_TYPE}').join(el.type)
                        ;
                    }

                    if(el.default){
                        sqltmp=  sqltmp.split('{DEFAULT}').join('DEFAULT(' + el.default+')')
                    }else{
                        sqltmp=sqltmp.split('{DEFAULT}').join('')
                    }

                    tmpSql.push(sqltmp);

                });
            }
            finalSql.push(tmpSql.join('\n'));
            
        }
        console.log(finalSql.join('\n\n'));
        
        // console.log("MAKING FILES------------------------------------------------")
        // logFile(JSON.stringify(tables));
        // console.log("MAKING FILES------------------------------------------------")
        })

        
}, 500);

 

