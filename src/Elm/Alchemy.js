exports.globEffect = function(reject){
  return function(resolve){
    return function(pattern){
      return function(){
        return require("glob")(pattern, function(results){
          resolve(results)(); 
        });
      };
    };
  };
};