#include <sourcemod>

public Plugin myinfo =
{
    name = "Self-Ban",
    author = "Testie Tendie",
    description = "Allows users to permanently ban themselves with the '!banme' chat command",
    version = "1.0",
    url = "http://testietendie.xyz/"
};

public void OnPluginStart()
{
    // Register chat command
    RegConsoleCmd("say", ChatCommand);
    RegConsoleCmd("say_team", ChatCommand);
}

public Action ChatCommand(int client, int args)
{
    // Get the message from the client
    char sArg1[100];
    GetCmdArg(1, sArg1, sizeof(sArg1));

    if(StrEqual(sArg1, "!banme"))
    {
        // If the client typed "!banme" in chat, ban the client
        int banTime = 0;  // 0 for permanent ban
        char reason[] = "You have been banned by your own request.";

        // Use BanClient to permanently ban the client
        // Set third parameter (true) to kick client after ban
        BanClient(client, banTime, true, reason);
    }
    return Plugin_Continue;
}
