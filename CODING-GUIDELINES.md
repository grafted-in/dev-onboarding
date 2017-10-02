# Grafted-In Coding Guidelines

This document outlines

  * how your code should *look* in order to
      * provide a consistent look and feel among all code bases.
      * increase a sense of "familiarity".
      * reduce overhead for team members who read your code.
  * some *best practices* in order to
      * help you avoid common pitfalls.
      * reduce overhead of making code work together.

## General Rules

### Rule 1: Most Important Rule

This is the most important rule. These guidelines are authoritative only in so much as they *help*. If you feel they get in the way then do the following, in this order:

  1. Discuss it with someone else on the team to see if you're just a bit off your rocker on this one.
  2. If you're not, maybe your case is just a tad bit odd and the guidelines don't really apply. In that case ignore them, do what's best, and move on.
  3. If your case is not odd and you really feel the guidelines are unhelpful, propose a change to the guidelines! (You may use a PR to this file if appropriate.)

### Rule 2: README

All projects must have a README. The README must describe:

  1. How to build the project.
  2. How/if to rely on automated linters (like `hlint`) and formatters (like `stylish-haskell`).
  3. Licensing

The README may describe explicit deviations from these guidelines. The README always wins.

### Rule 3: Use auto-formatting tools and stay consistent

Whenever possible, rely *first* on auto-formatting tools for each project. If an auto-formatter causes your code to look different from these guidelines, then the auto-formatter should win. If you're in a module that has a *clearly established* deviation from these guidelines, try hard to stay consistent with the style that's already there. If the deviation is small and not systemic, then feel free to correct it.

Refer to your project's README regarding how/if you should be relying on auto-formatters.


## H: Haskell Rules

Rules pertaining to Haskell code.

### H001: General Whitespace Usage

  1. Use 2 spaces for indentation; never tabs.
      * Forbidding tabs ensures that all team members see the same indentation.
      * Using 2 spaces makes indentation obvious while taking up as little horizontal space as possible.
  2. Do not indent the whole body of a module (the stuff after `module X where`).
      * It's not common to do this and it takes up unnecessary horizontal space.
  3. Put 1 newline at the end of the file (not more, not less).
      * This helps reduce noise in diffs because the end of the file always looks the same over time.


### H002: Module import grouping

Group your imports based on "external" dependencies and "internal" dependencies. Separate the groups with a new line. Place the group of external imports above the group of internal imports.

External modules come from packages that aren't part of the project. Internal modules are part of your project.

Example:

```haskell
module ThisModule where

import           Control.Monad (forever)
import qualified Data.List as L

import MyApp.State (State)
import MyApp.Types (User)

-- Code...
```

### H003: Module import ordering

Within each grouping of module imports, order the modules alphabetically, ignoring the difference between `import` and `import qualified`.

Example: See example in `H002`.

### H004: Record field naming

As much as possible, name records fields with this pattern: `_{camelCaseNameOfConstructor}{NameOfField}`

This avoids name ambiguities and makes it trivial to use `Control.Lens.TH.makeFields` to get nicely named lenses for the record.

Example:

```
data MyRecord = MyCtor{
    _myCtorAStringField :: !String,
    _myCtorAIntField    :: !Int
  }
```

### H005: [Basically] never combine records and sums in the same type

Don't define record types with multiple constructors. This makes the record field accessors/setters partial which leaves room for runtime errors.

Instead define record types separately from each constructor.

Example:

```haskell
-- instead of

data MyRecordBad = Bad1 { _bad1Field1 :: !String }
                 | Bad2 { _bad2Field1 :: !Int }

-- do this

data Good1 = Good1 { _good1Field1 :: !String }
data Good2 = Good2 { _good2Field1 :: !Int }

data MyRecord = MyRecordGood1 Good1 | MyRecordGood2 Good2
```

(In this case `Good1` and `Good2` can be `newtype`s.)

### H006: Prefer strict record fields

As much as possible make record fields strict.

This helps

  1. Prevent partial creation of records (lazy fields can be left uninitialized to `error` which pushes the error to runtime).
  2. Prevent space leaks.
