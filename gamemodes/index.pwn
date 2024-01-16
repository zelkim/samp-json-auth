/*
# REMEMBER TO ADD IN SERVER.CFG AND IN './content/discordconnector.inc' THE ID  #
# OF YOUR LOGS CHANNEL, OTHERWISE YOU MAY PRESENT SOME PROBLEMS WHEN COMPILING. #
*/

#define YSI_NO_HEAP_MALLOC
#define SSCANF_NO_NICE_FEATURES

#include <open.mp>
#include <a_mysql>
#include <bcrypt>
#include <YSI_Extra\y_bcrypt>
#include <YSI_Coding/y_inline>
#include <YSI_Extra/y_inline_bcrypt>
#include <sscanf2>
#include <zcmd>
#include <json>

// - Modules
#include "constants/globals.pwn"
#include "constants/dialogs.pwn"

#include "auth/auth.pwn"

#include "player/player.pwn"

main () {}

public OnGameModeInit()
{
    connection = mysql_connect(
        .host = "localhost", 
        .user = "root", 
        .password = "", 
        .database = "rp"
    );

    if(mysql_errno(connection)) {
        printf("[MYSQL] Could not connect to database.");
        SendRconCommand("password 0239jr0293rj2309fn203fn0fiwef09j109");
    }
    printf("Gamemode loaded.");

    return 0;
}