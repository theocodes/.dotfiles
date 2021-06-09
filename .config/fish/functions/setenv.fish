function setenv -a item
    eval "_setenv_$item $argv"
end

function _setenv_aws
    argparse r/role -- $argv

    if not set -q _flag_role
        echo "setenv aws --role ROLE_NAME"
        return 0
    end

    set role $argv[2]
    set file "$HOME/.aws/cli/cache/$role.json"
    set contents "{}"

    if test -e $file
        set contents (cat $file)
        set -gx AWS_SESSION_TOKEN (echo $contents | jq -r '.Credentials.SessionToken // 1')
    else
        set -e AWS_SESSION_TOKEN
    end

    set -gx AWS_ACCESS_KEY_ID (echo $contents | jq -r '.Credentials.AccessKeyId // 1')
    set -gx AWS_SECRET_ACCESS_KEY (echo $contents | jq -r '.Credentials.SecretAccessKey // 1')

    set -e AWS_PROFILE
    set -e AWS_DEFAULT_PROFILE
end

function _setenv_bolt
    set -gx QUAY_ACCESS_TOKEN (secrets get quay_access_token)
    set -gx CIRCLE_TOKEN (secrets get circle_token)
    set -gx GITHUB_TOKEN (secrets get github_token)
end

function _setenv_terraform
    signin

    echo ">> setting terraform env variables"
    set -gx TF_VAR_bc_one_datadog_api_key (secrets get bc_one_datadog_api_key)
    set -gx TF_VAR_bc_one_datadog_app_key (secrets get bc_one_datadog_app_key)
    set -gx TF_VAR_bolt_datadog_api_key (secrets get bolt_datadog_api_key)
    set -gx TF_VAR_bolt_datadog_app_key (secrets get bolt_datadog_app_key)
end

function _setenv_fastly
    argparse r/env -- $argv

    set env $argv[2]

    if test -n "$env"
        signin

        echo ">> setting fastly token for: $env"
        set key (secrets get "fastly_api_token_$env")
        set -gx FASTLY_API_KEY $key
        set -gx TF_VAR_fastly_api_key $key

        set -gx TF_VAR_logging_s3_access_key (secrets get "fastly_logs_s3_key_id_$env")
        set -gx TF_VAR_logging_s3_secret_key (secrets get "fastly_logs_s3_secret_access_key_$env")
    else
        echo ">> unsetting token since no env was provided."
        set -e FASTLY_API_KEY
    end
end
