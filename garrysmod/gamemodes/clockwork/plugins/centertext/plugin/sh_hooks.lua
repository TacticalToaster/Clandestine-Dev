if SERVER then
  util.AddNetworkString( "centertextshit")
  function Schema:CenterText(text)
      net.Start( "centertextshit" )
      net.WriteString( text )
      net.Broadcast()
    print(text)
  end;
end

net.Receive( "centertextshit", function()
  local text = net.ReadString()
    MsgC(Color(255, 150, 150, 255), text.."\n");
    if centertextpanel then return end

    centertextpanel = vgui.Create( "DPanel" )
    centertextpanel:SetSize(500, 250)
    centertextpanel:SetAlpha(0);
    centertextpanel:AlphaTo(255, 2);
    centertextpanel:SetPos(ScrW()/1.5, ScrH()/1.5)
    centertextpanel:SetBackgroundColor(Color(0, 0, 0, 0))

    --fake shadow
    local centertext2 = vgui.Create("DLabel", centertextpanel)
    centertext2:SetPos(6, 71)
    centertext2:SetSize(500, 180)
    centertext2:SetFont("DermaLarge")
    centertext2:SetText(text)
    centertext2:SetTextColor(Color(0, 0, 0, 150))
    centertext2:SetWrap(true)

    --real text
    local centertext = vgui.Create("DLabel", centertextpanel)
    centertext:SetPos(5, 70)
    centertext:SetSize(500, 180)
    centertext:SetFont("DermaLarge")
    centertext:SetText(text)
    centertext:SetTextColor(Color(255, 255, 255, 255))
    centertext:SetWrap(true)
  
    timer.Simple(10, function()
      centertextpanel:AlphaTo(0, 2);
    end)
  
    timer.Simple(12, function()
      if (centertextpanel) then
        centertextpanel:Remove();
        centertextpanel = nil;
      end
    end)
  end)