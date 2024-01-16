#include <YSI_Visual/y_dialog>

login(playerid)
{
    new playerName[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, playerName, MAX_PLAYER_NAME);
    return Dialog_ShowCallback(
        playerid, 
        using public loginResponse<iiiis>, 
        DIALOG_STYLE_PASSWORD,
        "Authentication > Login", 
        va_return("Welcome back, %s!\nType your password below to login:", playerName), 
        "Login",
        "Cancel"
    );
}

forward onGetPasswordHash(playerid, string:password[]);
public onGetPasswordHash(playerid, string:password[]) {
    new password_hash[BCRYPT_HASH_LENGTH + 1];
    cache_get_value_name(0, "password", password_hash);
    
    inline onPasswordCompare(bool:match)
    {
        if(match) {
            playerLoadData(playerid);
            playerSpawn(playerid);
        }
        else {
            SendClientMessage(playerid, -1, "Invalid password!");
            login(playerid);
        }
    }
    BCrypt_CheckInline(password, password_hash, using inline onPasswordCompare);
}

forward loginResponse(playerid, dialogid, response, listitem, string:inputtext[]);
public loginResponse(playerid, dialogid, response, listitem, string:inputtext[])
{
    new playerName[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, playerName, MAX_PLAYER_NAME);

    mysql_tquery(connection, 
        va_return("SELECT password FROM users WHERE username = '%s'", playerName), 
        "onGetPasswordHash", "is", playerid, inputtext
    );
}