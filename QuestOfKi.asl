state("fceux", "2.5.0")
{
	byte Level :			0x3DA4EC, 0x144;
	byte GameStart :		0x3DA4EC, 0x40;
}

state("nestopia") 
{
	byte Level :			"nestopia.exe", 0x1b2bcc, 0, 8, 0xc,0xc, 0x1AC;
	byte GameStart :		"nestopia.exe", 0x1b2bcc, 0, 8, 0xc,0xc, 0xA8;
}

startup 
{
	refreshRate = 60;
	vars.stopWatch = new Stopwatch();
	vars.LastLevel = 0;
	settings.Add("ResetWarp", true, "Reset timer if warp taken");
}

shutdown 
{
	if (current.Level == 0x60)
	{
		return true;
	}
}

split 
{
	if (current.Level == (vars.LastLevel+1))
	{
		vars.LastLevel++;
		return true;
	}
}

start 
{
	if (current.GameStart != 0)
	{
		print("current value is " + current.GameStart);
	}
	
	if ((current.GameStart == 0) && (old.GameStart == 4))
	{
		return true;
	}
}

reset
{
	if (settings["ResetWarp"])
	{
		if (current.Level > (vars.LastLevel+2))
		{
			return true;
		}
	}
}
