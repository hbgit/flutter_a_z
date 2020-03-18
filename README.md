# flutter_a_z

The goal is trying different flutter features, and apply CI/CD using github actions.

# v1.0

## Hello World sample

- $flutter create .
- Creating .github/worflows/dart.yml
- Setting up the https://codecov.io
- The APK generation adopts draft release
- Deploy APK in the github pages, the site will be published as $<$yourusername$>$.github.io/$<$repo-name$>$
- Setting up SSH GitHub
    - Check out https://github.com/JamesIves/github-pages-deploy-action using ssh
    - Create a new SSH key pair for your repository. Do not set a passphrase https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key
    - Copy the contents of the public key (.pub file) to a new repository deploy key and check the box to "Allow write access.": $ xclip -sel clip < ~/.ssh/deploy_key.pub
    - Add a secret (named SSH_PRIVATE_KEY) to the repository containing the entire contents of the private key.
        - Using xclip -sel clip < ~/.ssh/deploy_key
- Setting github pages
    - In order for your site to be published, a Jekyll theme must be chosen, even if you don't use Jekyll at all
    - Go to https://github.com/$<$yourusername$>$/$<$repo-name$>$/settings -> GitHub Pages -> Change theme
    

