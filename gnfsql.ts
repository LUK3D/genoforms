
/**
 * Authentication class used to create an autorization object with all necessary data.
 * @param host Hostname Ex: localhost:8080
 * @param user Database username Ex: root
 * @param database The name of the database that you want to connect with
 */
 class SQL {
  host: string;
  port:string;
  user: string;
  password: string;
  database: string;
  type:string;

  connector:any;
   constructor({
    host,
    port,
    user,
    password,
    database,
    type,
  }: {
    host: string;
    port?:string;
    user: string;
    password?: string;
    database: string;
    type?: string;
  }) {
    this.host = host;
    this.port = port;
    this.user = user;
    this.password = password;
    this.database = database;
    this.type = type;

    if(type == "mssql"){
      const sql = require('mssql')
      var ctx = this;
       sql.connect(`Server=${host}${(port)?(","+port):""};Database=${database};User Id=${user};Password=${password}; Trusted_Connection=True;TrustServerCertificate=True;`).then(()=>{
         console.log(`Server=${host}${(port)?(","+port):""};Database=${database};User Id=${user};Password=${password}`)
        ctx.connector = sql;
        console.log(ctx.connector)
       });
     
    }else{
      var mysql2 =  require("mysql2");
      this.connector = mysql2.createConnection({
        host: this.host,
        user: this.user,
        password:this.password,
        database: this.database
      });
    }
    
  }

  /**
   * Function for executing mysql queries based on the connection providaded
   * @param query SQL Query that will be executed
   * @param _callback A function that takes 3 args (error, results, fileds) 
   */
 async run(query: string,_callback:Function) {
  // simple query
  if(this.type == "mssql"){
    const result = await this.connector.query(query);
    _callback(result)
  }else{
    this.connector.query(
      query,
      function(err, results, fields) {
        _callback(err, results, fields)
      }
    );
  }
  
  }
}


export default SQL;
 