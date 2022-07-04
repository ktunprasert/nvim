-- Find more schemas here: https://www.schemastore.org/json/
local schemas = {
    ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.*",
    ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.yml",
}

return {
    settings = {
        yaml = {
            schemas = schemas,
        }
    }
}
