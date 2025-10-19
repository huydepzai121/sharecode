#!/usr/bin/env node

/**
 * Figma Design Tokens Extraction Script
 * Extracts design tokens from Figma and generates CSS variables
 */

const fs = require('fs');
const path = require('path');

// Figma design data (extracted from MCP server)
const figmaDesignTokens = {
  colors: {
    primary: {
      gradient: 'linear-gradient(160deg, #667EEA 0%, #764BA2 100%)',
      blue: '#667EEA',
      purple: '#764BA2'
    },
    secondary: {
      gradient: 'linear-gradient(164deg, #667EEA 0%, #764BA2 100%)'
    },
    background: {
      white: '#fff',
      light: '#f8f9fa',
      gray: '#f7fafc'
    },
    text: {
      primary: '#333333',
      secondary: '#9CA3AF',
      white: '#ffffff',
      muted: '#6B7280'
    },
    border: {
      light: '#e5e7eb',
      gray: '#d1d5db'
    }
  },
  typography: {
    fontFamily: {
      primary: 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif'
    },
    fontSize: {
      xs: '12px',
      sm: '13px',
      base: '14px',
      lg: '16px',
      xl: '18px',
      '2xl': '20px',
      '3xl': '24px'
    },
    fontWeight: {
      normal: '400',
      medium: '500',
      semibold: '600'
    },
    lineHeight: {
      tight: '1.25',
      normal: '1.5',
      relaxed: '1.75'
    }
  },
  spacing: {
    xs: '4px',
    sm: '8px',
    md: '12px',
    lg: '16px',
    xl: '20px',
    '2xl': '24px',
    '3xl': '32px',
    '4xl': '40px'
  },
  borderRadius: {
    sm: '6px',
    md: '12px',
    lg: '24px',
    xl: '48px'
  },
  shadows: {
    sm: '0 1px 2px 0 rgba(0, 0, 0, 0.05)',
    md: '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)',
    lg: '0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05)'
  }
};

/**
 * Generate CSS variables from design tokens
 */
function generateCSSVariables(tokens, prefix = '--figma') {
  let css = ':root {\n';
  
  function processTokens(obj, currentPrefix = '') {
    for (const [key, value] of Object.entries(obj)) {
      const cssVar = `${prefix}${currentPrefix}-${key}`;
      
      if (typeof value === 'object' && value !== null) {
        processTokens(value, `${currentPrefix}-${key}`);
      } else {
        css += `  ${cssVar}: ${value};\n`;
      }
    }
  }
  
  processTokens(tokens);
  css += '}\n\n';
  
  return css;
}

/**
 * Generate component CSS classes
 */
