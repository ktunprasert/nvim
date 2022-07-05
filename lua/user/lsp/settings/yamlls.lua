-- Find more schemas here: https://www.schemastore.org/json/
local schemas = {
    ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = { "docker-compose.yaml", "docker-compose.yml" },
    ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.yml",
    ["https://raw.githubusercontent.com/lalcebo/json-schema/master/serverless/reference.json"] = { "serverless.yaml", "serverless.yml" },
}

return {
    settings = {
        yaml = {
            schemas = schemas,
            customtags = {
                "!Ref",
                "!GetAtt",
                "!Sub"
            }
        }
    }
}
