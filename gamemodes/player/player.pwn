#include <YSI_Coding/y_hooks>

hook OnPlayerDisconnect(playerid, reason)
{
    playerData[playerid] = JSON_Object();
    return 0;
}

hook OnPlayerConnect(playerid, reason)
{
    playerData[playerid] = JSON_Object();
}