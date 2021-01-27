--[[
	© 2015 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]

Clockwork.config:AddToSystem("Stamina Regeneration Scale", "stam_regen_scale", "Determines how fast stamina should regenerate.", 0, 3, 3);
Clockwork.config:AddToSystem("Stamina Drain Scale", "stam_drain_scale", "Determines how fast stamina should drain.", 0, 1, 3);
Clockwork.config:AddToSystem("Breathing Volume", "breathing_volume", "The volume for breathing when a player's stamina is low.", 0, 100);
Clockwork.config:AddToSystem("Stamina Drain on Punch", "stam_punch", "Whether punching drains stamina.", 0, 1);
Clockwork.config:AddToSystem("Running Startup", "running_startup", "Amount of time it takes to get to full-speed while sprinting.", 0, 20, 2);
Clockwork.config:AddToSystem("Jog Speed", "jog_speed", "Jog speed multiplier, this times the walk speed is the jog speed.", 0, 20, 3);