# Changelog

## 0.3.0 (2025-07-27)

### New Features

- Added support for retrieving supported languages from the DeepL API, allowing users to fetch
  available source and target languages.

### Documentation

- Updated usage examples and formatting to demonstrate the new language retrieval feature and
  clarify option usage.
- Improved readability of example responses with multi-line formatting.

### Bug Fixes

- Standardized option names with colon prefixes and quoted string values for consistency in
  documentation.

### Tests

- Added tests for the new language retrieval functionality.
- Updated header-related tests to reflect changes in required request headers.

## 0.2.0 (2025-07-26)

### New Features

- Introduced text rephrasing functionality for Pro users, allowing rephrasing of single or
  multiple texts with style and tone options.
- Added new modules for translation and rephrasing, providing clearer and more robust APIs.

### Bug Fixes

- Addressed a compilation error related to API key configuration.

### Documentation

- Updated usage examples, module names, and introductory text in the documentation and README.
- Added a centered logo and new CI badge to the README.
- Expanded changelog with recent updates and detailed usage examples.
- Improved API reference and getting started guides for clarity.

### Tests

- Added and updated tests for translation, rephrasing, and usage features to reflect API changes.

## 0.1.2 (2025-07-20)

- Fix compilation error because API key was set as module attribute instead of config.

## 0.0.1 (2025-07-19)

- Added `Deepl.Translator` module for translating text.
- Added `Deepl.Usage` module for retrieving usage and quota information.
