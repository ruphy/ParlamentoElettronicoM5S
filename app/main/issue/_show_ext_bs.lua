local issue = param.get("issue", "table")
local initiative_limit = param.get("initiative_limit", atom.integer)
local for_member = param.get("for_member", "table")
local for_listing = param.get("for_listing", atom.boolean)
local for_initiative = param.get("for_initiative", "table")
local for_initiative_id = for_initiative and for_initiative.id or nil

local direct_voter
if app.session.member_id then
  direct_voter = issue.member_info.direct_voted
end

ui.container{ attr = { class = "row-fluid"}, content = function()
  ui.container{ attr = { class = "span12"}, content = function()
    ui.container{ attr = { class = "row-fluid"}, content = function()
      ui.container{ attr = { class = "span6 eq1"}, content = function()
        execute.view{ module = "issue", view = "info_box", id=issue.id  }
      end }
      ui.container{ attr = { class = "span6 text-center"}, content = function()
        ui.link{
          attr = { id = "issue_see_det_"..issue.id, class = "btn btn-primary details_btn" },
          module = "issue",
          view = "show_ext_bs",
          id = issue.id,
          params = { view="homepage" },
          content = function()
            ui.heading{level=5,content=_"SEE DETAILS"}
          end
        }
      end }
    end }
    ui.container{ attr = { class = "row-fluid"}, content = function()
      ui.container{ attr = { class = "span12 alert alert-simple"}, content = function()
        ui.container{ attr = { class = "row-fluid"}, content = function()
          ui.container{ attr = { class = "span12"}, content = function()
            ui.heading { level=5, content = "Q"..issue.id.." - "..issue.title }
          end }
        end }
        ui.container{ attr = { class = "row-fluid"}, content = function()
          ui.container{ attr = { class = "span12"}, content = function()
            ui.link{
              module = "unit", view = "show_ext_bs", id = issue.area.unit_id,
              attr = { class = "label label-success" }, text = issue.area.unit.name
            }
            slot.put(" ")
            ui.link{
              module = "area", view = "show_ext_bs", id = issue.area_id,
              attr = { class = "label label-important" }, text = issue.area.name
            }
          end }
        end }
        ui.container{ attr = { class = "row-fluid"}, content = function()
          ui.container{ attr = { class = "span12"}, content = function()
            ui.link{
              attr = { class = "issue_id" },
              text = _("#{policy_name} ##{issue_id}", {
                policy_name = issue.policy.name,
                issue_id = issue.id
              }),
              module = "issue",
              view = "show_ext",
              id = issue.id
            }
          end }
        end }

        ui.container{attr = {class="row-fluid"}, content =function()
          ui.container{attr = {class="span12"}, content =function()
            local initiatives_selector = issue:get_reference_selector("initiatives")
            local highlight_string = param.get("highlight_string")
            if highlight_string then
              initiatives_selector:add_field( {'"highlight"("initiative"."name", ?)', highlight_string }, "name_highlighted")
            end
            execute.view{
              module = "initiative",
              view = "_list_ext_bs",
              params = {
                issue = issue,
                initiatives_selector = initiatives_selector,
                highlight_initiative = for_initiative,
                highlight_string = highlight_string,
                no_sort = true,
                limit = (for_listing or for_initiative) and 5 or nil,
                hide_more_initiatives=false,
                limit=25,
                for_member = for_member
              }
            }
          end }
        end }

      end }
    end }
  end }
end }