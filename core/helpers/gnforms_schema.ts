/**
 * Geno data type schema
 */
class GENO_SCHEMA{
    database:string;
    tables:Array<GENO_TABLE>;
    lang:string;

    constructor({database, tables, lang}:{database:string,tables:Array<GENO_TABLE>, lang:string}){
        this.database = database;
        this.tables = tables;
        this.lang = lang;
    }
}

/**
 * Geno Table data type
 */
class GENO_TABLE{
    name:string;
    columns:Array<GENO_COLUMN>;
    
    constructor({name,columns}:{name:string,columns:Array<GENO_COLUMN>}){
        this.name = name;
        this.columns = columns;
    }
}

class GENO_COLUMN{
    name:string;
    type:string;
    default:any;
    char_max:Int32Array;
    is_nullable:Boolean;
    key_type:string;
   

    constructor({name,type,def,char_max,is_nullable, key_type}:{name:string, type:string,def:any,char_max?:Int32Array,is_nullable:string,key_type?:string}){
        this.name = name;
        this.type = type;
        this.key_type = key_type;
        this.default = def;
        this.char_max = char_max;
        this.is_nullable = (is_nullable != 'NO');
    }
}

export default GENO_TABLE;
export {GENO_TABLE,GENO_SCHEMA,GENO_COLUMN};

