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
let toMerge = new Map();

// read the contents of the file into index as a array of each line
fs.readFile(indexFilepath, "utf-8", (err, data) => {
  if (err) {
    console.error("Error reading file: ${err.message}");
    exit();
  }
  initIndex(data);
  console.log(toMerge);
});

rl.on("line", (line) => {
  if (!line) {
    return;
  }
  // parse string, split at |
  const item = line.trim().split(" | ");
  const key = item[0];
  const cnt = parseInt(item[1]);
  const url = item[2];
  // if key in toMerge
  if (toMerge.get(key)) {
    // if url already exists, increment count
    const existingVal = toMerge.get(key);
    if (url in existingVal) {
      existingVal[url] += cnt;
    } else {
      // else set count to incoming cnt
      existingVal[url] = cnt;
    }
  } else {
    // else, set new key
    counts = new Map();
    counts.set([url], cnt);
    toMerge.set(key, counts);
  }
});

rl.on("close", () => {
  console.log(toMerge);
  mergeIndices();
});

const mergeIndices = () => {
  // output the merged hashmap
  var merged = "";
  // get sorted keys array
  const keys = Array.from(toMerge.keys()).sort();

  keys.forEach((key) => {
    const counts = toMerge.get(key);
    // console.log(counts);
    const urlToCnts = Array.from(counts.entries()).sort((a, b) => b[1] - a[1]);
    // console.log(urlToCnts);

    merged += key + " |";

    // add each url and cnt to the line
    urlToCnts.forEach((pair) => {
      merged += " " + pair[0] + " " + String(pair[1]);
    });
    // end line with new line
    merged += "\n";
  });
  console.log(merged);
};

const initIndex = (data) => {
  if (!data) {
    return;
  }

  const prevIndex = data.split("\n");
  prevIndex.forEach((line) => {
    if (!line) {
      return;
    }
    const item = line.split(" | ");
    const vals = item[1].split(" ");
    const counts = new Map();
    // adds to map url -> count
    for (let i = 0; i < vals.length; i += 2) {
      const url = vals[i];
      const cnt = parseInt(vals[i + 1]);
      counts.set([url], cnt);
    }
    // add each word to map of url -> counts
    toMerge.set(item[0], counts);
  });
};
