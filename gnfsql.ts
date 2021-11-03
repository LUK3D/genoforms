var mysql2 =  require("mysql2");
/**
 * Authentication class used to create an autorization object with all necessary data.
 * @param host Hostname Ex: localhost:8080
 * @param user Database username Ex: root
 * @param database The name of the database that you want to connect with
 */
class SQL {
  host: string;
  user: string;
  password: string;
  database: String;

  connector:any;
  constructor({
    host,
    user,
    password,
    database,
  }: {
    host: string;
    user: string;
    password?: string;
    database?: string;
  }) {
    this.host = host;
    this.user = user;
    this.password = password;
    this.database = database;

    this.connector = mysql2.createConnection({
      host: this.host,
      user: this.user,
      password:this.password,
      database: this.database
    })
  }

  /**
   * Function for executing mysql queries based on the connection providaded
   * @param query SQL Query that will be executed
   * @param _callback A function that takes 3 args (error, results, fileds) 
   */
 async run(query: string,_callback:Function) {
  // simple query
  await this.connector.execute(
      query,
      function(err, results, fields) {
        _callback(err, results, fields)
        
      }
    );
  }
}



export default SQL;
