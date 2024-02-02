#!/usr/bin/env node

// merge two files---the incoming 1-page index and the global index (on disk)
// the details of the global index can be seen in the test cases.

const fs = require("fs");
const { exit } = require("process");
const readline = require("readline");

const rl = readline.createInterface({
  input: process.stdin,
});

// get filepath for global index
const indexFilepath = process.argv[2];
// index to merge
let toMerge = {};
// read the contents of the file into index as a array of each line
fs.readFile(indexFilepath, "utf-8", (err, data) => {
  if (err) {
    console.error("Error reading file: ${err.message}");
    exit();
  }

  const prevIndex = data.split("\n");
  prevIndex.forEach((line) => {
    const item = line.split(" | ");
    const vals = item[1].split(" ");
    const counts = {};
    // adds to map url -> count
    for (let i = 0; i < vals.length; i += 2) {
      const url = vals[i];
      const cnt = parseInt(vals[i + 1]);
      counts[url] = cnt;
    }
    // add each word to map of url -> counts
    toMerge[item[0]] = counts;
  });
});

rl.on("line", (line) => {
  // parse string, split at |
  const item = line.trim().split(" | ");
  const key = item[0];
  const cnt = parseInt(item[1]);
  const url = item[2];
  // if key in toMerge
  if (key in toMerge) {
    // if url already exists, increment count
    if (url in toMerge[key]) {
      toMerge[key][url] += cnt;
      return;
    }
    // else set count to incoming cnt
    toMerge[key][url] = cnt;
    return;
  }
  // else, set new key
  toMerge[key] = { [url]: cnt };
});

rl.on("close", () => {
  mergeIndices();
});

const mergeIndices = () => {
  // output the merged hashmap
  var merged = "";
  // get sorted keys array
  const keys = Object.keys(toMerge).sort();

  keys.forEach((key) => {
    const urlToCnts = Object.entries(toMerge[key]).sort((a, b) => b[1] - a[1]);
    merged += key + " |";

    // add each url and cnt to the line
    urlToCnts.forEach((url, cnt) => {
      merged += " " + url + " " + String(cnt);
    });
    // end line with new line
    merged += "\n";
  });
  console.log(merged);
};
