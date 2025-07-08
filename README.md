# ✨ Pi Squared — VSL Devnet One-Click Setup

Welcome to **Pi Squared** — your quickstart gateway to run or connect to the **VSL (Verifiable Settlement Layer)** Devnet ⚡️

Built by **SAINT KHEN** — [@admirkhen](https://twitter.com/admirkhen)

---

## 📌 What is this?

This repo helps you:
- 🐳 Spin up your **own LOCAL VSL Devnet node** (with Docker)
- ⚡️ Or connect directly to the **PUBLIC VSL Devnet RPC**
- 📂 Auto-generate `.env` for your wallet + RPC
- 🧩 Switch between fresh start or persistent local storage

---

## 🚀 How to Use

### 1️⃣ Clone this repo

```bash
git clone https://github.com/emmogrin/pi.git
cd pi
chmod +x pi-devnet.sh
./pi-devnet.sh
```

👉 Follow the prompts:

Choose Local or Public

Enter your VSL wallet address

If Local, choose Fresh start or Reuse DB

Done! 🚀



---

⚡️ What's Inside?

File	Purpose

pi-devnet.sh	One-click setup script
docker-compose.public.yml	Docker config for local Devnet node



---

📡 RPC Endpoints

✅ Public: https://rpc.vsl.pi2.network

✅ Local: http://localhost:44444


Explorer:

🔍 Public: https://explorer.vsl.pi2.network

🔍 Local: http://localhost:4000



---

🧩 Next Steps

✅ Connect your wallet with the VSL MetaMask Snap

✅ Submit claims, verify, settle!

✅ Use curl to test the RPC:
```

curl -X POST <RPC_URL> \
 -H "Content-Type: application/json" \
 -d '{"jsonrpc":"2.0","id":1,"method":"vsl_getHealth","params":{}}'
```


---

🫡 Credits

SAINT KHEN x Pi Squared
Built for the builders.
Follow @admirkhen for updates 🕊️


---

⚠️ Note

This setup is for DEVNET only.
Mainnet will differ.
Always back up your keys!


---

✨ Build, test, conquer. See you on-chain! 🚀
