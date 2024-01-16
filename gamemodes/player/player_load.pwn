#if defined _player_load_data_included
    #endinput
#endif
#define _player_load_data_included

forward playerLoadData(playerid);
public playerLoadData(playerid)
{
    new playerName[MAX_PLAYER_NAME + 1], uid = -1;
    GetPlayerName(playerid, playerName, MAX_PLAYER_NAME);
    inline loadData() {
        cache_get_value_name_int(0, "uid", uid);

        playerData[playerid] = JSON_Object();
        new columns = 0;
        cache_get_field_count(columns);
        for(new i = 0; i < columns; i++)
        {
            new field_name[64], field_value[256];
            cache_get_field_name(i, field_name);
            cache_get_value_name(0, field_name, field_value);
            
            if(
                JSON_SetString(playerData[playerid], field_name, field_value)
            )
            { 
                print(va_return("Failed to load (%s, %s) into player json.", field_name, field_value));
            }
        }
        new stringified[2048];
        JSON_Stringify(playerData[playerid], stringified);
        printf("Player Data: %s", stringified);
    }
    MySQL_TQueryInline(connection, using inline loadData, "SELECT * FROM users WHERE username = '%e'", playerName);   
}