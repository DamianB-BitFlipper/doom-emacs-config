# My Doom Configuration

## Installation
- Enable `dap-mode` and then be sure to run `M-x dap-cpptools-setup` to setup the adapter before using it the first time.
- Run `doom sync` followed by `doom doctor`. Install any missing dependencies reported by doom doctor.
- For python lsp, run `pip install "python-lsp-server[all]"`
- For grip, run `pipx install grip`.
  - Then create a fine-grained access token on GitHub. No need for any repository access. 
    - This allows more access to the GitHub Markdown API
    - Add this configuration to `~/.authinfo` as per https://www.emacswiki.org/emacs/GnusAuthinfo
      - machine: api.github.com
      - login: <github username>
      - password: <access token>
