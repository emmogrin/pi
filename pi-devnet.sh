#!/usr/bin/env bash

# 🌟 SAINT KHEN x Pi Squared One-Click Devnet Setup 🌟

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 🌟 ASCII Blessing Banner
echo -e "${CYAN}"
cat << "EOF"
   ╔══════════════════════════════════════════════════════╗
   ║         ✨ PI SQUARED - VERIFIABLE SETTLEMENT LAYER ✨ ║
   ║                Powered by SAINT KHEN                ║
   ║               Follow @admirkhen for more!           ║
   ╚══════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

echo -e "${GREEN}🚀 Starting Pi Squared VSL Devnet Setup...${NC}"

docker_check_needed=false

# ---------------------------------------------
# Prompt: Local or public devnet
# ---------------------------------------------
echo -e "${YELLOW}🔹 Do you want to:${NC}"
echo "1) Run your own LOCAL devnet node (Docker required)"
echo "2) Connect to the PUBLIC devnet RPC (no Docker needed)"
read -p "👉 Enter 1 or 2: " DEVNET_CHOICE

# Set RPC URL based on choice
if [ "$DEVNET_CHOICE" == "1" ]; then
    VSL_RPC_URL="http://localhost:44444"
    docker_check_needed=true
else
    VSL_RPC_URL="https://rpc.vsl.pi2.network"
fi

# ---------------------------------------------
# Prompt: Get your VSL Master Address
# ---------------------------------------------
read -p "🔑 Enter your VSL_MASTER_ADDR (public address): " VSL_MASTER_ADDR

# Write .env
echo "VSL_MASTER_ADDR=$VSL_MASTER_ADDR" > .env
echo "VSL_RPC_URL=$VSL_RPC_URL" >> .env
echo -e "${GREEN}✅ .env created with RPC: $VSL_RPC_URL${NC}"

# ---------------------------------------------
# If LOCAL, check Docker & handle Docker Compose
# ---------------------------------------------
if [ "$docker_check_needed" = true ]; then

  # Docker check
  if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}❌ Docker is not installed. Please install Docker & Docker Compose then try again.${NC}"
    exit 1
  fi

  # Check docker-compose.public.yml exists
  if [ ! -f docker-compose.public.yml ]; then
    echo -e "${YELLOW}❌ docker-compose.public.yml not found in this folder. Please make sure it exists.${NC}"
    exit 1
  fi

  # Check for anchors
  if ! grep -q "command: # Fresh start" docker-compose.public.yml; then
    echo -e "${YELLOW}❌ Missing 'command: # Fresh start' anchor in docker-compose.public.yml.${NC}"
    exit 1
  fi

  if ! grep -q "# command: # Use existing database" docker-compose.public.yml; then
    echo -e "${YELLOW}❌ Missing '# command: # Use existing database' anchor in docker-compose.public.yml.${NC}"
    exit 1
  fi

  echo -e "\n${YELLOW}🔹 Choose storage mode:${NC}"
  echo "1) Fresh start (reset chain every time)"
  echo "2) Reuse existing DB (keep chain state)"
  read -p "👉 Enter 1 or 2: " STORAGE_CHOICE

  # Toggle Docker Compose command block
  if [ "$STORAGE_CHOICE" == "1" ]; then
      sed -i '/# command: # Use existing database/,+5 s/^/#/' docker-compose.public.yml
      sed -i '/command: # Fresh start/,+5 s/^# //' docker-compose.public.yml
      echo -e "${GREEN}🔄 Using fresh start mode.${NC}"
  else
      sed -i '/command: # Fresh start/,+5 s/^/#/' docker-compose.public.yml
      sed -i '/# command: # Use existing database/,+5 s/^# //' docker-compose.public.yml
      echo -e "${GREEN}🔄 Using persistent storage mode.${NC}"
  fi

  echo -e "\n${CYAN}🐳 Pulling Docker images...${NC}"
  docker compose -f docker-compose.public.yml pull

  echo -e "\n${CYAN}🚀 Launching VSL devnet containers...${NC}"
  docker compose -f docker-compose.public.yml up -d

  echo -e "\n${GREEN}✅ Your LOCAL VSL Devnet is live!${NC}"
  echo "----------------------------------------"
  echo "🌐 RPC URL: $VSL_RPC_URL"
  echo "🌐 Explorer UI: http://localhost:4000"

else
  echo -e "\n${GREEN}✅ You chose to connect to the PUBLIC devnet — no local node will run.${NC}"
  echo "----------------------------------------"
  echo "🌐 RPC URL: $VSL_RPC_URL"
  echo "🌐 Explorer UI: https://explorer.vsl.pi2.network"
fi

# ---------------------------------------------
# Quick health check
# ---------------------------------------------
echo -e "\n${CYAN}🧪 Testing your RPC health now...${NC}"
curl -X POST $VSL_RPC_URL -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","id":1,"method":"vsl_getHealth","params":{}}'

# ---------------------------------------------
# Next Steps
# ---------------------------------------------
echo -e "\n${CYAN}🔗 Next Steps:${NC}"
echo "👉 Use the VSL MetaMask Snap to connect to: $VSL_RPC_URL"
echo "👉 Open your Explorer UI:"
if [ "$DEVNET_CHOICE" == "1" ]; then
  echo "   → http://localhost:4000"
else
  echo "   → https://explorer.vsl.pi2.network"
fi

echo -e "\n${GREEN}✨ All done! Build, test & conquer. 🚀${NC}"
