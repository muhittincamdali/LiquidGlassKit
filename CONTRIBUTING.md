# Contributing to LiquidGlassKit

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing.

## Code of Conduct

This project adheres to a code of conduct. By participating, you are expected to uphold this code. Please be respectful and constructive in all interactions.

## How to Contribute

### Reporting Bugs

1. Check existing issues to avoid duplicates
2. Use the bug report template
3. Include reproduction steps
4. Provide environment details (Xcode version, iOS version, device)

### Suggesting Features

1. Check existing feature requests
2. Use the feature request template
3. Explain the use case and benefits
4. Consider implementation complexity

### Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Write clean, documented code
4. Add tests for new functionality
5. Ensure all tests pass (`swift test`)
6. Commit with conventional commits (`feat:`, `fix:`, `docs:`, etc.)
7. Push and open a Pull Request

## Development Setup

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/LiquidGlassKit.git
cd LiquidGlassKit

# Open in Xcode
open Package.swift

# Run tests
swift test
```

## Code Style

- Follow Swift API Design Guidelines
- Use SwiftLint for consistency
- Write descriptive variable/function names
- Document public APIs with DocC comments

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation only
- `style:` Formatting, no code change
- `refactor:` Code restructuring
- `test:` Adding tests
- `chore:` Maintenance tasks

## Testing

- Write unit tests for new features
- Maintain existing test coverage
- Test on multiple iOS versions when possible
- Test backward compatibility (iOS 15-25 fallbacks)

## Questions?

Open a discussion or reach out via issues. We're happy to help!

---

Thank you for contributing! 🎉
