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

rl.on("line", (line) => {
  if (!line) {
    return;
  }
  // parse string, split at |
  const item = line.trim().split(" | ");
  const key = item[0];
  const cnt = parseInt(item[1]);
  const url = item[2];

  counts = new Map();
  counts.set([url], cnt);
  toMerge.set(key, counts);
});

rl.on("close", async () => {
  // console.log(toMerge);

  await processFile();

  // console.log(toMerge);
  printIndices();
});

const processFile = async () => {
  // read the contents of the file into index as a array of each line
  try {
    const data = await new Promise((resolve, reject) => {
      fs.readFile(indexFilepath, "utf-8", (err, data) => {
        if (err) {
          reject(err);
        } else {
          resolve(data);
        }
      });
    });
    mergePrev(data);
  } catch (err) {
    console.error(`Error reading file: ${err.message}`);
    exit();
  }
};

const printIndices = () => {
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

const mergePrev = (data) => {
  // merge previous gloabl index with incoming index
  if (!data) {
    return;
  }

  const prevIndex = data.split("\n");
  prevIndex.forEach((line) => {
    if (!line) {
      return;
    }
    const [key, valString] = line.split(" | ");
    const vals = valString.split(" ");

    // adds to map url -> count
    for (let i = 0; i < vals.length; i += 2) {
      const url = vals[i];
      const cnt = parseInt(vals[i + 1]);

      // if key in toMerge
      if (toMerge.get(key)) {
        // if url already exists, increment count
        const existingVal = toMerge.get(key);
        if (url in existingVal) {
          existingVal.set(url, existingVal.get(url) + cnt);
        } else {
          // else set count to incoming cnt
          existingVal.set(url, cnt);
        }
      } else {
        // else, set new key
        const counts = new Map();
        counts.set([url], cnt);
        toMerge.set(key, counts);
      }
    }
  });
};
