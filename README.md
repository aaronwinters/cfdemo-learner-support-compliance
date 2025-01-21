# cfdemo-learner-support-compliance
Sample solution package for Cactusforce '25 demonstration 

## Setup
This project uses CumulusCI as the build tool. [Set up the Salesforce CLI and CumulusCI](https://cumulusci.readthedocs.io/en/latest/get-started.html).

Connect CumulusCI to the GitHub account used to access this repository.
`cci service connect github mygithub`

Connect CCI to DevHub
`cci org connect {org-alias}` Authenticate to the devhub org for the project (e.g. a developer or production org)
`cci service connect devhub --project` Tell CCI the alias of the devhub org to use for this project (org that was connected in previous step)

Verify DevHub and GitHub service
`cci service list`

## Feature Development

1. Pull *develop* branch to get latest updates `git pull origin main`
1. Create feature branch off of *main* branch `git checkout -b feature/issue-key-descriptiveBranchName`
1. Run `cci flow run dev_org --org dev` to create a new scratch org and deploy this project.
1. Run `cci org browser dev` to open the org in your browser.
1. Either develop locally and push to scratch org, or develop in scratch org and pull changes
1. If developing feature in scratch org run `cci task run list_changes --org dev` to see changes that will sync
1. If developing feature in scratch org run `cci task run retrieve_changes --org dev -o exclude "Profile:"` to retrieve the changes locally, excluding profiles - avoiding using profiles where possible
1. If developing locally, run `cci task run dx_push --org dev` to push local changes to scratch org
1. Add and commit changes to feature branch `git add .` and `git commit -m "Issue Key: descriptive commit message"`
1. Push feature branch to GitHub and create a pull request to *main* branch for review `git push origin feature/issue-key-descriptiveBranchName`
1. Delete the scratch org `cci org scratch_delete dev`

## Release Process
* Create a beta unlocked package `cci flow run release_unlocked_beta --org dev`
* Create a production version package `cci flow run release_unlocked_production --org dev`