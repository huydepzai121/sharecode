# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is ShareCode 2, a customized version of NukeViet CMS 5.x focused on code sharing functionality. The project is a PHP-based content management system with modules for user management, wallet functionality, and code marketplace features.

**Core Architecture:**
- **Framework**: NukeViet CMS 5.x (PHP-based CMS)
- **Database**: MySQL with utf8mb4 collation
- **Frontend**: Bootstrap 5.3.3, FontAwesome 6.5.1, jQuery, SASS/SCSS
- **Backend**: PHP 8.2+ with custom module architecture

## Development Commands

### CSS/SCSS Development
```bash
# Build admin theme CSS
npm run admin-css

# Watch admin theme files for changes
npm run watch-admin

# Build core CSS
npm run core-compile
npm run core-css-prefix
npm run core-css-rtl
npm run core-css-minify

# Watch core files for changes  
npm run watch-core
```

### Build Commands
```bash
# Full admin theme build
bash scripts/build.sh

# Install dependencies
npm install
composer install

# Core CSS minification
bash scripts/core-css-minify.sh
```

### Testing
```bash
# Run all tests
php vendor/bin/codecept run

# Run unit tests only
php vendor/bin/codecept run Unit

# Run specific test groups
php vendor/bin/codecept run -g install
php vendor/bin/codecept run -g users
```

## Directory Structure

**Key Directories:**
- `src/` - Main application code (webroot)
- `src/modules/` - Custom modules (sharecode, wallet, etc.)
- `src/themes/` - Theme files (default, mobile_default, admin_future)
- `src/assets/` - Static assets (CSS, JS, images)
- `src/includes/` - Core PHP libraries and functions
- `scss/` - Source SCSS files
- `build/` - Build configuration
- `scripts/` - Build and utility scripts

**Module Structure:**
Each module follows NukeViet conventions:
- `functions.php` - Module functions
- `admin.functions.php` - Admin functions  
- `theme.php` - Frontend templates
- `admin/` - Admin interface files
- `action_mysql.php` - Database schema

## Key Modules

### ShareCode Module
Primary module for code sharing marketplace functionality located in `src/modules/sharecode/`:
- Categories management
- Code file handling
- User dashboard and purchase history
- Favorites and notifications system

### Wallet Module  
Payment and virtual currency system in `src/modules/wallet/`:
- Multi-currency support
- Transaction management  
- Balance operations (money_in, money_out)
- Exchange functionality
- API integration for external wallet services

### Core Modules
- `users/` - User management with extended wallet integration
- `news/` - Content management
- `admin/` - Administrative interface

## Configuration Files

- `src/config.php` - Database and core configuration
- `src/data/config/config_global.php` - Global system settings
- Database prefix: `nv4`
- Default collation: `utf8mb4_unicode_ci`

## API Integration

The system includes wallet API integration:
- `API_WALLET_URL` - External wallet service endpoint
- `API_WALLET_KEY` & `API_WALLET_SECRET` - Authentication credentials
- Located in `src/config.php`

## Theme Development

**Admin Theme (admin_future):**
- SCSS source files in `scss/admin_future/`  
- Compiled to `src/themes/admin_future/css/`
- Bootstrap 5-based with custom variables
- Supports RTL layouts

**Frontend Themes:**
- Default responsive theme in `src/themes/default/`
- Mobile-specific theme in `src/themes/mobile_default/`
- Block-based layout system with JSON configuration

## Database Architecture

- Uses NukeViet's modular database structure
- Each module maintains its own tables with `nv4_` prefix
- Supports multiple languages with language-specific table variations
- Core tables include users, groups, modules, and module-specific data

## Asset Management

**CSS Workflow:**
1. Edit SCSS files in `scss/` directory
2. Run appropriate npm script to compile
3. Auto-prefixing and RTL generation included
4. Minification for production builds

**JavaScript:**
- Core libraries in `src/assets/js/`
- jQuery-based with custom extensions
- Module-specific JS files where needed

## Module Development Guidelines

When creating or modifying modules:
- Follow NukeViet module structure conventions
- Implement required files: `functions.php`, `theme.php`, `version.php`
- Use database abstraction layer for queries
- Implement proper language file support
- Follow security practices (XSS protection, SQL injection prevention)