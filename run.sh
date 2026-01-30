#!/bin/bash

# Script to build and run the Jekyll website

set -e  # Exit on error

echo "🚀 Starting Jekyll website..."

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ Error: This script is designed for macOS only."
    echo "   Detected OS: $OSTYPE"
    echo "   Please install Ruby and Bundler manually for your operating system."
    exit 1
fi

echo "✅ Detected macOS"

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "❌ Error: Homebrew is not installed."
    echo "   Please install Homebrew first: https://brew.sh"
    echo "   Or run: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

# Function to get Ruby version number (e.g., "2.6.10" -> "2.6.10")
get_ruby_version() {
    ruby -v | cut -d' ' -f2 | cut -d'p' -f1
}

# Function to compare version numbers
version_ge() {
    # Compare version strings: returns 0 if $1 >= $2, 1 otherwise
    printf '%s\n%s\n' "$2" "$1" | sort -V -C
}

# Check if Ruby is installed, install if not
if ! command -v ruby &> /dev/null; then
    echo "📦 Ruby not found. Installing Ruby via Homebrew..."
    brew install ruby
    # Try to use Homebrew Ruby
    if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
        export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
    elif [ -d "/usr/local/opt/ruby/bin" ]; then
        export PATH="/usr/local/opt/ruby/bin:$PATH"
    fi
fi

# Ensure we're using Homebrew Ruby if available (newer version)
if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
    export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
elif [ -d "/usr/local/opt/ruby/bin" ]; then
    export PATH="/usr/local/opt/ruby/bin:$PATH"
fi

# Check Ruby version
RUBY_VERSION=$(get_ruby_version)
echo "✅ Ruby version: $RUBY_VERSION"

# Check if Ruby version is >= 3.0, upgrade if not
if ! version_ge "$RUBY_VERSION" "3.0.0"; then
    echo "⚠️  Ruby version $RUBY_VERSION is too old. Jekyll requires Ruby >= 3.0"
    echo "📦 Upgrading Ruby via Homebrew..."
    brew upgrade ruby || brew install ruby
    # Update PATH to use Homebrew Ruby
    if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
        export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
    elif [ -d "/usr/local/opt/ruby/bin" ]; then
        export PATH="/usr/local/opt/ruby/bin:$PATH"
    fi
    # Verify new version
    RUBY_VERSION=$(get_ruby_version)
    if ! version_ge "$RUBY_VERSION" "3.0.0"; then
        echo "❌ Error: Failed to upgrade Ruby. Current version: $RUBY_VERSION"
        echo "   Please manually install Ruby 3.0+ via Homebrew: brew install ruby"
        echo "   Then add to your PATH: export PATH=\"/opt/homebrew/opt/ruby/bin:\$PATH\""
        exit 1
    fi
    echo "✅ Ruby upgraded to version: $RUBY_VERSION"
fi

# Check if Bundler is installed, install if not
if ! command -v bundle &> /dev/null; then
    echo "📦 Bundler not found. Installing Bundler..."
    gem install bundler
else
    # Verify bundler is using the correct Ruby
    BUNDLER_RUBY=$(bundle --version 2>/dev/null || echo "")
    echo "✅ Bundler found"
fi

# Check if Gemfile exists, create one if it doesn't
if [ ! -f "Gemfile" ]; then
    echo "📝 Creating Gemfile..."
    cat > Gemfile << EOF
source "https://rubygems.org"

gem "jekyll", "~> 4.3"
gem "jekyll-paginate"
gem "jekyll-gist"
EOF
fi

# Install dependencies
echo "📦 Installing dependencies..."
bundle install

# Run Jekyll server
echo "🌐 Starting Jekyll development server..."
echo "📍 Website will be available at http://localhost:4000"
echo "🛑 Press Ctrl+C to stop the server"
echo ""

bundle exec jekyll serve
