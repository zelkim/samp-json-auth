#include <YSI_Coding/y_hooks>
#include <YSI_Coding/y_inline>
#include <YSI_Extra\y_inline_mysql>

#include "auth/auth_api.pwn"
#include "auth/login.pwn"
#include "auth/register.pwn"

hook OnPlayerConnect(playerid) {
    return authenticatePlayer(playerid);
}

authenticatePlayer(playerid)
{
    new playerName[MAX_PLAYER_NAME];

    GetPlayerName(playerid, playerName, MAX_PLAYER_NAME);
    
    inline _check_username() {
        new rows = -1;
        cache_get_row_count(rows);

        if(rows > 0)
            return login(playerid);
        
        else
            return register(playerid);
    }
    MySQL_TQueryInline(connection, using inline _check_username, "SELECT id FROM users WHERE username = '%e'", playerName);

    return 1;
}