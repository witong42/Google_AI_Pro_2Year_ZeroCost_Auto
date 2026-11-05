========================================================================
  Google AI Pro (5 TB) zero-cost 2 years (US$0.00 -> 24 months) full-auto console
========================================================================

[1. Requirements]
Common:
1. Google Chrome installed (the macOS default location /Applications works)
2. Network: a US proxy on this machine, or a proxy template pasted into the console

Windows 10 / 11:
3. Python 3.10 or newer, installed with "Add Python to PATH"

macOS:
3. Python 3.10 or newer (brew install python@3.12, or the python.org installer)
4. The first run creates a local virtualenv (.venv) inside the project; dependencies
   stay in it and never touch the system Python

[2. Quick start]
Windows:
1. First use: double-click [1_first_run_install_and_start.bat]
2. Daily use: double-click [2_start_console.bat]

macOS:
1. First use: double-click [1_first_run_install_and_start.command]
2. Daily use: double-click [2_start_console.command]
3. If macOS says "cannot be opened because the developer cannot be verified":
   right-click the file -> Open, or run once in Terminal: chmod +x *.command

Either way the browser opens the console at http://127.0.0.1:8765 on its own.

[3. Entering your card and running accounts]
1. Card details (required):
   - In the "Global tax-free region, zero-cost 2-year Pro plan and card settings"
     block on the left, enter your own Visa or Mastercard foreign card:
     * Card number (16 digits)
     * Expiry (month / year, e.g. 08 / 29)
     * Security code (3-digit CVC)
     * Cardholder name as printed on the card
     * The tax-free ZIP is pre-filled with 97201 (Oregon, no sales tax) — leave it
   - Click [💾 Save settings] after filling it in.
   - The script has a hard zero-cost guard: it only clicks subscribe when the
     checkout dialog confirms US$0.00, so nothing is ever charged.

2. Bulk-import Google accounts:
   - Paste accounts into the "Bulk import" box on the right, one per line. Supported:
     * email----password----recovery email
     * email----password----recovery email----2FA secret
     * email----password----2FA secret
   - Click [➕ Import account list].

3. Start the automation:
   - Click [▶ Run full flow] next to one account, or the batch run button at the top.
   - The script does, in order:
     Step 1: sign in to Google and pass the recovery email / 2FA check
     Step 2: inline tax-free card binding + tier 1 12-month free package (US$0.00)
     Step 3: stack tier 2 6-month free package (US$0.00 -> 18 months)
     Step 4: stack tier 3 6-month free package (US$0.00 -> 24-month cap)
     Step 5: go to Google Play, cancel auto-renew, lock the 2-year entitlement and
             screenshot it as proof


# Card shop: https://faka.cdkey.si
# Blog: https://blog.caowo.de
# TG group: @Hello_Florence
