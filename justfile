set dotenv-load

# After configuring your `.env` file, run `just deploy` for a dry run, or `just deploy '--broadcast'` for the live deploy.
deploy flags='':
    #!/usr/bin/env bash
    set -euo pipefail

    echo "COMMIT HASH: $(git rev-parse HEAD)" >> deploys.txt

    # Save deploy addresses to `deploys.txt`
    just __deploy | grep -E '^(== Logs ==|  COMMIT HASH|  FOUNDRY_PROFILE|  CHAIN ID|  CHAIN NAME|  CounterBasic|  CounterWithImmutables)' >> deploys.txt

    echo "" >> deploys.txt

__deploy flags='':
    #!/usr/bin/env bash
    set -euo pipefail

    profiles=(
        "default"
        "no_optimizer_no_metadata"
        "yes_optimizer_no_metadata"
        "yes_optimizer_yes_metadata"
        "no_via_ir_no_metadata"
        "yes_via_ir_no_metadata"
        "yes_via_ir_yes_metadata"
        "no_metadata_no_cbor"
        "no_metadata_yes_cbor"
    )

    for profile in "${profiles[@]}"; do
        echo -e "\n======== DEPLOYING WITH PROFILE: $profile ========"
        FOUNDRY_PROFILE="$profile" \
            forge script script/DeployCounters.s.sol \
            --skip test \
            -vvv \
            --rpc-url $RPC_URL \
            --private-key $DEPLOYER_PRIVATE_KEY \
            {{flags}}
    done
