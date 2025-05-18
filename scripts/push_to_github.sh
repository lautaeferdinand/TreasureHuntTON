#!/bin/bash

# Navigate to the project root directory
cd "$(dirname "$0")/.."

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Please install git using 'pkg install git' in Termux."
    exit 1
fi

# Check if the repository is initialized
if [ ! -d ".git" ]; then
    echo "No Git repository found. Expected a cloned repository."
    exit 1
fi

# Ensure .gitignore exists
if [ ! -f ".gitignore" ]; then
    echo "Creating .gitignore..."
    cat <<EOL > .gitignore
# Environment files
.env
# Logs
logs/
# Sessions
sessions/
# Node modules
mini-apps/node_modules/
# Build artifacts (optional, remove if you want to include them)
build/
EOL
fi

# Pull changes from remote to avoid conflicts
git pull origin main || {
    echo "Git pull failed. Resolve conflicts manually and try again."
    exit 1
}

# Add all files
git add .

# Commit changes with a default message
git commit -m "Update project files" || {
    echo "Nothing to commit."
    exit 0
}

# Push to GitHub (assuming main branch)
git push origin main || {
    echo "Push failed. Ensure you have access to the repository and correct credentials."
    echo "You may need to set up SSH keys or use a personal access token."
    exit 1
}

echo "Successfully pushed to GitHub!"
