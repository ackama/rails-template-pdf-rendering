/**
 * node.js script to render a given HTML file into the given PDF filename.
 * Details of the API are at https://developers.google.com/web/tools/puppeteer/
 *
 * This command is invoked as:
 *
 *   $ node bin/render-pdf.js input.html output.pdf
 *
 */

const puppeteer = require("puppeteer");

const [,, rawInputPath, outputPath] = process.argv;
const inputPath = `file://${rawInputPath}`;

console.log("Input path:", inputPath);
console.log("Output path:", outputPath);

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  console.log("Starting PDF conversion");
  await page.goto(inputPath, { waitUntil: "networkidle2" });

  // https://github.com/GoogleChrome/puppeteer/blob/v1.4.0/docs/api.md#pagepdfoptions
  await page.pdf({
    path: outputPath,
    format: "A4"
  });

  console.log("PDF conversion complete");
  await browser.close();
})();
