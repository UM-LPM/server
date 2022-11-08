name: Deploy machine manually

on:
  workflow_dispatch:
    inputs:
      machine:
        required: true
        type: string

concurrency: deploy

jobs:
  machine:
    uses: UM-LPM/server/.github/workflows/deploy-machine.yml@master
    with:
      machine: ${{inputs.machine}}
    secrets: inherit
