// Checks the button in the running demo: shown inside a project, shown outside one, hidden for a user who may not add
// issues and for a signed-out visitor.  npm run check
import { baseUrl, launch, signedInPage, anonymousPage } from "./browser.mjs"

const browser = await launch()
let failures = 0
const expect = (description, actual, expected) => {
  const ok = JSON.stringify(actual) === JSON.stringify(expected)
  if (!ok) failures += 1
  console.log(`${ok ? "ok  " : "FAIL"} ${description}${ok ? "" : ` (got ${JSON.stringify(actual)}, want ${JSON.stringify(expected)})`}`)
}
const buttonHref = async (page, path) => {
  await page.goto(`${baseUrl}${path}`, { waitUntil: "load" })
  return page.locator("a.rubylode-new-issue-button").evaluateAll((links) => links.map((link) => link.getAttribute("href")))
}

const dana = await signedInPage(browser, "dana", "demo-password-1")
expect("inside a project (Orchard) the button opens that project's form", await buttonHref(dana, "/projects/demo-orchard"), ["/projects/demo-orchard/issues/new"])
expect("outside a project the button opens the global form", await buttonHref(dana, "/issues"), ["/issues/new"])
expect("in a project where the user may not add issues (Quarry) the button falls back to the global form", await buttonHref(dana, "/projects/demo-quarry"), ["/issues/new"])

const sam = await signedInPage(browser, "sam", "demo-password-1")
expect("a user who may not add issues anywhere gets no button in a project", await buttonHref(sam, "/projects/demo-orchard"), [])
expect("a user who may not add issues anywhere gets no button outside a project", await buttonHref(sam, "/issues"), [])

const visitor = await anonymousPage(browser)
expect("a signed-out visitor gets no button", await buttonHref(visitor, "/login"), [])

await browser.close()
process.exit(failures ? 1 : 0)
