local function init()
    require 'lspconfig'.pyright.setup{}
end

return {
    init = init
}
