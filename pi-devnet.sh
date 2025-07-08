#!/usr/bin/env bash

# 🌟 SAINT KHEN x Pi Squared Devnet Connector 🌟

# Colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 🌟 ASCII Banner
echo -e "${CYAN}"
cat << "EOF"
   ╔══════════════════════════════════════════════════════╗
   ║         ✨ PI SQUARED - VERIFIABLE SETTLEMENT LAYER ✨ ║
   ║                Powered by SAINT KHEN                ║
   ║               Follow @admirkhen for more!           ║
   ╚══════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

echo -e "${GREEN}🚀 Connecting to the PUBLIC Pi Squared VSL Devnet...${NC}"

# RPC URL
VSL_RPC_URL="https://rpc.vsl.pi2.network"

# Prompt for master account
read -p "🔑 Enter your VSL_MASTER_ADDR (public address): " VSL_MASTER_ADDR

# Write .env
echo "VSL_MASTER_ADDR=$VSL_MASTER_ADDR" > .env
echo "VSL_RPC_URL=$VSL_RPC_URL" >> .env
echo -e "${GREEN}✅ .env created with your address and RPC URL.${NC}"

# Quick test
echo -e "\n${CYAN}🧪 Test your connection:${NC}"
echo "curl -X POST $VSL_RPC_URL -H \"Content-Type: application/json\" -d '{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"vsl_getHealth\"}'"

echo -e "\n${CYAN}🔗 Next Steps:${NC}"
echo "👉 Use the VSL MetaMask Snap to connect to: $VSL_RPC_URL"
echo "👉 Explore transactions at: https://explorer.vsl.pi2.network"

echo -e "\n${GREEN}✨ All set! Frictionless settlement awaits. 🚀${NC}"
