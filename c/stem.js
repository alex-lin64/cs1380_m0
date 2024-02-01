#!/usr/bin/env node

// use Porter Stemmer to stem individual terms in a streaming fashion

var readline = require("readline");
var natural = require("natural");

var rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
});

const porterStemmer = natural.PorterStemmer;

rl.on("line", function (line) {
  // TODO some code
  if (!line) {
    return;
  }
  var processedLine = line
    .trim()
    .replace(/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g, "");
  processedLine = porterStemmer.stem(processedLine);
  console.log(processedLine);
});
