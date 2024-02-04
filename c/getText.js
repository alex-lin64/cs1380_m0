#!/usr/bin/env node

// Extract text from a web page

const {convert} = require('html-to-text');
const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
});

// TODO Add some code
let extractedText = '';

rl.on('line', (line) => {
  // TODO Add some code
  extractedText += '\n' + line;
});

rl.on('close', () => {
  // TODO Add some code
  var text = convert(extractedText, {
    wordwrap: 130,
    baseElements: {selectors: ['body']},
  });
  var reg = /^\s+|\s+$/g;
  console.log(text.replace(reg, ''));
});
