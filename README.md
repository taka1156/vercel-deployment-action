# action-vercel-pages　(WIP)

## Workflow for Deployment to Vercel

The concept is similar to using actions to create a `gh-pages` branch for deployment. Here, actions are used to create a `vercel` branch, which is then set as the production branch in Vercel settings to enable a comparable operational setup.

## Workflow Steps
1. Organize files in actions based on the contents listed in `.vercelkeep`. The patterns are as follows:
   - Files that are in Git and also in `.vercelkeep`   
   　→ **Keep as Git-managed files**.
   - Files not in Git but listed in `.vercelkeep` (e.g., files generated during the build process)  
   　→ **Add to Git as target files for the next step into the `vercel` branch**.  
   - Files in Git but not in `.vercelkeep`  
   　→ **Remove from Git and delete them** (to avoid cluttering Vercel with unnecessary files).

2. Commit and push changes to the `vercel` branch.

## Post-Setup
1. For the first time setup, update the settings in Vercel under **Settings > Environments > Production** and set the **Branch Tracking** to `vercel`.

2. Optionally, you can add the following configuration to prevent builds from running on branches other than `vercel`. For the GUI, this can be achieved under **Settings > Git** in the **Ignored Build Step**. (This is not directly related to the workflow and is optional.)


   <details>
    <summary> vercel-build.sh </summary>

    ```shell
    #!/bin/bash

    echo "VERCEL_ENV: $VERCEL_ENV"
    echo "VERCEL_GIT_COMMIT_REF: $VERCEL_GIT_COMMIT_REF"

    if [[ "$VERCEL_GIT_COMMIT_REF" == "vercel" && "$VERCEL_ENV" == "production" ]] ; then
       # Proceed with the build
       echo "✅ - Build can proceed"
       exit 1;
    else
       # Don't build
       echo "🛑 - Build cancelled"
       exit 0;
    fi
    ```

    </details>

    <details>
    <summary> vercel </summary>

    ```json
    {
      "$schema": "https://openapi.vercel.sh/vercel.json",
      "ignoreCommand": "bash vercel-build.sh"
    }
    ```

    </details>


## config

| **Option Name**     | **Description**                | **Required** | **Default Value**                |
|---------------------|--------------------------------|--------------|----------------------------------|
| `branch`           | Branch name for deployment    | Not required | `'vercel'`                |
| `git_name`         | Git `user.name` for testing   | Not required | `'GitHub Actions'`               |
| `git_email`        | Git `user.email` for testing  | Not required | `'actions@github.com'`           |
| `commit_message`   | Commit message for testing    | Not required | `'Add files for Vercel deployment at $(TZ=Asia/Tokyo date '+%Y-%m-%d %H:%M:%S')'` |


## TODO
- [ ] Migrate testing and operation verification environments to Act and Devcontainer.
