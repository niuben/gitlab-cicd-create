#!/usr/bin/env node 

var create = require("./create");

var argvArr = process.argv;
var argv = argvArr[argvArr.length - 1];

// console.log(argv);
console.log("创建开始....");
create(argv);
console.log("创建结束");
