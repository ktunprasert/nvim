-- Find more schemas here: https://www.schemastore.org/json/
local schemas = {
    ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.*",
}

return {
    settings = {
        yaml = {
            schemas = schemas,
        }
    }
}
