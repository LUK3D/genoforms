import SQL from "./gnfsql";

var auth = new SQL({host:"127.0.0.1",user:"root",database:"angola"})


var formStruct = {tables:Array<Object>()};

// Get list of databases on the connection
auth.run("SHOW DATABASES",(error,results)=>{
    console.log("DATABASES: ", results);
})

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


