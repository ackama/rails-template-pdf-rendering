/**
 * node.js script to render a given HTML file into the given PDF filename.
 * Details of the API are at https://developers.google.com/web/tools/puppeteer/
 *
 * This command is invoked as:
 *
 *   $ node bin/render-pdf.js input.html output.pdf
 *
 */

const puppeteer = require('puppeteer');

const [, , rawInputPath, outputPath] = process.argv;
const inputPath = `file://${rawInputPath}`;

console.log('Input path:', inputPath);
console.log('Output path:', outputPath);

(async () => {
  // Allow setting the path to Chrome via environment variable. This is usually
  // not required but is useful for folks doing dev in WSL on Windows
  const chromePath = process.env.PDF_RENDERING_PATH_TO_CHROME || undefined;

  // `--no-sandbox` is required on Heroku - see
  // https://github.com/puppeteer/puppeteer/blob/main/docs/troubleshooting.md#running-puppeteer-on-heroku
  const browser = await puppeteer.launch({
    args: ['--no-sandbox'],
    executablePath: chromePath
  });

  try {
    const page = await browser.newPage();

    console.log('Starting PDF conversion');
    await page.goto(inputPath, { waitUntil: 'networkidle2' });

    // Puppeteer docs: https://pptr.dev/
    await page.pdf({
      path: outputPath,
      format: 'A4'
    });

    console.log('PDF conversion complete');
  } finally {
    await browser.close();
  }
})().catch(error => {
  console.error(error);

  process.exit(1);
});

