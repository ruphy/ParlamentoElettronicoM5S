 local id_checkbox=param.get("id_checkbox")
 local label=param.get("label")
 local selected=param.get("selected")
 
 
 local display
 
 
 if selected then
     
     if selected=="true" then
         display="block"
         else
         display="none"
     end
 end
 
ui.container{attr={class="row-fluid", style="width:34em;height: 5em;"},content=function()
ui.container{attr={class="span12"},content=function() 
 ui.container
 {
    attr={class="span3 text-center"},
    content=function()
    ui.tag
    {
      tag="a",
      attr={id="proposer"..id_checkbox,class="btn btn-primary btn-large table-cell eq_btn" ,style="height: 62px!important;width: 2em;",onclick="doCheck("..id_checkbox..")"},
      content=function()
        ui.heading{ level=4, attr = {class = "fittext_btn_wiz" }, content=function()
         
          ui.container{attr={class="row-fluid"},content=function()
            ui.container{attr={class="span12" },content=function()
              ui.image{ attr = {id="imgCheck"..id_checkbox, class="arrow_medium" ,style="display:"..display..";"}, static="svg/V_checked.svg"}
            end }
          end }
        end }
      end --fine content
    } --fine tagA
    
   end --fine container
 }
 
 
  --label
    ui.container
    {
     attr={style="margin-top: 1em; float: left; "},
     content=function()
     ui.heading{level=3,content= label}
     end
    }
 end
 }
 end}
 
  
 
 