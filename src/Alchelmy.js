exports.globEffect = function(reject){
  return function(resolve){
    return function(pattern){
      return function(){
        debugger
        const glob = require("glob");
        return glob(pattern, {}, function(err, results){
          if(err){
            reject(err)();
          }else{
            resolve(results)(); 
          }
        });
      };
    };
  };
};