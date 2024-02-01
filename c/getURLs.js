#!/usr/bin/env node

const readline = require("readline");
const { JSDOM } = require("jsdom");
const { URL } = require("url");
const { format } = require("path");

// Example usage:
const inputURL = new URL(process.argv[2]);
if (inputURL.pathname.endsWith("/index.html")) {
  inputURL.pathname = inputURL.pathname.slice(0, -"/index.html".length);
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
  console.log(extractedUrls.join("\n"));
});
