#include <sourcemod>

public Plugin myinfo =
{
    name = "Self-Ban",
    author = "Testie Tendie",
    description = "Allows users to permanently ban themselves with the '!banme' chat command.",
    version = "1.1",
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
    // Check if client is a valid player
    if (client <= 0 || IsFakeClient(client))
    {
        // Return immediately without doing anything
        return Plugin_Continue;
    }

    // Get the message from the client
    char sArg1[100];
    GetCmdArg(1, sArg1, sizeof(sArg1));

    // Input validation: Check if there are additional arguments, if so ignore the command
    if (args > 1)
    {
        return Plugin_Continue;
    }

    if(StrEqual(sArg1, "!banme"))
    {
        // If the client typed "!banme" in chat, ban the client
        int banTime = 0;  // 0 for permanent ban
        char reason[] = "You have been banned by your own request.";

        // Use BanClient to permanently ban the client
        // Set third parameter (true) to kick client after ban
        BanClient(client, banTime, true, reason);

        // Get the client's name and Steam ID
        char sName[MAX_NAME_LENGTH];
        char sSteamID[20];
        GetClientAuthId(client, AuthId_Steam2, sSteamID, sizeof(sSteamID));

        // Log the ban to SourceMod's log with LogAction. It includes date and time automatically.
        LogAction(client, client, "%s (%s) has been banned by their own request.", sName, sSteamID);

        // Print the ban info to the server console
        PrintToServer("%s (%s) has been banned by their own request.", sName, sSteamID);
    }
    return Plugin_Continue;
}
