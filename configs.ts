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
  }

  run(query: string) {
    console.log("Your Query: ", query, this.host,this.user);
  }
}


export default SQL;