function generateComponentCSS() {
  return `
/* Figma Components CSS */

/* Button Components */
.figma-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: var(--figma-spacing-md) var(--figma-spacing-xl);
  border-radius: var(--figma-borderRadius-md);
  font-family: var(--figma-typography-fontFamily-primary);
  font-size: var(--figma-typography-fontSize-base);
  font-weight: var(--figma-typography-fontWeight-medium);
  text-decoration: none;
  border: none;
  cursor: pointer;
  transition: all 0.2s ease;
}

.figma-btn-primary {
  background: var(--figma-colors-primary-gradient);
  color: var(--figma-colors-text-white);
}

.figma-btn-primary:hover {
  transform: translateY(-1px);
  box-shadow: var(--figma-shadows-md);
}

.figma-btn-secondary {
  background: transparent;
  color: var(--figma-colors-text-primary);
  border: 1px solid var(--figma-colors-border-light);
}

.figma-btn-secondary:hover {
  background: var(--figma-colors-background-light);
}

/* Card Components */
.figma-card {
  background: var(--figma-colors-background-white);
  border-radius: var(--figma-borderRadius-lg);
  border: 1px solid var(--figma-colors-border-light);
  box-shadow: var(--figma-shadows-sm);
  overflow: hidden;
  transition: all 0.3s ease;
}

.figma-card:hover {
  transform: translateY(-2px);
  box-shadow: var(--figma-shadows-lg);
}

.figma-card-image {
  width: 100%;
  height: 200px;
  object-fit: cover;
}

.figma-card-content {
  padding: var(--figma-spacing-xl);
}

.figma-card-title {
  font-size: var(--figma-typography-fontSize-lg);
  font-weight: var(--figma-typography-fontWeight-semibold);
  color: var(--figma-colors-text-primary);
  margin-bottom: var(--figma-spacing-md);
}

.figma-card-price {
  font-size: var(--figma-typography-fontSize-base);
  font-weight: var(--figma-typography-fontWeight-semibold);
  color: var(--figma-colors-text-primary);
}

/* Statistics Card */
.figma-stats-card {
  background: rgba(102, 126, 234, 0.1);
  border: 1px solid rgba(102, 126, 234, 0.2);
  border-radius: var(--figma-borderRadius-md);
  padding: var(--figma-spacing-xl);
  text-align: center;
}

.figma-stats-number {
  font-size: var(--figma-typography-fontSize-2xl);
  font-weight: var(--figma-typography-fontWeight-semibold);
  color: var(--figma-colors-text-white);
  display: block;
}

.figma-stats-label {
  font-size: var(--figma-typography-fontSize-sm);
  color: var(--figma-colors-text-white);
  opacity: 0.9;
}

/* Search Component */
.figma-search {
  display: flex;
  align-items: center;
  background: var(--figma-colors-background-white);
  border: 1px solid var(--figma-colors-border-light);
  border-radius: var(--figma-borderRadius-md);
  padding: var(--figma-spacing-md) var(--figma-spacing-lg);
  max-width: 600px;
}

.figma-search-input {
  flex: 1;
  border: none;
  outline: none;
  font-family: var(--figma-typography-fontFamily-primary);
  font-size: var(--figma-typography-fontSize-base);
  color: var(--figma-colors-text-primary);
}

.figma-search-input::placeholder {
  color: var(--figma-colors-text-secondary);
}

.figma-search-icon {
  color: var(--figma-colors-text-secondary);
  margin-right: var(--figma-spacing-md);
}

/* Technology Tags */
.figma-tech-tag {
  display: inline-block;
  background: var(--figma-colors-background-light);
  color: var(--figma-colors-text-muted);
  padding: var(--figma-spacing-xs) var(--figma-spacing-sm);
  border-radius: var(--figma-borderRadius-xl);
  font-size: var(--figma-typography-fontSize-xs);
  font-weight: var(--figma-typography-fontWeight-medium);
  margin-right: var(--figma-spacing-sm);
  margin-bottom: var(--figma-spacing-sm);
}

/* Hero Section */
.figma-hero {
  background: var(--figma-colors-primary-gradient);
  color: var(--figma-colors-text-white);
  padding: var(--figma-spacing-4xl) 0;
  text-align: center;
}

.figma-hero-title {
  font-size: var(--figma-typography-fontSize-3xl);
  font-weight: var(--figma-typography-fontWeight-semibold);
  margin-bottom: var(--figma-spacing-xl);
  line-height: var(--figma-typography-lineHeight-tight);
}

.figma-hero-subtitle {
  font-size: var(--figma-typography-fontSize-lg);
  opacity: 0.9;
  margin-bottom: var(--figma-spacing-3xl);
  line-height: var(--figma-typography-lineHeight-normal);
}

/* Responsive Design */
@media (max-width: 768px) {
  .figma-hero-title {
    font-size: var(--figma-typography-fontSize-2xl);
  }
  
  .figma-hero-subtitle {
    font-size: var(--figma-typography-fontSize-base);
  }
  
  .figma-card-content {
    padding: var(--figma-spacing-lg);
  }
  
  .figma-search {
    max-width: 100%;
  }
}
`;
}

/**
 * Main execution
 */
function main() {
  console.log('🎨 Extracting Figma design tokens...');
  
  // Generate CSS content
  const cssVariables = generateCSSVariables(figmaDesignTokens);
  const componentCSS = generateComponentCSS();
  const fullCSS = cssVariables + componentCSS;
  
  // Ensure output directory exists
  const outputDir = path.join(__dirname, '..', 'src', 'themes', 'sharecode', 'css');
  if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true });
  }
  
  // Write CSS file
  const outputPath = path.join(outputDir, 'figma-components.css');
  fs.writeFileSync(outputPath, fullCSS);
  
  console.log(`✅ Design tokens extracted to: ${outputPath}`);
  console.log('🚀 Ready to implement Figma components!');
}

// Run if called directly
if (require.main === module) {
  main();
}

module.exports = {
  figmaDesignTokens,
  generateCSSVariables,
  generateComponentCSS
};
