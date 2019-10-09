Many times we have a moment when we are not able to read our code, and it’s turned hard in development mode just because of the style inconsistency like semicolumn, string declaration with a mix of single-quote and double-quote, or bad indentation? Or it’s gonna hard when we have an unused variable or a typo that can affect our program. Code consistency is really important. It can make things easier, either in the development phase or maintenance phase. There are some ways to avoid those problems mentioned, and here are some tools that can help us.

## ESLint
According to eslint.org, ESLint is a tool for identifying and reporting on patterns found in ECMAScript/JavaScript code, with the goal of making code more consistent and avoiding bugs. In many ways, it is similar to JSLint and JSHint with a few exceptions:
- ESLint uses [Espree](https://github.com/eslint/espree) for JavaScript parsing.
- ESLint uses an AST to evaluate patterns in code.
- ESLint is completely pluggable, every single rule is a plugin and you can add more at runtime.
- To use ESLint, first we need to type this command in our terminal on our project directory or to install ESLint using npm:
Prerequisites: [Node.js](https://nodejs.org/en/) (>=8.10), npm version 3+.
`$ npm install eslint --save-dev`
You should then set up a configuration file:
`$ ./node_modules/.bin/eslint --init`

![demo](https://github.com/TeAmP0is0N/blog.codingblocks.com/blob/gh-pages/img/post/demo.png)

After that, you can run ESLint on any file or directory like this:
`$ ./node_modules/.bin/eslint yourfile.js`
It is also possible to install ESLint globally rather than locally (using `npm install eslint --global`).However, this is not recommended, and any plugins or shareable configs that you use must be installed locally in either case. Now, if you are using a text editor like Visual Studio Code, you will see some red curly lines under the text that ESLint scanned as an error. Or, you can scan it manually using this command `$ ./node_modules/.bin/eslint test1.js test2.js` Another way, to check every file on your project, you can type `$ ./node_modules/.bin/eslint` in your terminal.
You can also exclude some files or directories using gitignore with adding this command behind the original command `-- ignore-path .gitignore` .
To see the full documentation, you can click [here](https://eslint.org/docs/user-guide/command-line-interface).

## Configuration
Note: If you are coming from a version before 1.0.0 please see the [migration guide](https://eslint.org/docs/user-guide/migrating-to-1.0.0).
After running, you’ll have a `.eslintrc` file in your directory. In it, you’ll see some rules configured like this:
```bash
{
    "rules": {
        "semi": ["error", "always"],
        "quotes": ["error", "double"]
    }
}
```
The names `"semi"` and `"quotes"` are the names of [rules](https://eslint.org/docs/rules/) in ESLint. The first value is the error level of the rule and can be one of these values:
- `"off"` or `0` - turn the rule off
- `"warn"` or `1` - turn the rule on as a warning (doesn’t affect exit code)
- `"error"` or `2` - turn the rule on as an error (exit code will be 1)
The three error levels allow you fine-grained control over how ESLint applies rules (for more configuration options and details, see the [configuration docs](https://eslint.org/docs/user-guide/configuring)).
Your `.eslintrc` configuration file will also include the line:
`"extends": "eslint:recommended"`
Because of this line, all of the rules marked “” on the [rules page](https://eslint.org/docs/rules/) will be turned on. Alternatively, you can use configurations that others have created by searching for “eslint-config” on [npmjs.com](https://www.npmjs.com/search?q=eslint-config). ESLint will not lint your code unless you extend from a shared configuration or explicitly turn rules on in your configuration.

## Next Steps
- Learn about [advanced configuration](https://eslint.org/docs/user-guide/configuring) of ESLint.
- Get familiar with the [command line options](https://eslint.org/docs/user-guide/command-line-interface).
- Explore [ESLint integrations](https://eslint.org/docs/user-guide/integrations) into other tools like editors, build systems, and more.
- Can’t find just the right rule? Make your own [custom rule](https://eslint.org/docs/developer-guide/working-with-rules).
- Make ESLint even better by [contributing](https://eslint.org/docs/developer-guide/contributing/).

## Husky
So, now if there are some problems with the code, you know how to check them. However, you are sometimes too busy to fix it or you just miss it. In order to force people to fix the code before commit it, you can use Husky. You need Husky to run a command before `git commit` runs. In this case, you use Husky to run ESLint. If a problem is found, Husky will stop the process and commit will fail. On the other hand, if no problem is found, `git commit` will run as usual. To install Husky you just need to type `npm install husky -- save-dev` on your project folder’s terminal. After installing, type this code in `package.json` to configure Husky.

```bash
"husky": {
  "hooks": {
    "pre-commit": "pretty-quick --staged && lint-staged"
   }
 },
 ```

The pretest command checks all the files, not just staged files. `--fix`option was added to the command to fix small problems like indentation or semicolon, but you need to add the files again. This might be a problem later and to handle this you can use Lint-staged.

## Lint-Staged
Lint-Staged can be used to run multiple commands and it can also check staged files only and add it to the stage so you only commit code that passes the test. Version 10 of `lint-staged` is coming with changes that help it run faster on large git repositories and prevent loss of data during errors. Please help test the `next` version and report any inconsistencies in their [GitHub Issues](https://github.com/okonet/lint-staged/issues):
# Using npm
`npm install --save-dev lint-staged@next` 
# Using yarn
`yarn add -D lint-staged@next`

## Notable changes
- A git stash is created before running any tasks, so in case of errors any lost changes can be restored easily (and automatically unless lint-staged itself crashes)
- Instead of write-tree/read-tree, `lint-staged@next` uses git stashes to hide unstaged changes while running tasks against staged files
- This results in a performance increase of up to 45x on very large repositories.
- The behavior of committing modifications during tasks (eg. `prettier --write && git add`) is different. The current version creates a diff of these modifications, and applies it against the original state, silently ignoring any errors. The `next` version leaves modifications of staged files as-is, and then restores all hidden unstaged changes as a patch. If applying the patch fails due to a merge conflict (because tasks have modified the same lines), a 3-way merge will be retried. If this also fails, the entire commit will fail and the original state will be restored.
- `TL;DR` the `next` version will never skip committing any changes by task (due to a merge conflict), but might fail in very complex situations where unstaged changes cannot be restored cleanly. If this happens to you, we are very interested in a repeatable test scenario.

[This is the demo of how partially staged files support works in 🚫💩 lint-staged.](https://asciinema.org/a/199934?source=post_page-----8bea54365add----------------------)

## Why
Linting makes more sense when running before committing to your code. By doing so you can ensure no errors go into the repository and enforce the code style. But running a lint process on a whole project is slow and linting results can be irrelevant. Ultimately you only want to lint files that will be committed.
This project contains a script that will run arbitrary shell tasks with a list of staged files as an argument, filtered by a specified glob pattern.
Above npm or yarn command is needed to run to the terminal to install this tool before you can use it and edit the file package.json with the following code configure lint-staged:
```bash
"husky": {
"hooks": {
"pre-commit": "pretty-quick --staged && lint-staged"
}
},
"lint-staged": {
"*.js": [
"eslint --fix",
"git add"
]
```
Lint staged only checks staged files. If an error is found but fixable with `--fix` , Lint-staged will fix it, but if not, Husky will stop the process.
Your program may not bug-less, but if it is consistent and pretty, it would be easier to debug and maintain it. These tools are only meant to reduce the chance for potential problems to arise. At the end of the day, you and/or your team are the ones in charge to make sure your code is easy to read.

`@JavaScript @Developer_Stories @Eslint @Linter @Husky`

- [medium.com](https://medium.com/@rsrathaurorai/a-guide-to-utilize-git-hook-by-using-eslint-husky-and-lint-staged-8bea54365add)
- [LinkedIn.com](https://www.linkedin.com/pulse/guide-utilize-git-hook-using-eslint-husky-lint-staged-rathaur/)
- [Rohit Rathore](https://www.linkedin.com/in/rohit-singh-rathaur/)