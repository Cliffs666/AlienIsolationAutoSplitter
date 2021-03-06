state("Solus-Win64-Shipping")
{
	int godmode : 0x026473E0, 0x58, 0x458, 0x3E0, 0x20, 0x5F8;
	int milli_int : 0x02577FC8, 0x28, 0x50, 0x8, 0x238, 0x2F0;
	string50 milli_str : 0x02577FC8, 0x28, 0x50, 0x8, 0x238, 0x2F0;
	string50 seconds : 0x0265DA40, 0x50, 0x350, 0x700, 0x238, 0x2DC;
	string50 minutes : 0x026473E0, 0x30, 0x378, 0x700, 0x238, 0x2D8;
}

startup
{
	vars.path = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments) + "\\TheSolusProject\\SolusProfile\\SaveSlot5";
    vars.copy = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments) + "\\TheSolusProject\\SolusProfile\\NewSave";
	vars.reload = true;
}

start
{
	if (vars.reload)
	{
		if (vars.path != "" && Directory.Exists(vars.path))
        {
            Directory.Delete(vars.path, true);
        }
        if (vars.copy != "" && Directory.Exists(vars.copy))
        {
            Directory.CreateDirectory(vars.path);
			Directory.CreateDirectory(vars.path + "\\Levels");
			File.Copy(vars.copy + "\\SaveCore.Sol", vars.path + "\\SaveCore.Sol");
			File.Copy(vars.copy + "\\SaveDetails.Sol", vars.path + "\\SaveDetails.Sol");
			File.Copy(vars.copy + "\\SaveSecretStories.Sol", vars.path + "\\SaveSecretStories.Sol");
			File.Copy(vars.copy + "\\Levels\\Solus_Landing.LVL", vars.path + "\\Levels\\Solus_Landing.LVL");
        }
		vars.reload = false;
	}
	if (current.milli_int == 2)
	{
		vars.reload = true;
	}
	return current.milli_int == 2;
}

split
{
	return current.godmode != old.godmode && current.godmode == 1;
}

isLoading
{
	return current.seconds == null || 
	       current.minutes == null || 
		   current.milli_str == null ||
		   old.seconds == null ||
		   old.minutes == null ||
		   old.milli_str == null;
}
