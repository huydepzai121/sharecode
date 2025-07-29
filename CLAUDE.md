# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a NukeViet 5.x CMS project with custom modules for "sharecode" and "wallet" functionality. NukeViet is a Vietnamese open-source CMS built with PHP and MySQL, supporting multi-language sites and modular architecture.

## Development Commands

### CSS/SCSS Development
```bash
# Admin theme CSS compilation and processing
npm run admin-css              # Full admin CSS build (compile + prefix + RTL)
npm run admin-compile          # Compile SCSS to CSS only
npm run admin-css-prefix       # Add autoprefixer to admin CSS
npm run admin-css-rtl          # Generate RTL versions of admin CSS
npm run watch-admin            # Watch admin SCSS files for changes

# Core CSS compilation and processing  
npm run core-compile           # Compile core SCSS to CSS
npm run core-css-prefix        # Add autoprefixer to core CSS
npm run core-css-rtl          # Generate RTL versions of core CSS
npm run core-css-minify       # Minify core CSS files
npm run watch-core-css        # Watch core SCSS files for changes
```

### Testing
```bash
# Install testing dependencies first
composer install
npm install

# Run all tests
php vendor/bin/codecept run

# Run only unit tests (requires installed website)
php vendor/bin/codecept run Unit

# Run specific test groups
php vendor/bin/codecept run -g install    # Installation tests
php vendor/bin/codecept run -g users      # User functionality tests
php vendor/bin/codecept run -g stat       # Statistics tests
php vendor/bin/codecept run -g all        # All tests
```

### Setup for Development
```bash
# Get source code
git clone https://github.com/nukeviet/nukeviet.git
cd nukeviet
git checkout nukeviet5.0

# Install dependencies
npm install
composer install

# For Selenium testing
npm install selenium-standalone -g
selenium-standalone install
selenium-standalone start  # Keep running in separate terminal
```

## Project Architecture

### Directory Structure
- **`src/`** - Main application directory (webroot)
- **`src/modules/`** - Custom modules (sharecode, wallet, news, users, etc.)
- **`src/themes/`** - Theme files (admin_default, admin_future, default, mobile_default)
- **`src/assets/`** - Static assets (CSS, JS, images, fonts)
- **`src/includes/`** - Core library files and utilities
- **`src/data/config/`** - Configuration files
- **`scss/`** - SCSS source files for themes
- **`tests/`** - Codeception test suites

### Module System
NukeViet uses a modular architecture where each module contains:
- **`functions.php`** - Core module functions
- **`admin.functions.php`** - Admin-specific functions  
- **`version.php`** - Module version and metadata
- **`funcs/`** - Frontend function handlers
- **`admin/`** - Backend administration files
- **`blocks/`** - Reusable block components
- **`language/`** - Multi-language support files
- **`theme.php`** - Theme integration functions

### Custom Modules
- **sharecode** - Main code sharing functionality with categories, tags, and reviews
- **wallet** - Payment/wallet system with multiple payment gateways (VNPay, PayPal, etc.)

### Configuration
- **Main config**: `src/config.php` (database, site settings)
- **Global config**: `src/data/config/config_global.php`
- **Module configs**: Individual module settings in admin panel

### Theme System
- **Admin themes**: `admin_default`, `admin_future` (Bootstrap-based)
- **Frontend themes**: `default`, `mobile_default`
- **SCSS compilation**: Source in `scss/` compiled to theme CSS directories
- **RTL support**: Automatic RTL CSS generation for right-to-left languages

### Database
- **Prefix**: `nv5_` (configurable)
- **Charset**: utf8mb4_unicode_ci
- **System**: MySQL 5.5+ required

### Key Technologies
- **Backend**: PHP 8.2-8.4, MySQL
- **Frontend**: Bootstrap 5.3.3, jQuery, SCSS
- **Build tools**: Node.js, NPM, Sass, PostCSS, autoprefixer
- **Testing**: Codeception with Selenium WebDriver

## Development Notes

### CSS Development Workflow
1. Edit SCSS files in `scss/admin_future/` or `scss/core/`
2. Run appropriate watch command (`npm run watch-admin` or `npm run watch-core`)
3. SCSS compiles to CSS with source maps, autoprefixer, and RTL generation

### Module Development
- Follow NukeViet naming conventions: `nv_modulename_functionname()`
- Use `$module_data` for database table names
- Implement proper security checks with `defined('NV_MAINFILE')`
- Support multi-language with language files in `language/` directory

### Testing Requirements
- Website must be fully installed for unit tests
- Selenium server required for acceptance tests  
- Use test groups to run specific functionality tests
- Environment configuration in `.env` file (copy from `.env.example`)