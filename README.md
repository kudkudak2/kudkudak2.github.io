# Personal Website

A Jekyll-based personal website hosted on GitHub Pages.

## Quick Start (macOS)

The easiest way to get started is using the automated script:

```bash
./run.sh
```

or

```bash
bash run.sh
```

This script will:
- ✅ Check if you're on macOS (required)
- ✅ Install/upgrade Ruby (>= 3.0) via Homebrew if needed
- ✅ Install Bundler if needed
- ✅ Create a `Gemfile` if it doesn't exist
- ✅ Install all dependencies
- ✅ Start the Jekyll development server

The website will be available at `http://localhost:4000`. Press `Ctrl+C` to stop the server.

**Note:** The script requires Homebrew. If you don't have it installed, get it from [https://brew.sh](https://brew.sh)

## Manual Installation

If you prefer to set things up manually or are on a different operating system:

### Prerequisites

- **Ruby** (version 3.0 or higher required)
- **Bundler** (Ruby gem package manager)
- **Jekyll** (static site generator)

### Installation Steps

1. **Install Ruby dependencies**

   If you don't have a `Gemfile`, create one with the following content:

   ```ruby
   source "https://rubygems.org"
   
   gem "jekyll", "~> 4.3"
   gem "jekyll-paginate"
   gem "jekyll-gist"
   ```

   Then install the dependencies:

   ```bash
   bundle install
   ```

2. **Install Jekyll and Bundler** (if not already installed)

   ```bash
   gem install bundler jekyll
   ```

### Running Locally

1. **Start the Jekyll development server**

   ```bash
   bundle exec jekyll serve
   ```

   Or if you have Jekyll installed globally:

   ```bash
   jekyll serve
   ```

2. **View the website**

   Open your browser and navigate to:

   ```
   http://localhost:4000
   ```

   The site will automatically regenerate when you make changes to source files.

## Building for Production

To build the static site files:

```bash
bundle exec jekyll build
```

The generated site will be in the `_site` directory.

## Project Structure

- `_config.yml` - Jekyll configuration file
- `_layouts/` - HTML layout templates
- `_includes/` - Reusable HTML components
- `_sass/` - SASS stylesheets (using Bourbon and Neat)
- `_data/` - Data files (JSON format)
- `_posts/` - Blog posts (if any)
- `assets/` - Static assets (images, CSS, JS, PDFs)
- `index.html` - Homepage

## Deployment

This site is configured for GitHub Pages. Simply push your changes to the repository, and GitHub Pages will automatically build and deploy the site.

The site URL is configured in `_config.yml` as `http://kudkudak.github.io`.

## Additional Notes

- The site uses SASS for styling with Bourbon and Neat libraries
- Jekyll plugins used: `jekyll-paginate` and `jekyll-gist`
- SASS files are automatically compiled during the build process
