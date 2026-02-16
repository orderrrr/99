local Request = require("99.request")
local CleanUp = require("99.ops.clean-up")
local make_prompt = require("99.ops.make-prompt")

local make_clean_up = CleanUp.make_clean_up
local make_observer = CleanUp.make_observer
--- @class _99.Tutorial.Result

--- @param context _99.RequestContext
---@param opts _99.ops.Opts
local function tutorial(context, opts)
  opts = opts or {}

  local logger = context.logger:set_area("tutorial")
  logger:debug("starting", "with opts", opts)

  local request = Request.new(context)

  local clean_up = make_clean_up(function()
    request:cancel()
  end)

  local prompt, refs =
    make_prompt(context, context._99.prompts.prompts.tutorial(), opts)
  context:add_references(refs)
  request:add_prompt_content(prompt)
  context:add_clean_up(clean_up)

  request:start(make_observer(clean_up, function(status, response)
    vim.schedule(clean_up)
    if status == "cancelled" then
      logger:debug("cancelled")
    elseif status == "failed" then
      logger:error(
        "failed",
        "error response",
        response or "no response provided"
      )
    elseif status == "success" then
      error("what the hell")
    end
  end))

end
return tutorial
