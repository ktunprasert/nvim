local key = os.getenv("INTELEPHENSE")
return {
    init_options = string.format([[{"licenceKey": "%s"}]], key)
}
