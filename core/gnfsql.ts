
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
  env:string;

  connector:any;
   constructor({
    host,
    port,
    user,
    password,
    database,
    env,
  }: {
    host: string;
    port?:string;
    user: string;
    password?: string;
    database: string;
    env?: string;
  }) {
    this.host = host;
    this.port = port;
    this.user = user;
    this.password = password;
    this.database = database;
    this.env = env;

    if(env == "mssql"){
      const sql = require('mssql')
      var ctx = this;
       sql.connect(`Server=${host}${(port)?(","+port):""};Database=${database};User Id=${user};Password=${password}; Trusted_Connection=True;TrustServerCertificate=True;`).then(()=>{
        ctx.connector = sql;
       });
     
    }else{
      var mysql2 =  require("mysql2");
      this.connector = mysql2.createConnection({
        host: this.host,
        user: this.user,
        password:this.password,
        database: this.database
      });
      console.log("Connected: ", this.connector)
    }
    
  }

  /**
   * Function for executing mysql queries based on the connection providaded
   * @param query SQL Query that will be executed
   * @param _callback A function that takes 3 args (error, results, fileds) 
   */
 async run(query: string,_callback:Function) {
  // simple query
  if(this.env == "mssql"){
    const result = await this.connector.query(query);
    _callback(result)
  }else{
    this.connector.query(
      query,
      function(err, results, fields) {
        _callback(results)
      }
    );
  }
  
  }
}


export default SQL;
 