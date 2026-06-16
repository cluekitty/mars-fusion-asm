## Versioning
There is no regular release schedule. New releases are allowed to be dropped at any time.
Our version number consists of 0.MINOR.PATCH where:
- MINOR gets increased when we add or remove a new feature
- PATCH gets increased when the changes consist of only bug fixes

## Releasing for Developers
- Double check the changelog and try to make sure it looks up to date, that it has no obvious typos and that the release date is filled in. 
- Create and push a tag onto the `main` branch. The tag is just the version number — no prefixes or suffixes.
- Wait for CI to create a draft release with the assets, then edit that release and fill in the title and the description
  - The title is always the version number
  - The description is the changelog section for that version, including the header
