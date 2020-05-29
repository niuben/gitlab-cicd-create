var path = require("path");
var file = require("./util/file");

module.exports =  function(){
                    
    var yamlContent = file.read(path.join(__dirname, "./gitlab-ci.tpl.yml"));
    
    var filePath = path.join(process.cwd(), ".gitlab-ci.yml");

    if(file.isExist(filePath)){
        console.log("该目录下已经有gitlab-ci.yml");
        filePath = path.join(process.cwd(), ".gitlab-ci.tpl.yml");
    }
    file.create(filePath, yamlContent);

}