# Git Push Workflow (GitHub CLI)
When pushing to GitHub in this environment:
1. SSH keys with passphrases will block headless agents waiting for user passphrase input.
2. The user has GitHub CLI (`gh`) authenticated under account `denisakov`.
3. To configure git to push seamlessly without prompting or hardcoding secrets:
   ```bash
   git remote set-url origin https://github.com/denisakov/<repo>.git
   gh auth setup-git
   git push -u origin <branch>
   ```
4. Never hardcode personal access tokens, private keys, or passwords in files or remote URLs.
