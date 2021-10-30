import SQL from "./configs"



var auth = new SQL({host:"localhost",user:"root",database:"angola"})

auth.run("Select all from users")