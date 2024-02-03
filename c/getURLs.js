#!/usr/bin/env node

const readline = require("readline");
const { JSDOM } = require("jsdom");
const { URL } = require("url");

// Example usage:
const inputURL = new URL(process.argv[2]);
if (inputURL.pathname.endsWith("/index.html")) {
  inputURL.pathname = inputURL.pathname.slice(0, -"/index.html".length);
}
if (inputURL.pathname.endsWith("/")) {
  inputURL.pathname = inputURL.pathname.slice(0, -"/".length);
}
const baseURL = inputURL.toString() + "/";

const rl = readline.createInterface({
  input: process.stdin,
});

// TODO some code
const extractedUrls = [];

rl.on("line", (line) => {
  // TODO some code
  const dom = new JSDOM(line);

  // extract urls
  const anchors = dom.window.document.querySelectorAll("a");
  anchors.forEach((anchor) => {
    const href = anchor.getAttribute("href");

    // error check for proper url
    if (href) {
      const url = new URL(href, baseURL).href;
      extractedUrls.push(url);
    }
  });
});

rl.on("close", () => {
  // TODO some code
  if (extractedUrls.length == 0) {
    return;
  }
  console.log(extractedUrls.join("\n"));
});
