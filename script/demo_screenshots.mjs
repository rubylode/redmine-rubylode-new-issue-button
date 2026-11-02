// README screenshots of the header with the button, from the demo Redmine, in its default theme.
//   npm run screenshots
import { mkdirSync } from "node:fs"
import { baseUrl, launch, signedInPage } from "./browser.mjs"

const out = new URL("../docs/screenshots/", import.meta.url).pathname
mkdirSync(out, { recursive: true })

const browser = await launch()
const page = await signedInPage(browser, "dana", "demo-password-1", { width: 1440, height: 700 })
for (const [name, path] of [["button-in-project", "/projects/demo-orchard"], ["button-outside-project", "/issues"]]) {
  await page.goto(`${baseUrl}${path}`, { waitUntil: "load" })
  await page.waitForSelector("a.rubylode-new-issue-button")
  await page.mouse.move(2, 400)
  await page.screenshot({ path: `${out}${name}.png`, clip: { x: 0, y: 0, width: 1440, height: 140 } })
  console.log("saved", `${name}.png`)
}
await browser.close()
