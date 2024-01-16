#include <YSI_Visual/y_dialog>
#include "player/player_load.pwn"
#include "player/player_spawn.pwn"

register(playerid)
{
    new playerName[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, playerName, MAX_PLAYER_NAME);
    return Dialog_ShowCallback(
        playerid, 
        using public registerResponse<iiiis>, 
        DIALOG_STYLE_PASSWORD,
        "Authentication > Register", 
        va_return("Welcome to Berraville, %s!\nType your password below to register:", playerName), 
        "Register",
        "Cancel"
    );
}

forward registerResponse(playerid, dialogid, response, listitem, string:inputtext[]);
public registerResponse(playerid, dialogid, response, listitem, string:inputtext[])
{
    if(!response)
        return Kick(playerid);

    new playerName[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, playerName, MAX_PLAYER_NAME);

    inline onDatabaseInsert()
    {
        playerLoadData(playerid);
        playerSpawn(playerid);
    }    
    inline const onPasswordHash(string:result[])
    {
        printf("hash: %d", result);
        MySQL_TQueryInline(
            connection, using inline onDatabaseInsert, 
            "INSERT INTO `users`(`username`, `password`) VALUES ('%e','%e')", 
            playerName, result
        );
    }
    BCrypt_HashInline(inputtext, BCRYPT_COST, using inline onPasswordHash);

    return 0;
}