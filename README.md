# Customer Support - Patient Validation

_Customer Support - Patient Validation Dashboard_

# DHC Care Management UI

This README is currently a work-in-progress and subject to change frequently!

## Table of Contents

-   [Installation and Usage](#installation-and-usage)
-   [Vite](#vite)
    -   [Static Assets](#static-assets)
-   [Material UI](#material-ui)
    -   [Customizing Material UI Components](#customizing-material-ui-components)
    -   [Overriding Material UI Styles](#overriding-material-ui-styles)
    -   [Creating New Components](#creating-new-components)
-   [Code Style](#code-style)
    -   [Editor Integration](#editor-integration)
        -   [Webstorm](#webstorm)
        -   [VS Code](#vs-code)
-   [Typography](#typography)
-   [Colors](#colors)
-   [Mirage](#mirage)
-   [Local Development Issues](#local-development-issues)
-   [TODO](#todo)

## Installation and Usage

<!-- TODO: Update the Node/NPM version if it changes. -->

We use [NVM](https://github.com/nvm-sh/nvm) to manage our Node version. This app is built with Node `v14.17.4` and NPM
`v7.20.x`.

It's very important that you are at least using `v7` of NPM as it handles dependencies differently than `v6`. Using
different versions of NPM can lead to merge conflicts in your `package-lock.json`. To install a different version of
NPM, run `npm i -g npm@7.20`.

```bash
git clone https://adi-digitalhealthcare@dev.azure.com/adi-digitalhealthcare/Medical%20Products%20Software/_git/dhc-clinical-reviewer-ui
cd dhc-clinical-reviewer-ui
nvm use
npm i
npm start
```

## Vite

This project uses a new JavaScript compiler and bundler, [Vite](https://vitejs.dev).

Vite differs from traditional tools like Webpack and Rollup in that it only targets modern browsers (browsers that
support `<script type="module">`) and it uses [`esbuild`](https://esbuild.github.io) under-the-hood, which is written in
[Golang](https://golang.org). This leads to exponentially faster builds in development. For production builds, it uses
Rollup.

If legacy (i.e., Internet Explorer) browsers must be supported, Vite provides an official
[plugin](https://github.com/vitejs/vite/tree/main/packages/plugin-legacy) to do just that.

### Static Assets

With Vite, you can import static assets (images, fonts, etc) like you would with Webpack's `file-loader`. The list of
extensions supported by default can be found
[here](https://github.com/vitejs/vite/blob/main/packages/vite/src/node/constants.ts).

If you need to add a different extension to the list, you can do so with the
[`assetsInclude`](https://vitejs.dev/config/#assetsinclude) configuration property.

## Material UI

This app uses the Material UI component library for React. Specifically, the `v5-beta` branch, which is a complete
rewrite from `v4`. **Make sure you are using the `next.material-ui.com` documentation, otherwise you'll be writing the
wrong code!**

While the library is called "Material", it does not enforce following Google's Material design language. Every
individual component can be customized either at the instance level or globally. Material ships with a default theme
that can be completely customized. Even the default props of every component can be customized at the global level.

Under-the-hood, Material UI uses the [Emotion](https://emotion.sh) library for styling. Emotion is one of the most
widely-used styling solutions for React.

Material UI is the most popular open source component library for React and has robust documentation.

### Customizing Material UI Components

There are multiple ways to customize components in Material UI. The 2 most common ways will be the
[`sx`](https://next.material-ui.com/system/the-sx-prop) prop and the
[System Props](https://next.material-ui.com/system/properties).

The `sx` prop accepts a style object and is theme-aware, so you can use colors like `primary.main`.

The System Props allow you to pass style properties as React props, which are great for one-off customizations. For
example, adding some `marginLeft` to a button.

Note that the `sx` prop styles take precedence over the System Props. For example:

```javascript
<Typography sx={{ color: 'red' }} color="blue">
    Hello, world!
</Typography>
```

In the above example, the text should be `red` because of the `sx` prop.

### Overriding Material UI Styles

Sometimes you might run into a situation where your styles are not overriding Material UI's. The workaround for this is
to use [CSS specificity](https://developer.mozilla.org/en-US/docs/Web/CSS/Specificity) to give preference to your
styles. If you've used Sass before, this will be familiar to you.

All Material UI components will be given a class you can use. For example, the `<Typography />` component will always
have the `MuiTypography-root` class. For example:

```typescript jsx
<Typography
    sx={{
        '&.MuiTypography-root': {
            fontFamily: '"Times New Roman", serif',
        },
    }}
>
    Hello, world!
</Typography>
```

In the above example, your `fontFamily` will always take precedence because the generated selector will be more
specific.

### Creating New Components

There are 2 ways to create new components: the `<Box />` component and the `styled()` function.

The <Box /> component is actually a `styled('div')` with the `MuiBox-root` class name added to it as well as the System
Props.

When creating a component with `styled()`, you _will_ get the `sx` prop but you _will not_ get the System Props.

As a rule of thumb, use `<Box />` at the top level and use `styled()` to apply styles to your nested elements. For
example:

```typescript jsx
import type { PropsWithChildren, ReactElement } from 'react';

import { styled } from '@mui/material/styles';
import Box, { BoxProps } from '@mui/material/Box';

const Wrapper = ({ children, ...rest }: PropsWithChildren<BoxProps>): ReactElement => {
    const InnerDiv = styled('div')({ height: '100%', display: 'flex', alignItems: 'center', justifyContent: 'center' });

    return (
        <Box sx={{ height: '100vh' }} {...rest}>
            <InnerDiv>{children}</InnerDiv>
        </Box>
    );
};

export default Wrapper;
```

The importance of using Box is that all of our custom components should have the System Props, otherwise we will end up
with some components having them and some components not.

## Code Style

We will be using a combination of Airbnb's JS/React style guide, recommended TypeScript rules, and a slightly modified
Prettier formatting configuration. The usage of TypeScript and the 4-space indentation were required by engineering
leadership.

If you find that a particular rule adds more frustration than value, simply bring it up with the team on Teams and we
can create a PR to update it.

There are a few commands you can use to check your code against the style guide:

```bash
# Check for TypeScript errors
npm run build:ts

# Check for ESLint errors
npm run lint

# Fix ESLint errors
npm run lint:fix

# Check for Prettier errors
npm run format

# Format files according to Prettier.
npm run format:fix
```

> _Note: Prettier will format all JS, TS, HTML, CSS, JSON, Yaml, and Markdown files._

### Editor Integration

#### Webstorm

Install the following plugins:

-   [Prettier](https://plugins.jetbrains.com/plugin/10456-prettier)
-   [EditorConfig](https://plugins.jetbrains.com/plugin/7294-editorconfig)

Webstorm comes with ESLint support automatically. When configuring Prettier, use the following glob pattern and enable
"On save".

```
{**/*,*}.{js,ts,jsx,tsx,html,css,json,yml,md}
```

#### VS Code

Install the following extensions:

-   [`auto-close-tag`](https://marketplace.visualstudio.com/items?itemName=formulahendry.auto-close-tag)
-   [`auto-rename-tag`](https://marketplace.visualstudio.com/items?itemName=formulahendry.auto-rename-tag)
-   [`editorconfig`](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig)
-   [`prettier-vscode`](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
-   [`vscode-eslint`](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)

The [.vscode](./.vscode) folder includes editor settings for VS Code include a debugger launch configuration.

## Typography

We use 2 fonts: [Barlow](https://fonts.google.com/specimen/Barlow) and
[DM Sans](https://fonts.google.com/specimen/DM+Sans).

Barlow is used for all text outside of the data table (links, headings, buttons, inputs, etc).

DM Sans is used to display data including column headers and filters.

When in doubt, just consult the Figma designs.

## Colors

Material UI provides a default theme that can be overridden. You can read the docs on the default theme
[here](https://next.material-ui.com/customization/default-theme).

This table shows our custom color palette.

| Color Name             | Main      | Light     | Dark      | Contrast Text |
| ---------------------- | --------- | --------- | --------- | ------------- |
| Primary (Blue)         | `#0067b9` | `#80b3dc` | `#005294` | `#ffffff`     |
| Secondary (Light Blue) | `#e7ebf6` | `#f1f6fd` | `#cbd4eb` | `#22252f`     |
| Success (Green)        | `#129868` | `#dbf0e8` | `#129868` | `#ffffff`     |
| Error (Red)            | `#cc1111` | `#fae7e7` | `#b80f0f` | `#ffffff`     |
| Warning (Orange)       | `#ff8000` | `#fff2e6` | `#f85900` | `#ffffff`     |
| Info (Purple)          | `#7a45f8` | `#c396ff` | `#390095` | `#ffffff`     |

_Note: If the color of the element you're working on doesn't appear to match Figma, try using Figma's "Pick Color"
helper (Ctrl+C on Mac)._

## Mirage

The [Mirage](https://miragejs.com) library is used to intercept XHR and Fetch requests, which allows us to make mock API
calls. This means we can develop features before their respective back-end APIs have been created.

Mirage is a powerful library and you can use as much or as little of it as you want. Two important concepts are
[pass-through routes](https://miragejs.com/docs/getting-started/overview/#passthrough) and
[external origins](https://miragejs.com/docs/main-concepts/route-handlers/#external-origins).

A pass-through route allows you to bypass Mirage for specific routes. This is useful if you need to test a particular
endpoint against a real backend.

By default, Mirage will use the origin that your app is running on (e.g., `http://localhost:3000`). If your app is
making cross-origin API requests, use the fully-qualified URL when defining your routes, like this:

```javascript
// Do this
this.get('https://dev.analog.com/api/users', () => {
    /* ... */
});

// Not this
this.get('/api/users', () => {
    /* ... */
});
```

## Local Development Issues

If you run into issues with either Vite or Storybook locally, try deleting their respective caches first.

```bash
# The rimraf package is cross-platform (Bash/Zsh, PowerShell, CMD, etc).
npx rimraf node_modules/.cache
npx rimraf node_modules/.vite
```

Then try deleting the browser's cache (Application > Storage > Clear site data in Chrome Devtools) or loading the app in
an incognito window.

## TODO

-   [ ] Add SVG icons (use Material's `SVGIcon` component).
-   [ ] Run `tsc` and `eslint` when pushing to a remote branch.

## Cosign

ECR repo will be digitally signed using cosign tool with aws kms key.
