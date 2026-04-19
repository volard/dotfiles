1. Install
 - firefox
 - terminal
 - internet connection (sucky place to live in)

2. Setup ssh server
```bash
sudo apt install -y openssh-server
sudo systemctl enable --now ssh
sudo ss -tlnp | grep :22 # that's check
```
3. Install tools
  - uv
  - bun
  - playwright with deps and browser
  - agent-browser
  - summarize
  - ollama
  - llmfit
  - browser-use
  - camoufox
  - rtk and enable it globally

4. Install skills
5. Install openclaw
6. Install git and configure
```bash
git config --global init.defaultBranch
cd ~/.openclaw
git init
git add .
git commit -m "init"
git remote add origin <url>
git push
```
7. Put ~/.openclaw in git private repo

8. Config openclaw


