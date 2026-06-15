#!/bin/bash

# ==============================================================================
#  PROJECT: AUTOMATED SERVER MANAGEMENT SUITE
#  FILE: install.sh (Automated Bootstrapper & Loader)
# ==============================================================================

# 1. Define temporary working space
WORK_DIR="/tmp/server-tools"

# 2. Clean up any previous installation remnants
rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR"

# 3. Pull the dynamic repository matrix natively via Git
if ! command -v git &> /dev/null; then
    echo "[INFO] Installing git dependency..."
    apt-get update && apt-get install -y git
fi

echo "[INFO] Fetching latest environment assets from GitHub..."
git clone --quiet https://github.com/Ebiram/ubuntu-server-manager.git "$WORK_DIR"

# 4. Enforce global execution rights on all downloaded modules
chmod +x "$WORK_DIR/main.sh"
chmod +x "$WORK_DIR/modules/"*.sh 2>/dev/null

# 5. Hand over control directly to the main orchestrator menu
cd "$WORK_DIR"
./main.sh
