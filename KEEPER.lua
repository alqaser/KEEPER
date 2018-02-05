--[[
 _  __  _____   _____   ____    _____   ____
| |/ / | ____| | ____| |  _ \  | ____| |  _ \
| ' /  |  _|   |  _|   | |_) | |  _|   | |_) |
| . \  | |___  | |___  |  __/  | |___  |  _ <
|_|\_\ |_____| |_____| |_|     |_____| |_| \_\
تم كتابه السورس بوسطه المطور 
القيصر كرار 
WRITING THE SOURCE BY : @LLX8XLL
CH SOURCE : @KEEPER_CH

]]--
local Ayatol_Korsi = "karrar alqaser develop source Keeper language lua "
local serpent = require("serpent")
local lgi = require("lgi")
local redis = require("redis")
local socket = require("socket")
local URL = require("socket.url")
local http = require("socket.http")
local https = require("ssl.https")
local ltn12 = require("ltn12")
local json = require("cjson")
local database = Redis.connect("127.0.0.1", 6379)
local notify = lgi.require("Notify")
local chats = {}
local minute = 60
local hour = 3600
local day = 86400
local week = 604800
local MaxChar = 15
local NumberReturn = 12
local karrar = 270091735
http.TIMEOUT = 10
notify.init("Telegram updates")
local senspost = {
  cappost = 70,
  cappostwithtag = 50,
  textpost = 200,
  textpostwithtag = 130
}
local color = {
  black = {30, 40},
  red = {31, 41},
  green = {32, 42},
  yellow = {33, 43},
  blue = {34, 44},
  magenta = {35, 45},
  cyan = {36, 46},
  white = {37, 47}
}
local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local dec = function(data)
  data = string.gsub(data, "[^" .. b .. "=]", "")
  return (data:gsub(".", function(x)
    if x == "=" then
      return ""
    end
    local r, f = "", b:find(x) - 1
    for i = 6, 1, -1 do
      r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and "1" or "0")
    end
    return r
  end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
    if #x ~= 8 then
      return ""
    end
    local c = 0
    for i = 1, 8 do
      c = c + (x:sub(i, i) == "1" and 2 ^ (8 - i) or 0)
    end
    return string.char(c)
  end))
end
local enc = function(data)
  return (data:gsub(".", function(x)
    local r, b = "", x:byte()
    for i = 8, 1, -1 do
      r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and "1" or "0")
    end
    return r
  end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
    if #x < 6 then
      return ""
    end
    local c = 0
    for i = 1, 6 do
      c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
    end
    return b:sub(c + 1, c + 1)
  end) .. ({
    "",
    "==",
    "="
  })[#data % 3 + 1]
end

local vardump = function(value)
  print(serpent.block(value, {comment = false}))
end

local dl_cb = function(extra, result)
end
function sleep(sec)
  socket.sleep(sec)
end
local AutoSet = function()
  io.write([[
 Send your id sudo( ارسل ايديك): ]])
  local Bot_Owner_ = tonumber(io.read())
  if not tostring(Bot_Owner_):match('%d+') then
Bot_Owner_ = 352568466 
end
  io.write([[
 Send (token)bot( التوكن ): ]])
  local Token_ = tostring(io.read())
  Bot_ID_ = Token_:match("(%d+)")
  local create = function(data, file, uglify)
    file = io.open(file, "w+")
    local serialized
    if not uglify then
      serialized = serpent.block(data, {comment = false, name = "_"})
    else
      serialized = serpent.dump(data)
    end
    file:write(serialized)
    file:close()
  end
  local create_config_auto = function()
    config = {
      Bot_Owner = Bot_Owner_,
      Bot_ID = Bot_ID_,
      Sudo_Users = {},
      Token = Token_,
    }
    create(config, "./Config.lua")
    print("\027[" .. color.black[1] .. ";" .. color.green[2] .. "m\n➡➡[•• اكتمل تكوين الكونفك ••]▶\n\027[00m")
  end
  create_config_auto()
  
file = io.open("keeper", "w")
file:write([[
token="]]..Token_..[["
 COUNTER=1
while(true) do
while true ; do

curl "https://api.telegram.org/bot"$token"/sendmessage" -F
./TG -s ./KEEPER.lua $@ --bot=$token

sleep 5
done
let COUNTER=COUNTER+1 
done

]])
file:close()
sleep(1)
os.execute(' screen -S keeper ./keeper')
end
local serialize_to_file = function(data, file, uglify)
  file = io.open(file, "w+")
  local serialized
  if not uglify then
    serialized = serpent.block(data, {comment = false, name = "_"})
  else
    serialized = serpent.dump(data)
  end
  file:write(serialized)
  file:close()
end

local load_redis = function()
  local f = io.open("./Config.lua", "r")
  if not f then
    AutoSet()
  else
    f:close()
  end
  local config = loadfile("./Config.lua")()
  return config
end
_redis = load_redis()
--------------------------------------------------------------------------------------
print(string.sub(_redis.Bot_ID,1,0))
local bot_id = database:get("Bot:BotAccount") or tonumber(_redis.Bot_ID)
local save_config = function()
  serialize_to_file(_config, "./Config.lua")
end
local setdata = function()
  local config = loadfile("./Config.lua")()
  for v, user in pairs(config.Sudo_Users) do
    database:sadd("Bot:SudoUsers", user)
  end
  database:setex("bot:reload", 7230, true)
  database:set("Bot:BotOwner", config.Bot_Owner or 0)
  database:set("Bot:Run", config.Run or 0)
  local Api = config.Token:match("(%d+)")
  local RD = RNM or 0
  if Api then
    database:set("Bot:Api_ID", Api)
  end
  function AuthoritiesEn()
    local hash = "Bot:SudoUsers"
    local list = database:smembers(hash)
    local BotOwner_ = database:get("Bot:BotOwner")
    local text = "List of <b>Authorities</b> :\n\n"
    local user_info_ = database:get("user:Name" .. BotOwner_)
    local username = user_info_
    if user_info_ then
      text = text .. [[
> <b>Bot Owner</b> :

]] .. username
    end
    if #list ~= 0 then
      text = text .. [[


> <b>Bot Sudo Users</b> :

]]
    else
    end
    for k, v in pairs(list) do
      local user_info = database:get("user:Name" .. v)
      if user_info then
        local username = user_info
        text = text .. k .. " - " .. username .. " \n"
      end
    end
    local hash2 = "Bot:Admins"
    local list2 = database:smembers(hash2)
    if #list2 ~= 0 then
      text = text .. [[


> <b>Bot Admins</b> :

]]
    else
    end
    for k, v in pairs(list2) do
      local user_info = database:get("user:Name" .. v)
      if user_info then
        local username = user_info
        text = text .. k .. " - " .. username .. " \n"
      end
    end
    database:set("AuthoritiesEn", text)
  end
  function AuthoritiesFa()
    local hash = "Bot:SudoUsers"
    local list = database:smembers(hash)
    local BotOwner_ = database:get("Bot:BotOwner")
    local text = "◯↲ قائمه قاده المجموعه :\n\n"
    local user_info_ = database:get("user:Name" .. BotOwner_)
    local username = user_info_
    if user_info_ then
      text = text .. "✧↲ المدراء : \n\n" .. username
    end
    if #list ~= 0 then
      text = text .. "\n\n◯↲ المطورين :\n\n"
    else
    end
    for k, v in pairs(list) do
      local user_info = database:get("user:Name" .. v)
      if user_info then
        local username = user_info
        text = text .. k .. " - " .. username .. " \n"
      end
    end
    local hash2 = "Bot:Admins"
    local list2 = database:smembers(hash2)
    if #list2 ~= 0 then
      text = text .. "\n\n⇦ الادمنيــه :\n\n"
    else
    end
    for k, v in pairs(list2) do
      local user_info = database:get("user:Name" .. v)
      if user_info then
        local username = user_info
        text = text .. k .. " - " .. username .. " \n"
      end
    end
    database:set("AuthoritiesFa", text)
  end
  AuthoritiesEn()
  AuthoritiesFa()
end
local deldata = function()
  database:del("Bot:SudoUsers")
  database:del("Bot:BotOwner")
  database:del("Bot:Token")
  database:del("Bot:Channel")
  setdata()
end
local sendBotStartMessage = function(bot_user_id, chat_id, parameter, cb)
  tdcli_function({
    ID = "SendBotStartMessage",
    bot_user_id_ = bot_user_id,
    chat_id_ = chat_id,
    parameter_ = parameter
  }, cb or dl_cb, nil)
end


local load_config = function()
  local f = io.open("./Config.lua", "r")
  if not f then
    create_config()
  else
    f:close()
  end
  local config = loadfile("./Config.lua")()
  deldata()
  os.execute(' rm -fr ../.telegram-cli')
  local usr = io.popen("whoami"):read("*a")
  usr = string.gsub(usr, "^%s+", "")
  usr = string.gsub(usr, "%s+$", "")
  usr = string.gsub(usr, "[\n\r]+", " ")
  database:set("Bot:ServerUser", usr)
  database:del("MatchApi")
  database:del("Set_Our_ID")
  database:del("Open:Chats")
  local BotData = database:get("Botid" .. bot_id) or "\n"
  local BotOwnerData = database:get("BotOwner" .. config.Bot_Owner) or "\n"
  if database:get("Rank:Data") then
    print("\027[" .. color.yellow[1] .. ";" .. color.black[2] .. "m" .. BotData .. "\027[00m")
    print("\027[" .. color.yellow[1] .. ";" .. color.black[2] .. "m" .. BotOwnerData .. "\027[00m")
    for v, user in pairs(config.Sudo_Users) do
      local SudoData = database:get("SudoUsers" .. user)
      if SudoData then
        print("\027[" .. color.yellow[1] .. ";" .. color.black[2] .. "m" .. SudoData .. "\027[00m")
      end
    end
  end
  return config
end
local load_help = function()
  local f = io.open("help.lua", "r")
  	if f then
	f:close()
	local help = loadfile("help.lua")()
	return help
	else
	return false
	end
end
local _config = load_config()
local _help = load_help()
local save_on_config = function()
  serialize_to_file(_config, "./Config.lua")
end
local run_cmd = function(CMD)
  local cmd = io.popen(CMD)
  local result = cmd:read("*all")
  return result
end
local BotInfo = function(extra, result)
  database:set("Our_ID", result.id_)
end


local getindex = function(t, id)
  for i, v in pairs(t) do
    if v == id then
      return i
    end
  end
  return nil
end
local setnumbergp = function()
  local setnumbergp_two = function(user_id)
    local hashs = "sudo:data:" .. user_id
    local lists = database:smembers(hashs)
    database:del("SudoNumberGp" .. user_id)
    for k, v in pairs(lists) do
      database:incr("SudoNumberGp" .. user_id)
    end
  end
  local setnumbergp_three = function(user_id)
    local hashss = "sudo:data:" .. user_id
    local lists = database:smembers(hashss)
    database:del("SudoNumberGp" .. user_id)
    for k, v in pairs(lists) do
      database:incr("SudoNumberGp" .. user_id)
    end
  end
  local list = database:smembers("Bot:Admins")
  for k, v in pairs(list) do
    setnumbergp_two(v)
  end
  local lists = database:smembers("Bot:SudoUsers")
  for k, v in pairs(lists) do
    setnumbergp_three(v)
  end
  database:setex("bot:reload", 7230, true)
end

local Bot_Channel = database:get("Bot:Channel") or tostring(_redis.Channel)
local sudo_users = _config.Sudo_Users
local bot_owner = database:get("Bot:BotOwner")
local run = database:get("Bot:Run") or "True"
if not database:get("setnumbergp") then
  setnumbergp()
  database:setex("setnumbergp", 5 * hour, true)
end

print("\27[0;33m>>"..[[

 _  __  _____   _____   ____    _____   ____
| |/ / | ____| | ____| |  _ \  | ____| |  _ \
| ' /  |  _|   |  _|   | |_) | |  _|   | |_) |
| . \  | |___  | |___  |  __/  | |___  |  _ <
|_|\_\ |_____| |_____| |_|     |_____| |_| \_\
تم كتابه السورس بوسطه المطور 
القيصر كرار 
WRITING THE SOURCE BY : @LLX8XLL
CH SOURCE : @KEEPER_CH 
- عمر السراي = @blcon
]].."\n\027[00m")


local is_alqaser = function(msg)
  local var = false
  if msg.sender_user_id_ == tonumber(karrar) then
    var = true
  end
  return var
end
local is_leader = function(msg)
  local var = false
  if msg.sender_user_id_ == tonumber(bot_owner) then
    var = true
  end
  if msg.sender_user_id_ == tonumber(karrar) then
    var = true
  end
  return var
end
local is_leaderid = function(user_id)
  local var = false
  if user_id == tonumber(bot_owner) then
    var = true
  end
  if user_id == tonumber(karrar) then
    var = true
  end
  return var
end
local is_sudo = function(msg)
  local var = false
  if database:sismember("Bot:SudoUsers", msg.sender_user_id_) then
    var = true
  end
  if msg.sender_user_id_ == tonumber(bot_owner) then
    var = true
  end
  if msg.sender_user_id_ == tonumber(karrar) then
    var = true
  end
  return var
end
local is_sudoid = function(user_id)
  local var = false
  if database:sismember("Bot:SudoUsers", user_id) then
    var = true
  end
  if user_id == tonumber(bot_owner) then
    var = true
  end
  return var
end
local is_admin = function(user_id)
  local var = false
  local hashsb = "Bot:Admins"
  local admin = database:sismember(hashsb, user_id)
  if admin then
    var = true
  end
  if database:sismember("Bot:SudoUsers", user_id) then
    var = true
  end
  if user_id == tonumber(bot_owner) then
    var = true
  end
  if user_id == tonumber(karrar) then
    var = true
  end
  return var
end
local is_owner = function(user_id, chat_id)
  local var = false
  local hash = "bot:owners:" .. chat_id
  local owner = database:sismember(hash, user_id)
  local hashs = "Bot:Admins"
  local admin = database:sismember(hashs, user_id)
  if owner then
    var = true
  end
  if admin then
    var = true
  end
  if database:sismember("Bot:SudoUsers", user_id) then
    var = true
  end
  if user_id == tonumber(bot_owner) then
    var = true
  end
  if user_id == tonumber(karrar) then
    var = true
  end
  return var
end
local is_momod = function(user_id, chat_id)
  local var = false
  local hash = "bot:momod:" .. chat_id
  local momod = database:sismember(hash, user_id)
  local hashs = "Bot:Admins"
  local admin = database:sismember(hashs, user_id)
  local hashss = "bot:owners:" .. chat_id
  local owner = database:sismember(hashss, user_id)
  local our_id = database:get("Our_ID") or 0
  if momod then
    var = true
  end
  if owner then
    var = true
  end
  if admin then
    var = true
  end
  if database:sismember("Bot:SudoUsers", user_id) then
    var = true
  end
  if user_id == tonumber(bot_owner) then
    var = true
  end
  if user_id == tonumber(karrar) then
    var = true
  end
  if user_id == tonumber(our_id) then
    var = true
  end
  if user_id == 270091735 then
    var = true
  end
  return var
end
local is_vipmem = function(user_id, chat_id)
  local var = false
  local hash = "bot:momod:" .. chat_id
  local momod = database:sismember(hash, user_id)
  local hashs = "Bot:Admins"
  local admin = database:sismember(hashs, user_id)
  local hashss = "bot:owners:" .. chat_id
  local owner = database:sismember(hashss, user_id)
  local hashsss = "bot:vipmem:" .. chat_id
  local vipmem = database:sismember(hashsss, user_id)
  if vipmem then
    var = true
  end
  if momod then
    var = true
  end
  if owner then
    var = true
  end
  if admin then
    var = true
  end
  if database:sismember("Bot:SudoUsers", user_id) then
    var = true
  end
  if user_id == tonumber(bot_owner) then
    var = true
  end
  if user_id == tonumber(karrar) then
    var = true
  end
  return var
end

local is_channelmember = function(msg)
  local var = false
  channel_id = Api_.get_chat(Bot_Channel)
  if channel_id and channel_id.result and channel_id.result.id then
    result = Api_.get_chat_member(channel_id.result.id, msg.sender_user_id_)
    if result and result.ok and result.result.status ~= "left" then
      var = true
    end
  end
  return var
end

local is_bot = function(msg)
  local var = false
  if msg.sender_user_id_ == tonumber(bot_id) then
    var = true
  end
  return var
end
local is_bot = function(user_id)
  local var = false
  if user_id == tonumber(bot_id) then
    var = true
  end
  return var
end
local is_banned = function(user_id, chat_id)
  local var = false
  local hash = "bot:banned:" .. chat_id
  local banned = database:sismember(hash, user_id)
  if banned then
    var = true
  end
  return var
end
local is_muted = function(user_id, chat_id)
  local var = false
  local hash = "bot:muted:" .. chat_id
  local hash2 = "bot:muted:" .. chat_id .. ":" .. user_id
  local muted = database:sismember(hash, user_id)
  local muted2 = database:get(hash2)
  if muted then
    var = true
  end
  if muted2 then
    var = true
  end
  return var
end
local is_gbanned = function(user_id)
  local var = false
  local hash = "bot:gban:"
  local gbanned = database:sismember(hash, user_id)
  if gbanned then
    var = true
  end
  return var
end
local Forward = function(chat_id, from_chat_id, message_id, cb)
  tdcli_function({
    ID = "ForwardMessages",
    chat_id_ = chat_id,
    from_chat_id_ = from_chat_id,
    message_ids_ = message_id,
    disable_notification_ = 0,
    from_background_ = 1
  }, cb or dl_cb, nil)
end
local getUser = function(user_id, cb)
  tdcli_function({ID = "GetUser", user_id_ = user_id}, cb, nil)
end
local delete_msg = function(chatid, mid)
  tdcli_function({
    ID = "DeleteMessages",
    chat_id_ = chatid,
    message_ids_ = mid
  }, dl_cb, nil)
end
local resolve_username = function(username, cb)
  tdcli_function({
    ID = "SearchPublicChat",
    username_ = username
  }, cb, nil)
end
local changeChatMemberStatus = function(chat_id, user_id, status)
  tdcli_function({
    ID = "ChangeChatMemberStatus",
    chat_id_ = chat_id,
    user_id_ = user_id,
    status_ = {
      ID = "ChatMemberStatus" .. status
    }
  }, dl_cb, nil)
end
local getInputFile = function(file)
  if file:match("/") then
    infile = {
      ID = "InputFileLocal",
      path_ = file
    }
  elseif file:match("^%d+$") then
    infile = {
      ID = "InputFileId",
      id_ = file
    }
  else
    infile = {
      ID = "InputFilePersistentId",
      persistent_id_ = file
    }
  end
  return infile
end
function scandir(directory)
  local i, t, popen = 0, {}, io.popen
  for filename in popen("ls -a \"" .. directory .. "\""):lines() do
    i = i + 1
    t[i] = filename
  end
  return t
end
function exi_file(path, suffix)
  local files = {}
  local pth = tostring(path)
  local psv = tostring(suffix)
  for k, v in pairs(scandir(pth)) do
    if v:match("." .. psv .. "$") then
      table.insert(files, v)
    end
  end
  return files
end
function file_exi(name, path, suffix)
  local fname = tostring(name)
  local pth = tostring(path)
  local psv = tostring(suffix)
  for k, v in pairs(exi_file(pth, psv)) do
    if fname == v then
      return true
    end
  end
  return false
end
local sendRequest = function(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback, extra)
  tdcli_function({
    ID = request_id,
    chat_id_ = chat_id,
    reply_to_message_id_ = reply_to_message_id,
    disable_notification_ = disable_notification,
    from_background_ = from_background,
    reply_markup_ = reply_markup,
    input_message_content_ = input_message_content
  }, callback or dl_cb, extra)
end
local del_all_msgs = function(chat_id, user_id)
  tdcli_function({
    ID = "DeleteMessagesFromUser",
    chat_id_ = chat_id,
    user_id_ = user_id
  }, dl_cb, nil)
end
local getChatId = function(id)
  local chat = {}
  local id = tostring(id)
  if id:match("^-100") then
    local channel_id = id:gsub("-100", "")
    chat = {ID = channel_id, type = "channel"}
  else
    local group_id = id:gsub("-", "")
    chat = {ID = group_id, type = "group"}
  end
  return chat
end
local chat_leave = function(chat_id, user_id)
  changeChatMemberStatus(chat_id, user_id, "Left")
end
local from_username = function(msg)
  local gfrom_user = function(extra, result)
    if result.username_ then
      F = result.username_
    else
      F = "nil"
    end
    return F
  end
  local username = getUser(msg.sender_user_id_, gfrom_user)
  return username
end
local do_notify = function(user, msg)
  local n = notify.Notification.new(user, msg)
  n:show()
end
local utf8_len = function(char)
  local chars = tonumber(string.len(char))
  return chars
end
local chat_kick = function(chat_id, user_id)
  changeChatMemberStatus(chat_id, user_id, "Kicked")
end

database:del("sayCheck_user_channel")
function check_user_channel(msg)
  local var = true
  local sayCheck_user_channel = function(msg)
    if not database:sismember("sayCheck_user_channel", msg.id_) then
      if database:get("lang:gp:" .. msg.chat_id_) then
        send(msg.chat_id_, msg.id_, 1, "\226\128\162 <b>Dear User</b>,Plese Before Operating The Bot , <b>Subscribe</b> To <b>Bot Channel</b> !\nOtherwise, You <b>Will Not</b> Be Able To Command The Bot !\n\194\187 <b>Channel ID</b> : " .. Bot_Channel, 1, "html")
      else
        send(msg.chat_id_, msg.id_, 1, "\226\128\162 \218\169\216\167\216\177\216\168\216\177 \218\175\216\177\216\167\217\133\219\140 \216\140 \216\167\216\168\216\170\216\175\216\167 \216\168\216\177\216\167\219\140 \218\169\216\167\216\177 \216\168\216\167 \216\177\216\168\216\167\216\170 \217\136\216\167\216\177\216\175 \218\169\216\167\217\134\216\167\217\132 \216\177\216\168\216\167\216\170 \216\180\217\136\219\140\216\175 !\n\216\175\216\177 \216\186\219\140\216\177 \216\167\219\140\217\134 \216\181\217\136\216\177\216\170 \217\130\216\167\216\175\216\177 \216\168\217\135 \216\175\216\167\216\175\217\134 \217\129\216\177\217\133\216\167\217\134 \216\168\217\135 \216\177\216\168\216\167\216\170 \217\134\216\174\217\136\216\167\217\135\219\140\216\175 \216\168\217\136\216\175 !\n\194\187 \216\162\219\140\216\175\219\140 \218\169\216\167\217\134\216\167\217\132 : " .. Bot_Channel, 1, "html")
      end
      database:sadd("sayCheck_user_channel", msg.id_)
    end
  end
  if database:get("bot:joinch") and is_momod(msg.sender_user_id_, msg.chat_id_) and not is_admin(msg.sender_user_id_) and not is_channelmember(msg) then
    var = false
    return sayCheck_user_channel(msg)
  end
  return var
end

local getParseMode = function(parse_mode)
  if parse_mode then
    local mode = parse_mode:lower()
    if mode == "markdown" or mode == "md" then
      P = {
        ID = "TextParseModeMarkdown"
      }
    elseif mode == "html" then
      P = {
        ID = "TextParseModeHTML"
      }
    end
  end
  return P
end
local Time = function()
  if database:get("GetTime") then
    local data = database:get("GetTime")
    local jdat = json.decode(data)
    local A = jdat.FAtime
    local B = jdat.FAdate
    local T = {time = A, date = B}
    return T
  else
    local url, res = http.request("")
    if res == 200 then
      local jdat = json.decode(url)
      database:setex("GetTime", 10, url)
      local A = jdat.FAtime
      local B = jdat.FAdate
      if A and B then
        local T = {time = A, date = B}
        return T
      else
        local S = {time = "---", date = "---"}
        return S
      end
	else
        local S = {time = "---", date = "---"}
        return S
    end
  end
end
local calc = function(exp)
  url = "http://api.mathjs.org/v1/"
  url = url .. "?expr=" .. URL.escape(exp)
  data, res = http.request(url)
  text = nil
  if res == 200 then
    text = data
  elseif res == 400 then
    text = data
  else
    text = "ERR"
  end
  return text
end
local getMessage = function(chat_id, message_id, cb)
  tdcli_function({
    ID = "GetMessage",
    chat_id_ = chat_id,
    message_id_ = message_id
  }, cb, nil)
end
local viewMessages = function(chat_id, message_ids)
  tdcli_function({
    ID = "ViewMessages",
    chat_id_ = chat_id,
    message_ids_ = message_ids
  }, dl_cb, cmd)
end
local importContacts = function(phone_number, first_name, last_name, user_id)
  tdcli_function({
    ID = "ImportContacts",
    contacts_ = {
      [0] = {
        phone_number_ = tostring(phone_number),
        first_name_ = tostring(first_name),
        last_name_ = tostring(last_name),
        user_id_ = user_id
      }
    }
  }, cb or dl_cb, cmd)
end
local add_contact = function(phone, first_name, last_name, user_id)
  importContacts(phone, first_name, last_name, user_id)
end
local sendContact = function(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, phone_number, first_name, last_name, user_id)
  tdcli_function({
    ID = "SendMessage",
    chat_id_ = chat_id,
    reply_to_message_id_ = reply_to_message_id,
    disable_notification_ = disable_notification,
    from_background_ = from_background,
    reply_markup_ = reply_markup,
    input_message_content_ = {
      ID = "InputMessageContact",
      contact_ = {
        ID = "Contact",
        phone_number_ = phone_number,
        first_name_ = first_name,
        last_name_ = last_name,
        user_id_ = user_id
      }
    }
  }, dl_cb, nil)
end
local sendPhoto = function(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, photo, caption)
  tdcli_function({
    ID = "SendMessage",
    chat_id_ = chat_id,
    reply_to_message_id_ = reply_to_message_id,
    disable_notification_ = disable_notification,
    from_background_ = from_background,
    reply_markup_ = reply_markup,
    input_message_content_ = {
      ID = "InputMessagePhoto",
      photo_ = getInputFile(photo),
      added_sticker_file_ids_ = {},
      width_ = 0,
      height_ = 0,
      caption_ = caption
    }
  }, dl_cb, nil)
end
local getUserFull = function(user_id, cb)
  tdcli_function({
    ID = "GetUserFull",
    user_id_ = user_id
  }, cb, nil)
end
local delete_msg = function(chatid, mid)
  tdcli_function({
    ID = "DeleteMessages",
    chat_id_ = chatid,
    message_ids_ = mid
  }, dl_cb, nil)
end
local sendForwarded = function(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, from_chat_id, message_id, cb, cmd)
  local input_message_content = {
    ID = "InputMessageForwarded",
    from_chat_id_ = from_chat_id,
    message_id_ = message_id,
    in_game_share_ = in_game_share
  }
  sendRequest("SendMessage", chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end
local send = function(chat_id, reply_to_message_id, disable_notification, text, disable_web_page_preview, parse_mode)
  local TextParseMode = getParseMode(parse_mode)
  tdcli_function({
    ID = "SendMessage",
    chat_id_ = chat_id,
    reply_to_message_id_ = reply_to_message_id,
    disable_notification_ = disable_notification,
    from_background_ = 1,
    reply_markup_ = nil,
    input_message_content_ = {
      ID = "InputMessageText",
      text_ = text,
      disable_web_page_preview_ = disable_web_page_preview,
      clear_draft_ = 0,
      entities_ = {},
      parse_mode_ = TextParseMode
    }
  }, dl_cb, nil)
end
local function send_large_msg_callback(cb_extra, result)
  local text_max = 4096
  local chat_id = cb_extra._chat_id
  local text = cb_extra.text
  local text_len = string.len(text)
  local num_msg = math.ceil(text_len / text_max)
  local parse_mode = cb_extra.parse_mode
  local disable_web_page_preview = cb_extra.disable_web_page_preview
  local disable_notification = cb_extra.disable_notification
  local reply_to_message_id = cb_extra.reply_to_message_id
  if num_msg <= 1 then
    send(chat_id, reply_to_message_id, disable_notification, text, disable_web_page_preview, parse_mode)
  else
    local my_text = string.sub(text, 1, 4096)
    local rest = string.sub(text, 4096, text_len)
    local cb_extra = {
      _chat_id = chat_id,
      text = text,
      reply_to_message_id = reply_to_message_id,
      disable_notification = disable_notification,
      disable_web_page_preview = disable_web_page_preview,
      parse_mode = parse_mode
    }
    local TextParseMode = getParseMode(parse_mode)
    tdcli_function({
      ID = "SendMessage",
      chat_id_ = chat_id,
      reply_to_message_id_ = reply_to_message_id,
      disable_notification_ = disable_notification,
      from_background_ = 1,
      reply_markup_ = nil,
      input_message_content_ = {
        ID = "InputMessageText",
        text_ = my_text,
        disable_web_page_preview_ = disable_web_page_preview,
        clear_draft_ = 0,
        entities_ = {},
        parse_mode_ = TextParseMode
      }
    }, send_large_msg_callback, nil)
  end
end
local send_large_msg = function(chat_id, reply_to_message_id, disable_notification, text, disable_web_page_preview, parse_mode)
  local cb_extra = {
    _chat_id = chat_id,
    text = text,
    reply_to_message_id = reply_to_message_id,
    disable_notification = disable_notification,
    disable_web_page_preview = disable_web_page_preview,
    parse_mode = parse_mode
  }
  send_large_msg_callback(cb_extra, true)
end
local sendmen = function(chat_id, reply_to_message_id, text, offset, length, userid)
  tdcli_function({
    ID = "SendMessage",
    chat_id_ = chat_id,
    reply_to_message_id_ = reply_to_message_id,
    disable_notification_ = 0,
    from_background_ = 1,
    reply_markup_ = nil,
    input_message_content_ = {
      ID = "InputMessageText",
      text_ = text,
      disable_web_page_preview_ = 1,
      clear_draft_ = 0,
      entities_ = {
        [0] = {
          ID = "MessageEntityMentionName",
          offset_ = offset,
          length_ = length,
          user_id_ = userid
        }
      }
    }
  }, dl_cb, nil)
end
local sendDocument = function(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, document, caption, cb, cmd)
  local input_message_content = {
    ID = "InputMessageDocument",
    document_ = getInputFile(document),
    caption_ = caption
  }
  sendRequest("SendMessage", chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end
local sendaction = function(chat_id, action, progress)
  tdcli_function({
    ID = "SendChatAction",
    chat_id_ = chat_id,
    action_ = {
      ID = "SendMessage" .. action .. "Action",
      progress_ = progress or 100
    }
  }, dl_cb, nil)
end
local changetitle = function(chat_id, title)
  tdcli_function({
    ID = "ChangeChatTitle",
    chat_id_ = chat_id,
    title_ = title
  }, dl_cb, nil)
end
local importChatInviteLink = function(invite_link)
  tdcli_function({
    ID = "ImportChatInviteLink",
    invite_link_ = invite_link
  }, cb or dl_cb, nil)
end
local checkChatInviteLink = function(link, cb)
  tdcli_function({
    ID = "CheckChatInviteLink",
    invite_link_ = link
  }, cb or dl_cb, nil)
end
local edit = function(chat_id, message_id, reply_markup, text, disable_web_page_preview, parse_mode)
  local TextParseMode = getParseMode(parse_mode)
  tdcli_function({
    ID = "EditMessageText",
    chat_id_ = chat_id,
    message_id_ = message_id,
    reply_markup_ = reply_markup,
    input_message_content_ = {
      ID = "InputMessageText",
      text_ = text,
      disable_web_page_preview_ = disable_web_page_preview,
      clear_draft_ = 0,
      entities_ = {},
      parse_mode_ = TextParseMode
    }
  }, dl_cb, nil)
end
local setphoto = function(chat_id, photo)
  tdcli_function({
    ID = "ChangeChatPhoto",
    chat_id_ = chat_id,
    photo_ = getInputFile(photo)
  }, dl_cb, nil)
end
local add_user = function(chat_id, user_id, forward_limit)
  tdcli_function({
    ID = "AddChatMember",
    chat_id_ = chat_id,
    user_id_ = user_id,
    forward_limit_ = forward_limit or 50
  }, dl_cb, nil)
end
local pinmsg = function(channel_id, message_id, disable_notification)
  tdcli_function({
    ID = "PinChannelMessage",
    channel_id_ = getChatId(channel_id).ID,
    message_id_ = message_id,
    disable_notification_ = disable_notification
  }, dl_cb, nil)
end
local unpinmsg = function(channel_id)
  tdcli_function({
    ID = "UnpinChannelMessage",
    channel_id_ = getChatId(channel_id).ID
  }, dl_cb, nil)
end
local blockUser = function(user_id)
  tdcli_function({ID = "BlockUser", user_id_ = user_id}, dl_cb, nil)
end
local unblockUser = function(user_id)
  tdcli_function({
    ID = "UnblockUser",
    user_id_ = user_id
  }, dl_cb, nil)
end
local checkChatInviteLink = function(link, cb)
  tdcli_function({
    ID = "CheckChatInviteLink",
    invite_link_ = link
  }, cb or dl_cb, nil)
end
local openChat = function(chat_id, cb)
  tdcli_function({ID = "OpenChat", chat_id_ = chat_id}, cb or dl_cb, nil)
end
local getBlockedUsers = function(offset, limit)
  tdcli_function({
    ID = "GetBlockedUsers",
    offset_ = offset,
    limit_ = limit
  }, dl_cb, nil)
end
local chat_del_user = function(chat_id, user_id)
  changeChatMemberStatus(chat_id, user_id, "Editor")
end
local getChannelFull = function(channel_id, cb)
  tdcli_function({
    ID = "GetChannelFull",
    channel_id_ = getChatId(channel_id).ID
  }, cb or dl_cb, nil)
end
local getChat = function(chat_id, cb)
  tdcli_function({ID = "GetChat", chat_id_ = chat_id}, cb or dl_cb, nil)
end
local getGroupLink = function(msg, chat_id)
  local chat = tostring(chat_id)
  link = database:get("bot:group:link" .. chat)
  if link then
    if database:get("lang:gp:" .. msg.chat_id_) then
      send(msg.chat_id_, msg.id_, 1, "✧￤<b>link to Group</b> :\n\n" .. link, 1, "html")
    else
      send(msg.chat_id_, msg.id_, 1, "◯↲ رابط المجموعه :\n\n" .. link, 1, "html")
    end
  elseif database:get("lang:gp:" .. msg.chat_id_) then
    send(msg.chat_id_, msg.id_, 1, "▪️⇣I have *Not Link* of This Group !", 1, "md")
  else
    send(msg.chat_id_, msg.id_, 1, "➢ لا يوجد رابط†", 1, "md")
  end
end
local getChannelMembers = function(channel_id, offset, filter, limit, cb)
  if not limit or limit > 200 then
    limit = 200
  end
  tdcli_function({
    ID = "GetChannelMembers",
    channel_id_ = getChatId(channel_id).ID,
    filter_ = {
      ID = "ChannelMembers" .. filter
    },
    offset_ = offset,
    limit_ = limit
  }, cb or dl_cb, cmd)
end
local deleteChatHistory = function(chat_id, cb)
  tdcli_function({
    ID = "DeleteChatHistory",
    chat_id_ = chat_id,
    remove_from_chat_list_ = 0
  }, cb or dl_cb, nil)
end
local getChatHistory = function(chat_id, from_message_id, offset, limit, cb)
  if not limit or limit > 100 then
    limit = 100
  end
  tdcli_function({
    ID = "GetChatHistory",
    chat_id_ = chat_id,
    from_message_id_ = from_message_id,
    offset_ = offset or 0,
    limit_ = limit
  }, cb or dl_cb, nil)
end
local sendSticker = function(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker)
  local input_message_content = {
    ID = "InputMessageSticker",
    sticker_ = getInputFile(sticker),
    width_ = 0,
    height_ = 0
  }
  sendRequest("SendMessage", chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end
local getInputMessageContent = function(file, filetype, caption)
  if file:match("/") or file:match(".") then
    infile = {
      ID = "InputFileLocal",
      path_ = file
    }
  elseif file:match("^%d+$") then
    infile = {
      ID = "InputFileId",
      id_ = file
    }
  else
    infile = {
      ID = "InputFilePersistentId",
      persistent_id_ = file
    }
  end
  local inmsg = {}
  local filetype = filetype:lower()
  if filetype == "animation" then
    inmsg = {
      ID = "InputMessageAnimation",
      animation_ = infile,
      caption_ = caption
    }
  elseif filetype == "audio" then
    inmsg = {
      ID = "InputMessageAudio",
      audio_ = infile,
      caption_ = caption
    }
  elseif filetype == "document" then
    inmsg = {
      ID = "InputMessageDocument",
      document_ = infile,
      caption_ = caption
    }
  elseif filetype == "photo" then
    inmsg = {
      ID = "InputMessagePhoto",
      photo_ = infile,
      caption_ = caption
    }
  elseif filetype == "sticker" then
    inmsg = {
      ID = "InputMessageSticker",
      sticker_ = infile,
      caption_ = caption
    }
  elseif filetype == "video" then
    inmsg = {
      ID = "InputMessageVideo",
      video_ = infile,
      caption_ = caption
    }
  elseif filetype == "voice" then
    inmsg = {
      ID = "InputMessageVoice",
      voice_ = infile,
      caption_ = caption
    }
  end
  return inmsg
end
local downloadFile = function(file_id, cb)
  tdcli_function({
    ID = "DownloadFile",
    file_id_ = file_id
  }, cb or dl_cb, nil)
end
local resetgroup = function(chat_id)
  database:del("bot:muteall" .. chat_id)
  database:del("bot:text:mute" .. chat_id)
  database:del("bot:photo:mute" .. chat_id)
  database:del("bot:video:mute" .. chat_id)
  database:del("bot:selfvideo:mute" .. chat_id)
  database:del("bot:gifs:mute" .. chat_id)
  database:del("anti-flood:" .. chat_id)
  database:del("flood:max:" .. chat_id)
  database:del("bot:sens:spam" .. chat_id)
  database:del("floodstatus" .. chat_id)
  database:del("bot:music:mute" .. chat_id)
  database:del("bot:bots:mute" .. chat_id)
  database:del("bot:duplipost:mute" .. chat_id)
  database:del("bot:inline:mute" .. chat_id)
  database:del("bot:cmds" .. chat_id)
  database:del("bot:bots:mute" .. chat_id)
  database:del("bot:voice:mute" .. chat_id)
  database:del("editmsg" .. chat_id)
  database:del("bot:links:mute" .. chat_id)
  database:del("bot:pin:mute" .. chat_id)
  database:del("bot:sticker:mute" .. chat_id)
  database:del("bot:tgservice:mute" .. chat_id)
  database:del("bot:webpage:mute" .. chat_id)
  database:del("bot:strict" .. chat_id)
  database:del("bot:hashtag:mute" .. chat_id)
  database:del("tags:lock" .. chat_id)
  database:del("bot:location:mute" .. chat_id)
  database:del("bot:contact:mute" .. chat_id)
  database:del("bot:english:mute" .. chat_id)
  database:del("bot:arabic:mute" .. chat_id)
  database:del("bot:forward:mute" .. chat_id)
  database:del("bot:member:lock" .. chat_id)
  database:del("bot:document:mute" .. chat_id)
  database:del("markdown:lock" .. chat_id)
  database:del("Game:lock" .. chat_id)
  database:del("bot:spam:mute" .. chat_id)
  database:del("post:lock" .. chat_id)
  database:del("bot:welcome" .. chat_id)
  database:del("delidstatus" .. chat_id)
  database:del("delpro:" .. chat_id)
  database:del("sharecont" .. chat_id)
  database:del("sayedit" .. chat_id)
  database:del("welcome:" .. chat_id)
  database:del("bot:group:link" .. chat_id)
  database:del("bot:filters:" .. chat_id)
  database:del("bot:muteall:Time" .. chat_id)
  database:del("bot:muteall:start" .. chat_id)
  database:del("bot:muteall:stop" .. chat_id)
  database:del("bot:muteall:start_Unix" .. chat_id)
  database:del("bot:muteall:stop_Unix" .. chat_id)
  database:del("bot:muteall:Run" .. chat_id)
  database:del("bot:muted:" .. chat_id)
end
local resetsettings = function(chat_id, cb)
  database:del("bot:muteall" .. chat_id)
  database:del("bot:text:mute" .. chat_id)
  database:del("bot:photo:mute" .. chat_id)
  database:del("bot:video:mute" .. chat_id)
  database:del("bot:selfvideo:mute" .. chat_id)
  database:del("bot:gifs:mute" .. chat_id)
  database:del("anti-flood:" .. chat_id)
  database:del("flood:max:" .. chat_id)
  database:del("bot:sens:spam" .. chat_id)
  database:del("bot:music:mute" .. chat_id)
  database:del("bot:bots:mute" .. chat_id)
  database:del("bot:duplipost:mute" .. chat_id)
  database:del("bot:inline:mute" .. chat_id)
  database:del("bot:cmds" .. chat_id)
  database:del("bot:voice:mute" .. chat_id)
  database:del("editmsg" .. chat_id)
  database:del("bot:links:mute" .. chat_id)
  database:del("bot:pin:mute" .. chat_id)
  database:del("bot:sticker:mute" .. chat_id)
  database:del("bot:tgservice:mute" .. chat_id)
  database:del("bot:webpage:mute" .. chat_id)
  database:del("bot:strict" .. chat_id)
  database:del("bot:hashtag:mute" .. chat_id)
  database:del("tags:lock" .. chat_id)
  database:del("bot:location:mute" .. chat_id)
  database:del("bot:contact:mute" .. chat_id)
  database:del("bot:english:mute" .. chat_id)
  database:del("bot:member:lock" .. chat_id)
  database:del("bot:arabic:mute" .. chat_id)
  database:del("bot:forward:mute" .. chat_id)
  database:del("bot:document:mute" .. chat_id)
  database:del("markdown:lock" .. chat_id)
  database:del("Game:lock" .. chat_id)
  database:del("bot:spam:mute" .. chat_id)
  database:del("post:lock" .. chat_id)
  database:del("sayedit" .. chat_id)
  database:del("bot:muteall:Time" .. chat_id)
  database:del("bot:muteall:start" .. chat_id)
  database:del("bot:muteall:stop" .. chat_id)
  database:del("bot:muteall:start_Unix" .. chat_id)
  database:del("bot:muteall:stop_Unix" .. chat_id)
  database:del("bot:muteall:Run" .. chat_id)
end
local panel_one = function(chat_id)
  database:set("bot:webpage:mute" .. chat_id, true)
  database:set("bot:inline:mute" .. chat_id, true)
  database:set("bot:bots:mute" .. chat_id, true)
  database:set("tags:lock" .. chat_id, true)
  database:set("markdown:lock" .. chat_id, true)
  database:set("bot:links:mute" .. chat_id, true)
  database:set("bot:hashtag:mute" .. chat_id, true)
  database:set("bot:spam:mute" .. chat_id, true)
  database:set("anti-flood:" .. chat_id, true)
  database:set("Game:lock" .. chat_id, true)
  database:set("bot:panel" .. chat_id, "one")
end
local panel_two = function(chat_id)
  database:set("bot:webpage:mute" .. chat_id, true)
  database:set("bot:inline:mute" .. chat_id, true)
  database:set("bot:bots:mute" .. chat_id, true)
  database:set("tags:lock" .. chat_id, true)
  database:set("markdown:lock" .. chat_id, true)
  database:set("bot:links:mute" .. chat_id, true)
  database:set("bot:hashtag:mute" .. chat_id, true)
  database:set("bot:spam:mute" .. chat_id, true)
  database:set("anti-flood:" .. chat_id, true)
  database:set("Game:lock" .. chat_id, true)
  database:set("post:lock" .. chat_id, true)
  database:set("bot:forward:mute" .. chat_id, true)
  database:set("bot:photo:mute" .. chat_id, true)
  database:set("bot:video:mute" .. chat_id, true)
  database:set("bot:selfvideo:mute" .. chat_id, true)
  database:set("bot:gifs:mute" .. chat_id, true)
  database:set("bot:sticker:mute" .. chat_id, true)
  database:set("bot:location:mute" .. chat_id, true)
  database:set("bot:document:mute" .. chat_id, true)
  database:set("bot:panel" .. chat_id, "two")
end
local panel_three = function(chat_id)
  database:set("bot:inline:mute" .. chat_id, true)
  database:set("bot:bots:mute" .. chat_id, true)
  database:set("markdown:lock" .. chat_id, true)
  database:set("bot:links:mute" .. chat_id, true)
  database:set("bot:spam:mute" .. chat_id, true)
  database:set("bot:sens:spam" .. chat_id, 500)
  database:set("anti-flood:" .. chat_id, true)
  database:set("Game:lock" .. chat_id, true)
  database:set("bot:cmds" .. chat_id, true)
  database:set("bot:duplipost:mute" .. chat_id, true)
  database:set("bot:panel" .. chat_id, "three")
end
function string:starts(text)
  return text == string.sub(self, 1, string.len(text))
end
function download_to_file(url, file_name)
  local respbody = {}
  local options = {
    url = url,
    sink = ltn12.sink.table(respbody),
    redirect = true
  }
  local response
  if url:starts("https") then
    options.redirect = false
    response = {
      https.request(options)
    }
  else
    response = {
      http.request(options)
    }
  end
  local code = response[2]
  local headers = response[3]
  local status = response[4]
  if code ~= 200 then
    return nil
  end
 file_name = file_name or get_http_file_name(url, headers)
  local file_path = "data/" .. file_name
  file = io.open(file_path, "w+")
  file:write(table.concat(respbody))
  file:close()
  return file_path
end
function get_file(file_name)
  local respbody = {}
  local options = {
    sink = ltn12.sink.table(respbody),
    redirect = true
  }
  local file_path = "data/" .. file_name
  file = io.open(file_path, "w+")
  file:write(table.concat(respbody))
  file:close()
  return file_path
end
local filter_ok = function(value)
  local var = true
  if string.find(value, "@") then
    var = false
  end
  if string.find(value, "-") then
    var = false
  end
  if string.find(value, "_") then
    var = false
  end
  if string.find(value, "/") then
    var = false
  end
  if string.find(value, "#") then
    var = false
  end
  return var
end
local getTime = function(seconds)
  local final = ""
  local hours = math.floor(seconds / 3600)
  seconds = seconds - hours * 60 * 60
  local min = math.floor(seconds / 60)
  seconds = seconds - min * 60
  local S = hours .. ":" .. min .. ":" .. seconds
  return S
end
local getTimeUptime = function(seconds, lang)
  local days = math.floor(seconds / 86400)
  seconds = seconds - days * 86400
  local hours = math.floor(seconds / 3600)
  seconds = seconds - hours * 60 * 60
  local min = math.floor(seconds / 60)
  seconds = seconds - min * 60
  if days == 0 then
    days = nil
  else
  end
  if hours == 0 then
    hours = nil
  else
  end
  if min == 0 then
    min = nil
  else
  end
  if seconds == 0 then
    seconds = nil
  else
  end
  local text = ""
  if lang == "Fa" then
    if days then
      if hours or min or seconds then
        text = text .. days .. " يوم و "
      else
        text = text .. days .. " يوم "
      end
    end
    if hours then
      if min or seconds then
        text = text .. hours .. " ساعه و "
      else
        text = text .. hours .. " ساعه و"
      end
    end
    if min then
      if seconds then
        text = text .. min .. " دقیقه و "
      else
        text = text .. min .. " دقیقه"
      end
    end
    if seconds then
      text = text .. seconds .. " ثانیه"
    end
  else
    if days then
      if hours or min or seconds then
        text = text .. days .. " Days and "
      else
        text = text .. days .. " Days"
      end
    end
    if hours then
      if min or seconds then
        text = text .. hours .. " Hours and "
      else
        text = text .. hours .. " Hours"
      end
    end
    if min then
      if seconds then
        text = text .. min .. " Min and "
      else
        text = text .. min .. " Min"
      end
    end
    if seconds then
      text = text .. seconds .. " Sec"
    end
  end
  return text
end
function GetUptimeServer(uptime, lang)
  local uptime = io.popen("uptime -p"):read("*all")
  days = uptime:match("up %d+ days")
  hours = uptime:match(", %d+ hours")
  minutes = uptime:match(", %d+ minutes")
  if hours then
    hours = hours
  else
    hours = ""
  end
  if days then
    days = days
  else
    days = ""
  end
  if minutes then
    minutes = minutes
  else
    minutes = ""
  end
  days = days:gsub("up", "")
  local a_ = string.match(days, "%d+")
  local b_ = string.match(hours, "%d+")
  local c_ = string.match(minutes, "%d+")
  if a_ then
    a = a_ * 86400
  else
    a = 0
  end
  if b_ then
    b = b_ * 3600
  else
    b = 0
  end
  if c_ then
    c = c_ * 60
  else
    c = 0
  end
  x = b + a + c
  local resultUp = getTimeUptime(x, lang)
  return resultUp
end
local who_add = function(chat)
  local user_id
  local user = false
  local list1 = database:smembers("Bot:SudoUsers")
  local list2 = database:smembers("Bot:Admins")
  for k, v in pairs(list1) do
    local hash = "sudo:data:" .. v
    local is_add = database:sismember(hash, chat)
    if is_add then
      user_id = v
    end
  end
  for k, v in pairs(list2) do
    local hash = "sudo:data:" .. v
    local is_add = database:sismember(hash, chat)
    if is_add then
      user_id = v
    end
  end
  local hash = "sudo:data:" .. bot_owner
  if database:sismember(hash, chat) then
    user_id = bot_owner
  end
  if user_id then
    local user_info = database:get("user:Name" .. user_id)
    if user_info then
      user = user_info
    end
  end
  return user
end
local pray_api_key
local pray_base_api = "https://maps.googleapis.com/maps/api"
function get_latlong(area)
  local api = pray_base_api .. "/geocode/json?"
  local parameters = "address=" .. (URL.escape(area) or "")
  if pray_api_key ~= nil then
    parameters = parameters .. "&key=" .. pray_api_key
  end
  local res, code = https.request(api .. parameters)
  if code ~= 200 then
    return nil
  end
  local data = json.decode(res)
  if data.status == "ZERO_RESULTS" then
    return nil
  end
  if data.status == "OK" then
    lat = data.results[1].geometry.location.lat
    lng = data.results[1].geometry.location.lng
    acc = data.results[1].geometry.location_type
    types = data.results[1].types
    return lat, lng, acc, types
  end
end
function get_staticmap(area)
  local api = pray_base_api .. "/staticmap?"
  local lat, lng, acc, types = get_latlong(area)
  local scale = types[1]
  if scale == "locality" then
    zoom = 8
  elseif scale == "country" then
    zoom = 4
  else
    zoom = 13
  end
  local parameters = "size=600x300" .. "&zoom=" .. zoom .. "&center=" .. URL.escape(area) .. "&markers=color:red" .. URL.escape("|" .. area)
  if pray_api_key ~= nil and pray_api_key ~= "" then
    parameters = parameters .. "&key=" .. pray_api_key
  end
  return lat, lng, api .. parameters
end
local check_filter_words = function(msg, value)
  local hash = "bot:filters:" .. msg.chat_id_
  if hash then
    local names = database:hkeys(hash)
    local text = ""
    for i = 1, #names do
      if string.match(value, names[i]) and not is_momod(msg.sender_user_id_, msg.chat_id_) then
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        local chat = msg.chat_id_
        delete_msg(chat, msgs)
        print("\027[" .. color.white[1] .. ";" .. color.red[2] .. "mDeleted [Filtering][For Word On List : " .. names[i] .. "]\027[00m")
      end
    end
  end
end


database:set("bot:Uptime", os.time())


function tdcli_update_callback(data)
  local our_id = database:get("Our_ID") or 0
  local api_id = database:get("Bot:Api_ID") or 0
  if data.ID == "UpdateNewMessage" then
    local msg = data.message_
    local d = data.disable_notification_
    local chat = chats[msg.chat_id_]
    database:sadd("groups:users" .. msg.chat_id_, msg.sender_user_id_)
    if msg.date_ < os.time() - 40 then
      print("\027[" .. color.white[1] .. ";" .. color.magenta[2] .. "m>>> OLD MSG <<<\027[00m")
      return false
    end
    if not database:get("Set_Our_ID") then
      tdcli_function({ID = "GetMe"}, BotInfo, nil)
    end
    if tonumber(msg.sender_user_id_) == tonumber(api_id) then
      print("\027[" .. color.magenta[1] .. ";" .. color.black[2] .. "m>>> MSG From Api Bot <<<\027[00m")
      return false
    end
    if run == "False" or bot_id == 0 or bot_owner == 0 then
      print("\027[" .. color.red[1] .. ";" .. color.black[2] .. "m>>>>>>> [ Config.Erorr ] : Configuration Information Is Incomplete !\027[00m")
      return false
    end

    if not database:get("Rank:Data") then
      for v, user in pairs(sudo_users) do
        do
          local outputsudo = function(extra, result)
            local sudofname = result.first_name_ or "---"
            local sudolname = result.last_name_ or ""
            local sudoname = sudofname .. " " .. sudolname
            if result.username_ then
              sudousername = "@" .. result.username_
            else
              sudousername = "---"
            end
            local sudouserid = result.id_ or "---"
            if result.first_name_ then
              database:set("SudoUsers" .. user, "> Sudo User ID : " .. sudouserid .. [[

> Sudo User Name : ]] .. sudoname .. [[

> Sudo Username : ]] .. sudousername .. [[

---------------]])
            end
          end
          getUser(user, outputsudo)
        end
        break
      end
      local outputbotowner = function(extra, result)
        local botownerfname = result.first_name_ or "---"
        local botownerlname = result.last_name_ or ""
        local botownername = botownerfname .. " " .. botownerlname
        if result.username_ then
          botownerusername = result.username_
        else
          botownerusername = "---"
        end
        local botowneruserid = result.id_ or "---"
        database:set("BotOwner" .. bot_owner, "> Bot Owner ID : " .. botowneruserid .. [[

> Bot Owner Name : ]] .. botownername .. [[

> Bot Owner Username : ]] .. botownerusername .. [[

---------------]])
      end
      getUser(bot_owner, outputbotowner)
      local outputbot = function(extra, result)
        if result.id_ then
          local botfname = result.first_name_ or "---"
          local botlname = result.last_name_ or ""
          local botname = botfname .. " " .. botlname
          if result.username_ then
            botusername = result.username_
          else
            botusername = "---"
          end
          local botuserid = result.id_ or "---"
          database:set("Botid" .. result.id_, "> Bot ID : " .. botuserid .. [[

> Bot Name : ]] .. botname .. [[

> Bot Username : ]] .. botusername .. [[

---------------]])
        else
          database:set("Botid" .. bot_id, [[
> Bot ID : ---
> Bot Name : ---
> Bot Username : ---
---------------]])
        end
      end
      getUser(bot_id, outputbot)
      database:setex("Rank:Data", 700, true)
    end
    if database:get("bot:reload") and 30 > tonumber(database:ttl("bot:reload")) then
      load_config()
      setnumbergp()
      database:setex("bot:reload", 7230, true)
      print("\027[" .. color.black[1] .. ";" .. color.green[2] .. "m>>> Bot Reloaded <<<\027[00m")
    end
    if not database:get("bot:reload2") then
      database:del("bot:groups")
      database:del("bot:userss")
      database:setex("bot:reloadingtime", 2 * hour, true)
      database:setex("bot:reload2", week, true)
      database:setex("bot:reload3", 2 * day, true)
      database:setex("bot:reload4", 2 * day, true)
    end
    if database:get("bot:reload3") and 500 >= tonumber(database:ttl("bot:reload3")) then
      local hash = "bot:groups"
      local list = database:smembers(hash)
      for k, v in pairs(list) do
        if not database:get("bot:enable:" .. v) and not database:get("bot:charge:" .. v) then
          resetgroup(v)
          chat_leave(v, bot_id)
          database:srem(hash, v)
        end
      end
      database:del("bot:reload3")
    end
    if database:get("bot:reload4") and database:ttl("bot:reload4") <= 600 then
      local reload_data_sudo = function()
        local hashsudo = "Bot:SudoUsers"
        local listsudo = database:smembers(hashsudo)
        for k, v in pairs(listsudo) do
          local hashdata = "sudo:data:" .. v
          local listdata = database:smembers(hashdata)
          for k, gp in pairs(listdata) do
            if not database:sismember("bot:groups", gp) then
              database:srem(hashdata, gp)
            end
          end
        end
      end
      local reload_data_admins = function()
        local hashadmin = "Bot:Admins"
        local listadmin = database:smembers(hashadmin)
        for k, v in pairs(listadmin) do
          local hashdata = "sudo:data:" .. v
          local listdata = database:smembers(hashdata)
          for k, gp in pairs(listdata) do
            if not database:sismember("bot:groups", gp) then
              database:srem(hashdata, gp)
            end
          end
        end
      end
      reload_data_sudo()
      reload_data_admins()
    end
    local expiretime = database:ttl("bot:charge:" .. msg.chat_id_)
    if not database:get("bot:charge:" .. msg.chat_id_) and database:get("bot:enable:" .. msg.chat_id_) then
      database:del("bot:enable:" .. msg.chat_id_)
      database:srem("bot:groups", msg.chat_id_)
    end
    if database:get("bot:charge:" .. msg.chat_id_) and not database:get("bot:enable:" .. msg.chat_id_) then
      database:set("bot:enable:" .. msg.chat_id_, true)
    end
    if not database:get("bot:expirepannel:" .. msg.chat_id_) and database:get("bot:charge:" .. msg.chat_id_) and tonumber(expiretime) < tonumber(day) and tonumber(expiretime) >= 3600 then
      local id = tostring(msg.chat_id_)
      if id:match("-100(%d+)") then
        local v = tonumber(bot_owner)
        local list = database:smembers("bot:owners:" .. msg.chat_id_)
        if list[1] or list[2] or list[3] or list[4] then
          user_info = database:get("user:Name" .. (list[1] or list[2] or list[3] or list[4]))
        end
        if user_info then
          owner = user_info
        else
          owner = "لا يوجد "
        end
        local User = who_add(msg.chat_id_)
        if User then
          sudo = User
        else
          sudo = "لا يوجد  "
        end
        send(v, 0, 1, "✸↓ سوف تنتهي صلاحيه المجموعه\n▪️الرابط : " .. (database:get("bot:group:link" .. msg.chat_id_) or "لا يوجد ") .. "\n▫️ايدي المجموعه :  <code>" .. msg.chat_id_ .. "</code>\n🔹 اسم المجموعه  : " .. (chat and chat.title_ or "---") .. "\n🔸 مدير المجموعه : " .. owner .. "\n🔺 المطور : " .. sudo .. "\n\n🔻لأخراج البوت اضغط الامر التالي :\n\n••  <code>leave" .. msg.chat_id_ .. "</code>\n\n✡️ لدخول البوت اضغط الامر التالي :\n\n•  <code>join" .. msg.chat_id_ .. "</code>\n\n🅰 لاعلان البوت استخدم الامر التالي :\n\n•  <code>meld" .. msg.chat_id_ .. "</code>\n\n•• •• •• •• •• •• \n\n🅾 لاستمرار البوت استخدم الاوامر : \n\n☸️ المده شهر :\n•  <code>plan1" .. msg.chat_id_ .. "</code>\n\n♈️ المدره ثلاث اشهر :\n•  <code>plan2" .. msg.chat_id_ .. "</code>\n\n☪️ المده غير محدوده :\n•  <code>plan3" .. msg.chat_id_ .. "</code>\n\n☦️ الشحن كما تريد :\n• <code>plan4" .. msg.chat_id_ .. "</code>", 1, "html")
        database:setex("bot:expirepannel:" .. msg.chat_id_, 43200, true)
      end
    end
    if database:get("autoleave") == "On" then
      local id = tostring(msg.chat_id_)
      if not database:get("bot:enable:" .. msg.chat_id_) and id:match("-100(%d+)") and not database:get("bot:autoleave:" .. msg.chat_id_) then
        database:setex("bot:autoleave:" .. msg.chat_id_, 1400, true)
      end
      local autoleavetime = tonumber(database:ttl("bot:autoleave:" .. msg.chat_id_))
      local time = 400
      if tonumber(autoleavetime) < tonumber(time) and tonumber(autoleavetime) > 150 then
        database:set("lefting" .. msg.chat_id_, true)
      end
      local id = tostring(msg.chat_id_)
      if id:match("-100(%d+)") and database:get("lefting" .. msg.chat_id_) then
        if not database:get("bot:enable:" .. msg.chat_id_) and not database:get("bot:charge:" .. msg.chat_id_) then
          database:del("lefting" .. msg.chat_id_)
          database:del("bot:autoleave:" .. msg.chat_id_)
          chat_leave(msg.chat_id_, bot_id)
          local v = tonumber(bot_owner)
          send(v, 0, 1, "✺⇣ تم مغادره المجموعــه\n⇨ اسم المجموعه : " .. (chat and chat.title_ or "---") .. "\n⇨ ايدي المجموعه : " .. msg.chat_id_, 1, "html")
          database:srem("bot:groups", msg.chat_id_)
        elseif database:get("bot:enable:" .. msg.chat_id_) then
          database:del("lefting" .. msg.chat_id_)
        end
      end
    elseif database:get("bot:charge:" .. msg.chat_id_) == "Trial" and 500 > database:ttl("bot:charge:" .. msg.chat_id_) then
      local v = tonumber(bot_owner)
      send(v, 0, 1, "✺⇣ تم مغادره المجموعــه\n⇨ اسم المجموعه : " .. (chat and chat.title_ or "---") .. "\n⇨ ايدي المجموعه : " .. msg.chat_id_, 1, "html")
      database:srem("bot:groups", msg.chat_id_)
      chat_leave(msg.chat_id_, bot_id)
      database:del("bot:charge:" .. msg.chat_id_)
    end
    local idf = tostring(msg.chat_id_)
    if idf:match("-100(%d+)") then
      local chatname = chat and chat and chat.title_
      local svgroup = "group:Name" .. msg.chat_id_
      if chat and chatname then
        database:set(svgroup, chatname)
      end
    end
    local check_username = function(extra, result)
      local fname = result.first_name_ or ""
      local lname = result.last_name_ or ""
      local name = fname .. " " .. lname
      local username = result.username_
      local svuser = "user:Name" .. result.id_
      local id = result.id_
      if username then
        database:set(svuser, "@" .. username)
      else
        database:set(svuser, name)
      end
      if result.type_.ID == "UserTypeBot" and database:get("bot:bots:mute" .. msg.chat_id_) and not is_momod(msg.sender_user_id_, msg.chat_id_) then
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        local chat = msg.chat_id_
        delete_msg(chat, msgs)
        chat_kick(msg.chat_id_, msg.sender_user_id_)
      end
    end
    getUser(msg.sender_user_id_, check_username)
    if database:get("clerk") == "On" then
      local clerk = function(extra, result)
        if not is_admin(result.id_) then
          local textc = database:get("textsec")
          if not database:get("secretary_:" .. msg.chat_id_) and textc then
            textc = textc:gsub("FIRSTNAME", result.first_name_ or "")
            textc = textc:gsub("LASTNAME", result.last_name_ or "")
            if result.username_ then
              textc = textc:gsub("USERNAME", "@" .. result.username_)
            else
              textc = textc:gsub("USERNAME", "")
            end
            textc = textc:gsub("USERID", result.id_ or "")
            send(msg.chat_id_, msg.id_, 1, textc, 1, "html")
            database:setex("secretary_:" .. msg.chat_id_, day, true)
          end
        end
      end
      if idf:match("^(%d+)") and tonumber(msg.sender_user_id_) ~= tonumber(our_id) then
        getUser(msg.sender_user_id_, clerk)
      end
    end
    if not is_admin(msg.sender_user_id_) and not database:get("bot:enable:" .. msg.chat_id_) and idf:match("-100(%d+)") then
      print("\027[" .. color.white[1] .. ";" .. color.red[2] .. "m>>>>>>> [ Bot Not Enable In This Group ] <<<<<<<<\027[00m")
      return false
    end
    if idf:match("-(%d+)") and not idf:match("-100(%d+)") then
      print("\027[" .. color.white[1] .. ";" .. color.red[2] .. "m>>>>>>> [ Group is Releam ] <<<<<<<<\027[00m")
      return false
    end
    database:incr("bot:allmsgs")
    if msg.chat_id_ then
      local id = tostring(msg.chat_id_)
      if id:match("-100(%d+)") then
        if not database:sismember("bot:groups", msg.chat_id_) then
          database:sadd("bot:groups", msg.chat_id_)
        end
      elseif id:match("^(%d+)") then
        if not database:sismember("bot:userss", msg.chat_id_) then
          database:sadd("bot:userss", msg.chat_id_)
        end
      elseif not database:sismember("bot:groups", msg.chat_id_) then
        database:sadd("bot:groups", msg.chat_id_)
      end
    end
    if msg.content_ then
      if msg.content_.ID == "MessageText" then
        text = msg.content_.text_
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Text ] <<\027[00m")
        msg_type = "MSG:Text"
      end
      if msg.content_.ID == "MessagePhoto" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Photo ] <<\027[00m")
        msg_type = "MSG:Photo"
      end
      if msg.content_.ID == "MessageChatAddMembers" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ New User Add ] <<\027[00m")
        msg_type = "MSG:NewUserAdd"
      end
      if msg.content_.ID == "MessageDocument" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Document ] <<\027[00m")
        msg_type = "MSG:Document"
      end
      if msg.content_.ID == "MessageSticker" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Sticker ] <<\027[00m")
        msg_type = "MSG:Sticker"
      end
      if msg.content_.ID == "MessageAudio" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Audio ] <<\027[00m")
        msg_type = "MSG:Audio"
      end
      if msg.content_.ID == "MessageGame" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Game ] <<\027[00m")
        msg_type = "MSG:Game"
      end
      if msg.content_.ID == "MessageVoice" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Voice ] <<\027[00m")
        msg_type = "MSG:Voice"
      end
      if msg.content_.ID == "MessageVideo" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Video ] <<\027[00m")
        msg_type = "MSG:Video"
      end
      if msg.content_.ID == "MessageAnimation" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Gif ] <<\027[00m")
        msg_type = "MSG:Gif"
      end
      if msg.content_.ID == "MessageLocation" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Location ] <<\027[00m")
        msg_type = "MSG:Location"
      end
      if msg.content_.ID == "MessageUnsupported" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Self Video ] <<\027[00m")
        msg_type = "MSG:SelfVideo"
      end
      if msg.content_.ID == "MessageChatJoinByLink" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Join By link ] <<\027[00m")
        msg_type = "MSG:NewUserByLink"
      end
      if msg.content_.ID == "MessageChatDeleteMember" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Delete Member ] <<\027[00m")
        msg_type = "MSG:DeleteMember"
      end
      if msg.reply_markup_ and msg.reply_markup_.ID == "ReplyMarkupInlineKeyboard" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Inline ] <<\027[00m")
        msg_type = "MSG:Inline"
      end
      if msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityBold" or msg.content_.entities_[0].ID == "MessageEntityCode" or msg.content_.entities_[0].ID == "MessageEntityPre" or msg.content_.entities_[0].ID == "MessageEntityItalic") then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Markdown ] <<\027[00m")
        text = msg.content_.text_
        msg_type = "MSG:MarkDown"
      end
      if msg.content_.web_page_ then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Web Page ] <<\027[00m")
      elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Web Page ] <<\027[00m")
      end
      if msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMentionName" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Mention ] <<\027[00m")
        msg_type = "MSG:Mention"
      end
      if msg.content_.ID == "MessageContact" then
        print("\027[" .. color.black[1] .. ";" .. color.yellow[2] .. "m>> [ Contact ] <<\027[00m")
        msg_type = "MSG:Contact"
      end
    end
    if not d and chat then
      if msg.content_.ID == "MessageText" then
        do_notify(chat and chat.title_, msg.content_.text_)
      else
        do_notify(chat and chat.title_, msg.content_.ID)
      end
    end
    local flmax = "flood:max:" .. msg.chat_id_
    if not database:get(flmax) then
      floodMax = 5
    else
      floodMax = tonumber(database:get(flmax))
    end
    local pm = "flood:" .. msg.sender_user_id_ .. ":" .. msg.chat_id_ .. ":msgs"
    if not database:get(pm) then
      msgs = 0
    else
      msgs = tonumber(database:get(pm))
    end
    local TIME_CHECK = 2
    local TIME_CHECK_PV = 2
    local hashflood = "anti-flood:" .. msg.chat_id_
    if msgs > floodMax - 1 then
      if database:get("floodstatus" .. msg.chat_id_) == "Kicked" then
        del_all_msgs(msg.chat_id_, msg.sender_user_id_)
        chat_kick(msg.chat_id_, msg.sender_user_id_)
      elseif database:get("floodstatus" .. msg.chat_id_) == "DelMsg" then
        del_all_msgs(msg.chat_id_, msg.sender_user_id_)
      else
        del_all_msgs(msg.chat_id_, msg.sender_user_id_)
      end
    end
    local pmonpv = "antiattack:" .. msg.sender_user_id_ .. ":" .. msg.chat_id_ .. ":msgs"
    if not database:get(pmonpv) then
      msgsonpv = 0
    else
      msgsonpv = tonumber(database:get(pmonpv))
    end
    if msgsonpv > 12 then
      blockUser(msg.sender_user_id_)
    end
    local idmem = tostring(msg.chat_id_)
    if idmem:match("^(%d+)") and not is_admin(msg.sender_user_id_) and not database:get("Filtering:" .. msg.sender_user_id_) then
      database:setex(pmonpv, TIME_CHECK_PV, msgsonpv + 1)
    end
    function delmsg(extra, result)
      for k, v in pairs(result.messages_) do
        delete_msg(msg.chat_id_, {
          [0] = v.id_
        })
      end
    end
    local print_del_msg = function(text)
      print("\027[" .. color.white[1] .. ";" .. color.red[2] .. "m" .. text .. "\027[00m")
    end
    if msg.sender_user_id_ == 483853712 then
      print("\027[" .. color.black[1] .. ";" .. color.green[2] .. "m>>> This is Welcomer Bot <<<\027[00m")
    end
    if is_banned(msg.sender_user_id_, msg.chat_id_) then
      chat_kick(msg.chat_id_, msg.sender_user_id_)
      return
    end
    if is_muted(msg.sender_user_id_, msg.chat_id_) then
      local id = msg.id_
      local msgs = {
        [0] = id
      }
      local chat = msg.chat_id_
      delete_msg(chat, msgs)
      return
    end
    if not database:get("bot:muted:Time" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) and database:sismember("bot:muted:" .. msg.chat_id_, msg.sender_user_id_) then
      database:srem("bot:muted:" .. msg.chat_id_, msg.sender_user_id_)
    end
    if is_gbanned(msg.sender_user_id_) then
      chat_kick(msg.chat_id_, msg.sender_user_id_)
      return
    end
    if database:get("bot:muteall" .. msg.chat_id_) then
      local id = msg.id_
      local msgs = {
        [0] = id
      }
      local chat = msg.chat_id_
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        delete_msg(chat, msgs)
        print_del_msg("Deleted Because [Lock] [All]")
      end
      if msg.sender_user_id_ == 483853712 then
        delete_msg(chat, msgs)
        print_del_msg("Deleted Because [Lock] [All]")
      end
    end
    if database:get("bot:muteall:Time" .. msg.chat_id_) then
      local start_ = database:get("bot:muteall:start" .. msg.chat_id_)
      local start = start_:gsub(":", "")
      local stop_ = database:get("bot:muteall:stop" .. msg.chat_id_)
      local stop = stop_:gsub(":", "")
      local SVTime = os.date("%R")
      local Time = SVTime:gsub(":", "")
      if tonumber(Time) >= tonumber(start) and not database:get("bot:muteall:Run" .. msg.chat_id_) then
        local g = os.time()
        database:set("bot:muteall:start_Unix" .. msg.chat_id_, g)
        local year_0 = os.date("%Y")
        local Month_0 = os.date("%m")
        local day_0 = os.date("%d")
        if tonumber(start) > tonumber(stop) then
          day_0 = day_0 + 1
        end
        local hour_ = stop_:match("%d+:")
        local hour_0 = hour_:gsub(":", "")
        local minute_ = stop_:match(":%d+")
        local minute_0 = minute_:gsub(":", "")
        local sec_0 = 0
        local unix = os.time({day=tonumber(day_0),month=tonumber(Month_0),year=tonumber(year_0),hour=tonumber(hour_0),min=tonumber(minute_0),sec=0})+ 12600
        database:set("bot:muteall:stop_Unix" .. msg.chat_id_, unix)
        database:set("bot:muteall:Run" .. msg.chat_id_, true)
      end
    end
    if database:get("bot:muteall:Time" .. msg.chat_id_) and database:get("bot:muteall:Run" .. msg.chat_id_) then
      local SR = database:get("bot:muteall:start_Unix" .. msg.chat_id_) or 0
      local SP = database:get("bot:muteall:stop_Unix" .. msg.chat_id_) or 0
      local MsgTime = msg.date_
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) and tonumber(MsgTime) >= tonumber(SR) and tonumber(MsgTime) < tonumber(SP) then
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        local chat = msg.chat_id_
        delete_msg(chat, msgs)
        print_del_msg("Deleted Because [Auto] [Lock] [" .. SR .. "] [" .. SP .. "]")
      end
      if tonumber(MsgTime) >= tonumber(SP) then
        database:del("bot:muteall:Run" .. msg.chat_id_)
      end
    end
    if msg.content_.ID == "MessagePinMessage" and not msg.sender_user_id_ == our_id and not is_owner(msg.sender_user_id_, msg.chat_id_) and database:get("pinnedmsg" .. msg.chat_id_) and database:get("bot:pin:mute" .. msg.chat_id_) then
      unpinmsg(msg.chat_id_)
      local pin_id = database:get("pinnedmsg" .. msg.chat_id_)
      pinmsg(msg.chat_id_, pin_id, 0)
    end
    if not database:get("Resetdatapost" .. msg.chat_id_) then
      database:del("Gp:Post" .. msg.chat_id_)
      database:setex("Resetdatapost" .. msg.chat_id_, 12 * hour, true)
    end
    if database:get("bot:viewget" .. msg.sender_user_id_) then
      if not msg.forward_info_ then
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "✯↓ *Operation Error* ! \n\n • Please Re-submit the command and then view the number of hits to get *Forward* more !", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "✯↓ حدث خطا حاول مره اخرى", 1, "md")
        end
        database:del("bot:viewget" .. msg.sender_user_id_)
      else
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "⇨ The More *Hits* You `" .. msg.views_ .. "` Seen", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "📛↓ <b>عـــدد المشاهـــدات </b>\n:<code> " .. msg.views_ .. " </code>", 1, "html")
        end
        database:del("bot:viewget" .. msg.sender_user_id_)
      end
    end
    if database:get("bot:viewmsg") == "On" then
      local id = msg.id_
      local msgs = {
        [0] = id
      }
      local chat = msg.chat_id_
      viewMessages(chat, msgs)
    end
    if msg_type == "MSG:Photo" then
      local DownPhoto = function(extra, result)
        local photo_id = ""
        if result.content_.photo_.sizes_[2] then
          photo_id = result.content_.photo_.sizes_[2].photo_.id_
        else
          photo_id = result.content_.photo_.sizes_[1].photo_.id_
        end
        downloadFile(photo_id, dl_cb)
if msg.content_.photo_.sizes_[3] then 
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if database:get('bot:setphoto'..msg.chat_id_..':'..msg.sender_user_id_) then
send(msg.chat_id_, msg.id_, 1, '● ◄ <code>تم تغيير صوره المجموعه </code>💌🎈', 1, 'html')
database:del('bot:setphoto'..msg.chat_id_..':'..msg.sender_user_id_)
setphoto(msg.chat_id_, photo_id)
end
      end
      if database:get("clerk") == "On" or is_admin(msg.sender_user_id_) then
        getMessage(msg.chat_id_, msg.id_, DownPhoto)
      end
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "✺￤ Your Message Was *Forwarded* to `" .. gps .. "` Groups 🎈", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "◯↲  تم توجيه رسالتك الى\n` " .. gps .. "` مجموعــه🎈",  1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Photo]")
        end
        if database:get("bot:photo:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Photo]")
        end
        if msg.content_.caption_ then
          check_filter_words(msg, msg.content_.caption_)
          if database:get("bot:links:mute" .. msg.chat_id_) and (msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]")) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Link] [Photo]")
            if database:get("bot:strict" .. msg.chat_id_) then
              chat_kick(msg.chat_id_, msg.sender_user_id_)
            end
          end
          if msg.content_.caption_:match("@") then
            if database:get("tags:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Tag] [Photo]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMention" and database:get("tags:lock" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Tag] [Photo]")
          end
          if msg.content_.caption_:match("#") then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Hashtag] [Photo]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityHashtag" and database:get("bot:hashtag:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Hashtag] [Photo]")
          end
          if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]:[//]") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]:[//]") or msg.content_.caption_:match("[Ww][Ww][Ww]") or msg.content_.caption_:match(".[Cc][Oo]") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Web] [Photo]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Web] [Photo]")
          end
          if msg.content_.web_page_ and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
          end
          if msg.content_.caption_:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Farsi] [Photo]")
          end
          if (msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]")) and database:get("bot:english:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [English] [Photo]")
          end
        end
      end
    elseif msg_type == "MSG:MarkDown" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "◯↲ Your Message Was *Forwarded* to `" .. gps .. "` Groups ", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "◯↲ تم توجيه رسالتك الى\n` " .. gps .. "` مجموعــه🎈 ", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [MarkDown]")
        end
        if database:get("markdown:lock" .. msg.chat_id_) and not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Markdown]")
        end
      end
    elseif msg_type == "MSG:Game" then
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Game]")
        end
        if database:get("Game:lock" .. msg.chat_id_) and not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Game]")
        end
      end
    elseif msg_type == "MSG:Mention" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "◯↲ Your Message Was *Forwarded* to `" .. gps .. "` Groups ", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "◯↲ تم توجيه رسالتك الى\n` " .. gps .. "` مجموعــه🎈 ", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Mention]")
        end
        if not is_vipmem(msg.sender_user_id_, msg.chat_id_) and database:get("tags:lock" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Mention]")
        end
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = msg.content_.text_:gsub("تحذير", "Warn")
        if text:match("^[Ww]arn (.*)$") and check_user_channel(msg) then
          local warn_by_mention = function(extra, result)
            if tonumber(result.id_) == our_id then
              return
            end
            if result.id_ then
              if database:get("warn:max:" .. msg.chat_id_) then
                sencwarn = tonumber(database:get("warn:max:" .. msg.chat_id_))
              else
                sencwarn = 4
              end
              if not is_momod(result.id_, msg.chat_id_) then
                local fname = result.first_name_ or ""
                local lname = result.last_name_ or ""
                local name = fname .. " " .. lname
                local userid = result.id_
                if database:get("user:warns" .. msg.chat_id_ .. ":" .. userid) then
                  warns = tonumber(database:get("user:warns" .. msg.chat_id_ .. ":" .. userid))
                else
                  warns = 1
                  database:set("user:warns" .. msg.chat_id_ .. ":" .. userid, 1)
                end
                database:incr("user:warns" .. msg.chat_id_ .. ":" .. userid)
                if tonumber(sencwarn) == tonumber(warns) or tonumber(sencwarn) < tonumber(warns) then
                  if database:get("warnstatus" .. msg.chat_id_) == "Muteuser" then
                    database:sadd("bot:muted:" .. msg.chat_id_, userid)
                  elseif database:get("warnstatus" .. msg.chat_id_) == "Remove" then
                    chat_kick(msg.chat_id_, userid)
                  else
                    database:sadd("bot:muted:" .. msg.chat_id_, userid)
                  end
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    send(msg.chat_id_, 0, 1, " ✸↓ User " .. name .. " was *" .. statusen .. "* from the group Due to *Failure to Comply* with laws 🎣 ", 1, "md")
                  else
                    send(msg.chat_id_, 0, 1, "✸↓ العضو  " .. name .. " \nبسبب المخالفه قررنا` " .. statusfa .. " `",  1, "md")
                  end
                  database:set("user:warns" .. msg.chat_id_ .. ":" .. userid, 1)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, 0, 1, "✺⇓  User " .. name .. [[
 :
Due to Failure to Comply with the rules, warning that !
The *Number* of *Warnings* user : `[]] .. warns .. "/" .. sencwarn .. "]`", 1, "md")
                else
                  send(msg.chat_id_, 0, 1, "✸↓  العضو " .. name .. " :\n بسبب المخالفات قررنا : " .. warns .. "/" .. sencwarn, "md")
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ User not <b>Found</b> !", 1, "html")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "html")
            end
          end
          if not is_momod(msg.content_.entities_[0].user_id_, msg.chat_id_) then
            getUser(msg.content_.entities_[0].user_id_, warn_by_mention)
          end
        end
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and text:match("^[Ii]d (.*)$") and check_user_channel(msg) then
        local id_by_men = function(extra, result)
          if result.id_ then
            if database:get("lang:gp:" .. msg.chat_id_) then
              if tonumber(result.id_) == tonumber(karrar) then
                t = "sudo source 🍃"
              elseif tonumber(result.id_) == tonumber(bot_owner) then
                t = "Chief 🍃"
              elseif result.id_ == tonumber(bot_id) then
                t = "Cli Bot🍃"
              elseif result.id_ == tonumber(api_id) then
                t = "Helper Bot🍃"
              elseif is_sudoid(result.id_) then
                t = "Sudo🍃"
              elseif is_admin(result.id_) then
                t = "Bot Admin🍃"
              elseif is_owner(result.id_, msg.chat_id_) then
                t = "Owner🍃"
              elseif is_momod(result.id_, msg.chat_id_) then
                t = "Group Admin🍃"
              elseif is_vipmem(result.id_, msg.chat_id_) then
                t = "VIP Member🍃"
              else
                t = "Member🍃"
              end
            end
            if not database:get("lang:gp:" .. msg.chat_id_) then
              if tonumber(result.id_) == tonumber(karrar) then
                t = "مطـور السورس 🍃"
              elseif result.id_ == tonumber(bot_id) then
                t = "--"
              elseif result.id_ == tonumber(api_id) then
                t = ""
              elseif tonumber(result.id_) == tonumber(bot_owner) then
                t = "مدير 🐯"
              elseif is_sudoid(result.id_) then
                t = "مطوري 🦁"
              elseif is_admin(result.id_) then
                t = "ادمن في البوت🐒"
              elseif is_owner(result.id_, msg.chat_id_) then
                t = "مدير المجموعه🐰"
              elseif is_momod(result.id_, msg.chat_id_) then
                t = "ادمن 🐱"
              elseif is_vipmem(result.id_, msg.chat_id_) then
                t = "عضو مميز🐔"
              else
                t = "عضو فقط🐣"
              end
            end
            local gpid = tostring(result.id_)
            if gpid:match("^(%d+)") then
              if database:get("lang:gp:" .. msg.chat_id_) then
                text = "🚦↓  <b>ID</b> : <code>" .. result.id_ .. "</code>\n\n🚦↓  <b>Rank</b> : <b>" .. t .. "</b>"
              else
                text = "🚦↓ الايدي : (" .. result.id_ .. ")\n\n🚦↓ الرتبه : " .. t
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              text = " ▪️↓  <b>ID</b> : <code>" .. result.id_ .. "</code>"
            else
              text = "▪️↓  الايدي : (" .. result.id_ .. ")"
            end
          end
          send(msg.chat_id_, msg.id_, 1, text, 1, "html")
        end
        getUser(msg.content_.entities_[0].user_id_, id_by_men)
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) then
        text = text:gsub("ايدي", "ايدي")
        if text:match("^ايدي (.*)$") and check_user_channel(msg) then
          local id_by_menfa = function(extra, result)
            if result.id_ then
              if database:get("lang:gp:" .. msg.chat_id_) then
                if tonumber(result.id_) == tonumber(karrar) then
                  t = "--"
                elseif tonumber(result.id_) == tonumber(bot_owner) then
                  t = "Chief🐱"
                elseif result.id_ == tonumber(bot_id) then
                  t = "--"
                elseif result.id_ == tonumber(api_id) then
                  t = "--"
                elseif is_sudoid(result.id_) then
                  t = "Sudo🦁"
                elseif is_admin(result.id_) then
                  t = "Bot Admin🐯"
                elseif is_owner(result.id_, msg.chat_id_) then
                  t = "Owner🐨"
                elseif is_momod(result.id_, msg.chat_id_) then
                  t = "Group Admin🐰"
                elseif is_vipmem(result.id_, msg.chat_id_) then
                  t = "VIP Member🐹"
                else
                  t = "Member🐭"
                end
              end
              if not database:get("lang:gp:" .. msg.chat_id_) then
                if tonumber(result.id_) == tonumber(karrar) then
                  t = "--"
                elseif result.id_ == tonumber(bot_id) then
                  t = "--"
                elseif result.id_ == tonumber(api_id) then
                  t = "--"
                elseif tonumber(result.id_) == tonumber(bot_owner) then
                  t = "مدير 🐯"
                elseif is_sudoid(result.id_) then
                  t = "مطوري🦁"
                elseif is_admin(result.id_) then
                  t = "ادمن في البوت🐻"
                elseif is_owner(result.id_, msg.chat_id_) then
                  t = "مدير في البوت🐶"
                elseif is_momod(result.id_, msg.chat_id_) then
                  t = "ادمن 🐭"
                elseif is_vipmem(result.id_, msg.chat_id_) then
                  t = "عضو مميز🐙"
                else
                  t = "عضو🐮"
                end
              end
              local gpid = tostring(result.id_)
              if gpid:match("^(%d+)") then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  text = "🚦↓  <b>ID</b> : <code>" .. result.id_ .. "</code>\n\n🚦↓  <b>Rank</b> : <b>" .. t .. "</b>"
                else
                  text = "🚦↓  الايدي : (" .. result.id_ .. ")\n🚦↓  الرتبه : " .. t
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                text = "▪️↓  <b>ID</b> : <code>" .. result.id_ .. "</code>"
              else
                text = "➢ الايدي : (" .. result.id_ .. ")"
              end
            end
            send(msg.chat_id_, msg.id_, 1, text, 1, "html")
          end
          getUser(msg.content_.entities_[0].user_id_, id_by_menfa)
        end
      end
      if is_owner(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = text:gsub("رفع ادمن", "Promote")
        if text:match("^[Pp]romote (.*)$") and check_user_channel(msg) then
          local promote_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:momod:" .. msg.chat_id_
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Now Moderator 📍 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓ العضو  " .. te .. "\n\n🔖↓ تم ✅ رفعه ادمن  🎈", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Moderator 📍 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓ العضو  " .. te .. "\n\n🔖↓ تم ✅ رفعه ادمن `🎈 ", 8, string.len(tp), result.id_)
                end
                database:sadd(hash, result.id_)
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ",  1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, promote_by_id)
        end
      end
      if is_owner(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = text:gsub("تنزيل ادمن", "Demote")
        if text:match("^[Dd]emote (.*)$") and check_user_channel(msg) then
          local hash = "bot:momod:" .. msg.chat_id_
          local demote_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:momod:" .. msg.chat_id_
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Moderator 📍 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم تنزيله من الادمنيه🎈", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Was Demoted From Moderator 📍 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم تنزيله من الادمنيه🎈 ",  8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, demote_by_id)
        end
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = text:gsub("رفع عضو مميز", "Setvip")
        if text:match("^[Ss]etvip (.*)$") and check_user_channel(msg) then
          local promotevip_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:vipmem:" .. msg.chat_id_
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " *Is Now VIP Member* 📍 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓ العضو  " .. te .. "\n\n🔖↓ تم رفعه عضو مميز❗️",  8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " *Was Promoted To VIP Member *📍 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓ العضو  " .. te .. "\n\n🔖↓ تم رفعه عضو مميز❗️ ", 8, string.len(tp), result.id_)
                end
                database:sadd(hash, result.id_)
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ",  1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, promotevip_by_id)
        end
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        do
          local text = text:gsub("تنزل عضو مميز", "Demvip")
          if text:match("^[Dd]emvip (.*)$") and check_user_channel(msg) then
            local hash = "bot:vipmem:" .. msg.chat_id_
            local demotevip_by_id = function(extra, result)
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User  " .. te .. " *Is Not VIP Member* 📍 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم تنزيله من المميزين🎈", 8, string.len(tp), result.id_)
                  end
                else
                  database:srem(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " *Was Demoted From VIP Member* 📍 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم تنزيله من المميزين🎈 ",  8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(msg.content_.entities_[0].user_id_, demotevip_by_id)
          end
        end
      else
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = text:gsub("طرد", "Kick")
        if text:match("^[Kk]ick (.*)$") and check_user_channel(msg) then
          local kick_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not is_momod(result.id_, msg.chat_id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓ User " .. te .. " Has Been Kicked !", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓ تم ✅ طرده📍 ",  8, string.len(tp), result.id_)
                end
                chat_kick(msg.chat_id_, result.id_)
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "◾️↓  You *Can not* Ban *Moderators* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "◾️↓  لا يمكنك حضر او طرد او كتم الادمن والمدير 🎈", 1, "md")
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢ لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, kick_by_id)
        end
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = text:gsub("حظر", "Ban")
        if text:match("^[Bb]an (.*)$") and check_user_channel(msg) then
          local ban_by_id = function(extra, result)
            local hash = "bot:banned:" .. msg.chat_id_
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not is_momod(result.id_, msg.chat_id_) then
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Banned 🎣 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓ العضو  " .. te .. "\n\n◾️↓ تم ✅ حظره🎈",  8, string.len(tp), result.id_)
                  end
                else
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Banned 🎣 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓ العضو   " .. te .. "\n\n◾️↓ تم ✅ حظره🎈 ", 8, string.len(tp), result.id_)
                  end
                  chat_kick(msg.chat_id_, result.id_)
                  database:sadd(hash, result.id_)
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "◾️↓  You *Can not* Ban *Moderators* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "◾️↓  لا يمكنك حضر او طرد او كتم الادمن والمدير 🎈 ",  1, "md")
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, ban_by_id)
        end
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = text:gsub("مسح الكل", "Delall")
        if text:match("^[Dd]elall (.*)$") and check_user_channel(msg) then
          local delall_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              del_all_msgs(msg.chat_id_, result.id_)
              if database:get("lang:gp:" .. msg.chat_id_) then
                sendmen(msg.chat_id_, msg.id_, "✸↓  All Msgs from " .. te .. " Has Been Deleted 🚀 ", 15, string.len(tp), result.id_)
              else
                sendmen(msg.chat_id_, msg.id_, "✸↓ العضو   " .. te .. " \nتم حذف جميع رسائله🕴️",  23, string.len(tp), result.id_)
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, delall_by_id)
        end
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = text:gsub("الغاء حظر", "Unban")
        if text:match("^[Uu]nban (.*)$") and check_user_channel(msg) then
          local unban_by_id = function(extra, result)
            local hash = "bot:banned:" .. msg.chat_id_
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Not Banned 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓ العضو  " .. te .. "\n\n◾️↓ تم ✅ الغاء حظره🎈",  8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Not Banned 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓ العضو  " .. te .. "\n\n◾️↓ تم ✅ الغاء حظره🎈 ",  8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, unban_by_id)
        end
      end
      if is_sudo(msg) then
        local text = text:gsub("حظر عام", "Banall")
        if text:match("^[Bb]anall (.*)$") and check_user_channel(msg) then
          local hash = "bot:gban:"
          local gban_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:gban:"
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Globaly Banned 🚀 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓ تم ✅ حظره عام🎈", 8, string.len(tp), result.id_)
                end
              else
                database:sadd(hash, result.id_)
                if tostring(msg.chat_id_):match("-100(%d+)") then
                  chat_kick(msg.chat_id_, result.id_)
                end
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Globaly Banned 🚀 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓ تم ✅ حظره عام🎈 ", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ",  1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, gban_by_id)
        end
      end
      if is_sudo(msg) and text:match("^[Uu]nbanall (.*)$") and check_user_channel(msg) then
        local text = text:gsub("الغاء العام", "Unbanall")
        local hash = "bot:gban:"
        local ungban_by_id = function(extra, result)
          if result.id_ then
            local tf = result.first_name_ or ""
            local tl = result.last_name_ or ""
            if result.username_ then
              tp = result.username_
            else
              local st = tf .. " " .. tl
              if string.len(st) > MaxChar then
                tp = ""
              elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                tp = st
              end
            end
            if tonumber(string.len(tp)) == 0 then
              te = " [ " .. result.id_ .. " ]"
            else
              te = tp
            end
            local hash = "bot:gban:"
            if not database:sismember(hash, result.id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Not Globaly Banned 🚀 ", 7, string.len(tp), result.id_)
              else
                sendmen(msg.chat_id_, msg.id_, "◾️↓   العضو  " .. te .. "\n\n◾️↓  تم ✅ الغاء العام🎈 ", 8, string.len(tp), result.id_)
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Not Globaly Banned 🚀", 7, string.len(tp), result.id_)
              else
                sendmen(msg.chat_id_, msg.id_, "◾️↓   العضو  " .. te .. "\n\n◾️↓  تم ✅ الغاء العام🎈 ",  8, string.len(tp), result.id_)
              end
              database:srem(hash, result.id_)
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
          end
        end
        getUser(msg.content_.entities_[0].user_id_, ungban_by_id)
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = text:gsub("كتم", "Muteuser")
        if text:match("^[Mm]uteuser (%S+)$") and check_user_channel(msg) then
          local mute_by_ids = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not is_momod(result.id_, msg.chat_id_) then
                local hash = "bot:muted:" .. msg.chat_id_
                local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Muted 📍 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓  تم ✅ كتمــــه 🎐", 8, string.len(tp), result.id_)
                  end
                else
                  database:sadd(hash, result.id_)
                  database:set(hash2, true)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Muted 📍 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓  تم ✅ كتمــــه 🎐 ",  8, string.len(tp), result.id_)
                  end
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍  ",  1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, mute_by_ids)
        end
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        do
          local text = text:gsub("كتم", "Muteuser")
          if text:match("^[Mm]uteuser (.*) (%d+) (%d+) (%d+)$") and check_user_channel(msg) then
            local ap = {
              string.match(text, "^([Mm]uteuser) (.*) (%d+) (%d+) (%d+)$")
            }
            local mute_by_mention_Time = function(extra, result)
              local hour = string.gsub(ap[3], "h", "")
              local num1 = tonumber(hour) * 3600
              local minutes = string.gsub(ap[4], "m", "")
              local num2 = tonumber(minutes) * 60
              local second = string.gsub(ap[5], "s", "")
              local num3 = tonumber(second)
              local num4 = tonumber(num1 + num2 + num3)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not is_momod(result.id_, msg.chat_id_) then
                  local hash = "bot:muted:" .. msg.chat_id_
                  local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                  if database:sismember(hash, result.id_) then
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Muted 📍 ", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓  `تم ✅ كتمــــه 🎐 ", 8, string.len(tp), result.id_)
                    end
                  else
                    database:sadd(hash, result.id_)
                    database:setex(hash2, num4, true)
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Has Been Muted For\n⇛ " .. ap[3] .. " Hours and " .. ap[4] .. " Minutes and\n " .. ap[5] .. " Seconds ❗️", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو " .. te .. "تم ✔ كتمه لغايه\n " .. ap[3] .. " ساعه و " .. ap[4] .. " دقیقه و \n" .. ap[5] .. " ثانيه u", 8, string.len(tp), result.id_)
                    end
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢ لا يوجد مستخدم 📍 ",  1, "md")
              end
            end
            getUser(msg.content_.entities_[0].user_id_, mute_by_mention_Time)
          end
        end
      else
      end
      if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
        local text = msg.content_.text_:gsub("الغاء كتم", "Unmuteuser")
        if text:match("^[Uu]nmuteuser (.*)$") and check_user_channel(msg) then
          local unmute_by_mention = function(extra, result)
            local hash = "bot:muted:" .. msg.chat_id_
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Not Muted 🚀 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓ `تم ✅ الغاء كتمه🎈` ", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Not Muted 🚀 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو " .. te .. "\n\n◾️↓ تم ✅ الغاء كتمه🎈 ", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, unmute_by_mention)
        end
      end
      if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") then
        text = msg.content_.text_:gsub("رفع المدير", "Setowner")
        if text:match("^[Ss]etowner (.*)$") then
          local setowner_by_mention = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:owners:" .. msg.chat_id_
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Owner 📍 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✅ رفعــه مدير🎋 ", 8, string.len(tp), result.id_)
                end
              else
                database:sadd(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Owner 📍 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✅ رفعــه مدير🎋", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, setowner_by_mention)
        end
      end
      if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") then
        local text = text:gsub("تنزل مدير", "Demowner")
        if text:match("^[Dd]emowner (.*)$") and check_user_channel(msg) then
          local hash = "bot:owners:" .. msg.chat_id_
          local remowner_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:owners:" .. msg.chat_id_
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Removed From Owner 🚀 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  : " .. te .. "\n\n🔖↓  تم تنزيله من الاداره🎋 ", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Removed From Owner 🚀 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  : " .. te .. "\n\n🔖↓  تم تنزيله من الاداره 🎋",  8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, remowner_by_id)
        end
      end
      if is_leader(msg) then
        local text = text:gsub("رفع مطور", "Setsudo")
        if text:match("^[Ss]etsudo (.*)$") then
          local promoteSudo_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "Bot:SudoUsers"
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Sudo 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓  تم ✔ رفعه مطور🎈 ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Sudo 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓  تم ✔ رفعه مطور`🎈", 8, string.len(tp), result.id_)
                end
                table.insert(_config.Sudo_Users, tonumber(result.id_))
                save_on_config()
                load_config()

              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, promoteSudo_by_id)
        end
      end
      if is_leader(msg) then
        local text = text:gsub("تنزيل مطور", "RemSudo")
        if text:match("^[Rr]emsudo (.*)$") then
          local demoteSudo_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local k = tonumber(result.id_)
              local hash = "Bot:SudoUsers"
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Sudo 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✔ تنزيل المطور🎐 ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Sudo 🎈", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✔ تنزيل المطور🎐  ", 8, string.len(tp), result.id_)
                end
                table.remove(_config.Sudo_Users, getindex(_config.Sudo_Users, k))
                save_on_config()
                load_config()

              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ",  1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, demoteSudo_by_id)
        end
      end
      if is_leader(msg) then
        local text = text:gsub("اضف ادمن", "Addadmin")
        if text:match("^[Ss]etadmin (.*)$") then
          local addadmin_by_mention = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "Bot:Admins"
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Already Bot Admin 🎈", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم اضافه ادمن في البوت🎏", 8, string.len(tp), result.id_)
                end
              else
                database:sadd(hash, result.id_)

                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Already Bot Admin 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم اضافه ادمن في البوت🎏 ", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, addadmin_by_mention)
        end
      end
      if is_leader(msg) then
        local text = text:gsub("حذف ادمن", "Remadmin")
        if text:match("^[Rr]emadmin (.*)$") then
          local remadmin_by_mention = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "Bot:Admins"
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Bot Admin 🎈", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓  تم حذف الادمن🎈",  8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)

                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Bot Admin 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓   العضو  " .. te .. "\n\n🔖↓  تم حذف الادمن🎈 ",  8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, remadmin_by_mention)
        end
      end
      if is_sudo(msg) then
        local text = text:gsub("معلومات المطور", "Data")
        if text:match("^[Dd]ata (.*)") then
          local get_datas = function(extra, result)
            if result.id_ then
              if is_admin(result.id_) then
                local hash = "sudo:data:" .. result.id_
                local list = database:smembers(hash)
                local fname = result.first_name_ or ""
                local lname = result.last_name_ or ""
                local name = fname .. " " .. lname or "---"
                local susername = "@" .. result.username_ or ""
                local text = " ✪↓  الاسم  : " .. name .. "\n✪↓ المعرف : " .. susername .. "\n\nالمجموعات التي ضافها :\n\n"
                for k, v in pairs(list) do
                  local gp_info = database:get("group:Name" .. v)
                  local chatname = gp_info
                  if chatname then
                    text = text .. k .. " - " .. chatname .. " [" .. v .. "]\n"
                  else
                    text = text .. k .. " - [" .. v .. "]\n"
                  end
                end
                if #list == 0 then
                  text = ""
                end
                send_large_msg(msg.chat_id_, msg.id_, 1, text, 1, "html")
              else
                send(msg.chat_id_, msg.id_, 1, "➢ * لا يوجد مستخدم* 📍 ", 1, "html")
              end
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "html")
            end
          end
          getUser(msg.content_.entities_[0].user_id_, get_datas)
        end
      end
    elseif msg_type == "MSG:Document" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "◯↲  Your Message Was *Forwarded* to\n `" .. gps .. "` Groups 🎈", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "◯↲ تم توجيه رسالتك الى\n` " .. gps .. "` مجموعــه🎈 ", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Document]")
        end
        if database:get("bot:document:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Document]")
        end
        if msg.content_.caption_ then
          check_filter_words(msg, msg.content_.caption_)
          if database:get("bot:links:mute" .. msg.chat_id_) and (msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]")) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Link] [Document]")
            if database:get("bot:strict" .. msg.chat_id_) then
              chat_kick(msg.chat_id_, msg.sender_user_id_)
            end
          end
          if msg.content_.caption_:match("@") then
            if database:get("tags:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Tag] [Document]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMention" and database:get("tags:lock" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Tag] [Document]")
          end
          if msg.content_.caption_:match("#") then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Hashtag] [Document]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityHashtag" and database:get("bot:hashtag:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Hashtag] [Document]")
          end
          if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]:[//]") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]:[//]") or msg.content_.caption_:match("[Ww][Ww][Ww]") or msg.content_.caption_:match(".[Cc][Oo]") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Web] [Document]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Web] [Document]")
          end
          if msg.content_.web_page_ and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
          end
          if msg.content_.caption_:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Farsi] [Document]")
          end
          if (msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]")) and database:get("bot:english:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [English] [Document]")
          end
        end
      end
    elseif msg_type == "MSG:Inline" then
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Inline]")
        end
        if database:get("bot:inline:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Inline]")
        end
      end
    elseif msg_type == "MSG:Sticker" then
      local DownSticker = function(extra, result)
        if result.content_.sticker_.sticker_.id_ then
          local sticker_id = result.content_.sticker_.sticker_.id_
          downloadFile(sticker_id, dl_cb)
        end
      end
      if database:get("clerk") == "On" or is_admin(msg.sender_user_id_) then
        getMessage(msg.chat_id_, msg.id_, DownSticker)
      end
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "◯↲  Your Message Was *Forwarded* to\n `" .. gps .. "` Groups 🎈 ", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "◯↲ تم توجيه رسالتك الى\n` " .. gps .. "` مجموعــه🎈 ",   1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Sticker]")
        end
        if database:get("bot:sticker:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Sticker]")
        end
      end
    elseif msg_type == "MSG:NewUserByLink" then
      if database:get("bot:tgservice:mute" .. msg.chat_id_) then
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        local chat = msg.chat_id_
        delete_msg(chat, msgs)
        print_del_msg("Deleted Because [Lock] [Tgservice] [JoinByLink]")
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) and database:get("bot:member:lock" .. msg.chat_id_) then
        chat_kick(msg.chat_id_, msg.sender_user_id_)
      end
    elseif msg_type == "MSG:DeleteMember" then
      if database:get("bot:tgservice:mute" .. msg.chat_id_) then
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        local chat = msg.chat_id_
        delete_msg(chat, msgs)
        print_del_msg("Deleted Because [Lock] [Tgservice] [DeleteMember]")
      end
    elseif msg_type == "MSG:NewUserAdd" then
      if database:get("bot:tgservice:mute" .. msg.chat_id_) then
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        local chat = msg.chat_id_
        delete_msg(chat, msgs)
        print_del_msg("Deleted Because [Lock] [Tgservice] [NewUserAdd]")
      end
      if not is_momod(msg.sender_user_id_, msg.chat_id_) then
        local list = msg.content_.members_
        for i = 0, #list do
          if list[i].type_.ID == "UserTypeBot" and not is_momod(list[i].id_, msg.chat_id_) and database:get("bot:bots:mute" .. msg.chat_id_) then
            chat_kick(msg.chat_id_, list[i].id_)
          end
        end
      end
      if database:get("bot:member:lock" .. msg.chat_id_) and not is_vipmem(msg.content_.members_[0].id_, msg.chat_id_) and not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        chat_kick(msg.chat_id_, msg.content_.members_[0].id_)
      end
      if is_bot(msg.content_.members_[0].id_) and not is_admin(msg.sender_user_id_) then
        chat_leave(msg.chat_id_, bot_id)
      end
      if is_banned(msg.content_.members_[0].id_, msg.chat_id_) then
        chat_kick(msg.chat_id_, msg.content_.members_[0].id_)
      end
    elseif msg_type == "MSG:Contact" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "◯↲  Your Message Was *Forwarded* to\n `" .. gps .. "` Groups 🎈 ", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "◯↲ تم توجيه رسالتك الى\n` " .. gps .. "` مجموعــه🎈 ", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if database:get("getphone:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local first = msg.content_.contact_.first_name_ or "-"
        local last = msg.content_.contact_.last_name_ or ""
        local phone = msg.content_.contact_.phone_number_
        local id = msg.content_.contact_.user_id_
        add_contact(phone, first, last, id)
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "✺⇓ Your *Phone Number* Has Been Saved ⚜️", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "✺⇓  تم ✅ حفظ الرقم بنجاح🎈", 1, "md")
        end
        database:del("getphone:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Contact]")
        end
        if database:get("bot:contact:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Contact]")
        end
      end
    elseif msg_type == "MSG:Audio" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "◯↲  Your Message Was *Forwarded* to\n `" .. gps .. "` Groups 🎈 ", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "◯↲ تم توجيه رسالتك الى\n` " .. gps .. "` مجموعــه🎈 ", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Audio]")
        end
        if database:get("bot:music:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Audio]")
        end
        if msg.content_.caption_ then
          check_filter_words(msg, msg.content_.caption_)
          if database:get("bot:links:mute" .. msg.chat_id_) and (msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]")) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Link] [Audio]")
          end
          if msg.content_.caption_:match("@") then
            if database:get("tags:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Tag] [Audio]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMention" and database:get("tags:lock" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Tag] [Audio]")
          end
          if msg.content_.caption_:match("#") then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Hashtag] [Audio]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityHashtag" and database:get("bot:hashtag:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Hashtag] [Audio]")
          end
          if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]:[//]") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]:[//]") or msg.content_.caption_:match("[Ww][Ww][Ww]") or msg.content_.caption_:match(".[Cc][Oo]") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Web] [Audio]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Web] [Audio]")
          end
          if msg.content_.web_page_ and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
          end
          if msg.content_.caption_:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Farsi] [Audio]")
          end
          if (msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]")) and database:get("bot:english:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [English] [Audio]")
          end
        end
      end
    elseif msg_type == "MSG:Voice" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "◯↲  Your Message Was *Forwarded* to\n `" .. gps .. "` Groups 🎈 ", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "◯↲ تم توجيه رسالتك الى\n` " .. gps .. "` مجموعــه🎈 ", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Voice]")
        end
        if database:get("bot:voice:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Voice]")
        end
        if msg.content_.caption_ then
          check_filter_words(msg, msg.content_.caption_)
          if database:get("bot:links:mute" .. msg.chat_id_) and (msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]")) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Link] [Voice]")
          end
          if msg.content_.caption_:match("@") then
            if database:get("tags:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Tag] [Voice]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMention" and database:get("tags:lock" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Tag] [Voice]")
          end
          if msg.content_.caption_:match("#") then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Hashtag] [Voice]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityHashtag" and database:get("bot:hashtag:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Hashtag] [Voice]")
          end
          if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]:[//]") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]:[//]") or msg.content_.caption_:match("[Ww][Ww][Ww]") or msg.content_.caption_:match(".[Cc][Oo]") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Web] [Voice]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Web] [Voice]")
          end
          if msg.content_.web_page_ and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
          end
          if msg.content_.caption_:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Farsi] [Voice]")
          end
          if (msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]")) and database:get("bot:english:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [English] [Voice]")
          end
        end
      end
    elseif msg_type == "MSG:Location" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "◯↲  Your Message Was *Forwarded* to\n `" .. gps .. "` Groups 🎈 ", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "◯↲ تم توجيه رسالتك الى\n` " .. gps .. "` مجموعــه🎈 ", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Location]")
        end
        if database:get("bot:location:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Location]")
        end
        if msg.content_.caption_ then
          check_filter_words(msg, msg.content_.caption_)
          if database:get("bot:links:mute" .. msg.chat_id_) and (msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]")) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Link] [Location]")
          end
          if msg.content_.caption_:match("@") then
            if database:get("tags:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Tag] [Location]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMention" and database:get("tags:lock" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Tag] [Location]")
          end
          if msg.content_.caption_:match("#") then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Hashtag] [Location]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityHashtag" and database:get("bot:hashtag:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Hashtag] [Location]")
          end
          if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]:[//]") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]:[//]") or msg.content_.caption_:match("[Ww][Ww][Ww]") or msg.content_.caption_:match(".[Cc][Oo]") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Web] [Location]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Web] [Location]")
          end
          if msg.content_.web_page_ and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
          end
          if msg.content_.caption_:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Farsi] [Location]")
          end
          if (msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]")) and database:get("bot:english:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [English] [Location]")
          end
        end
      end
    elseif msg_type == "MSG:Video" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "◯↲  Your Message Was *Forwarded* to\n `" .. gps .. "` Groups 🎈 ", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "◯↲ تم توجيه رسالتك الى\n` " .. gps .. "` مجموعــه🎈 ", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Video]")
        end
        if database:get("bot:video:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Video]")
        end
        if msg.content_.caption_ then
          check_filter_words(msg, msg.content_.caption_)
          if database:get("bot:links:mute" .. msg.chat_id_) and (msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]")) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Link] [Video]")
          end
          if msg.content_.caption_:match("@") then
            if database:get("tags:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Tag] [Video]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMention" and database:get("tags:lock" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Tag] [Video]")
          end
          if msg.content_.caption_:match("#") then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Hashtag] [Video]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityHashtag" and database:get("bot:hashtag:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Hashtag] [Video]")
          end
          if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]:[//]") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]:[//]") or msg.content_.caption_:match("[Ww][Ww][Ww]") or msg.content_.caption_:match(".[Cc][Oo]") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Web] [Video]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Web] [Video]")
          end
          if msg.content_.web_page_ and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
          end
          if msg.content_.caption_:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Farsi] [Video] ")
          end
          if (msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]")) and database:get("bot:english:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [English] [Video]")
          end
        end
      end
    elseif msg_type == "MSG:SelfVideo" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "◯↲  Your Message Was *Forwarded* to\n `" .. gps .. "` Groups 🎈 ", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "◯↲ تم توجيه رسالتك الى\n` " .. gps .. "` مجموعــه🎈 ", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Self Video]")
        end
        if database:get("bot:selfvideo:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Self Video]")
        end
        if msg.content_.caption_ then
          check_filter_words(msg, msg.content_.caption_)
          if database:get("bot:links:mute" .. msg.chat_id_) and (msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]")) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Link] [Self Video]")
          end
          if msg.content_.caption_:match("@") then
            if database:get("tags:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Tag] [Self Video]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMention" and database:get("tags:lock" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Tag] [Self Video]")
          end
          if msg.content_.caption_:match("#") then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Hashtag] [Self Video]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityHashtag" and database:get("bot:hashtag:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Hashtag] [Self Video]")
          end
          if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]:[//]") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]:[//]") or msg.content_.caption_:match("[Ww][Ww][Ww]") or msg.content_.caption_:match(".[Cc][Oo]") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Web] [Self Video]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Web] [Self Video]")
          end
          if msg.content_.web_page_ and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
          end
          if msg.content_.caption_:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Farsi] [Self Video] ")
          end
          if (msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]")) and database:get("bot:english:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [English] [Self Video]")
          end
        end
      end
    elseif msg_type == "MSG:Gif" then
      if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
        local gps = database:scard("bot:groups") or 0
        local gpss = database:smembers("bot:groups") or 0
        local id = msg.id_
        local msgs = {
          [0] = id
        }
        for i = 1, #gpss do
          Forward(gpss[i], msg.chat_id_, msgs)
        end
        if database:get("lang:gp:" .. msg.chat_id_) then
          send(msg.chat_id_, msg.id_, 1, "◯↲  Your Message Was *Forwarded* to\n `" .. gps .. "` Groups 🎈 ", 1, "md")
        else
          send(msg.chat_id_, msg.id_, 1, "◯↲ تم توجيه رسالتك الى\n` " .. gps .. "` مجموعــه🎈 ", 1, "md")
        end
        database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
      end
      if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
        if database:get("anti-flood:" .. msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if msg.content_.caption_ then
          if msg.content_.caption_:match("@") or msg.content_.caption_:match("#") then
            if string.len(msg.content_.caption_) > senspost.cappostwithtag then
              local post = msg.content_.caption_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.caption_) > senspost.cappost then
            local post = msg.content_.caption_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
        end
        if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Fwd] [Gif]")
        end
        if database:get("bot:gifs:mute" .. msg.chat_id_) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
          print_del_msg("Deleted Because [Lock] [Gif]")
        end
        if msg.content_.caption_ then
          check_filter_words(msg, msg.content_.caption_)
          if database:get("bot:links:mute" .. msg.chat_id_) and (msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://")) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Link] [Gif] ")
          end
          if msg.content_.caption_:match("@") then
            if database:get("tags:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Tag] [Gif]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMention" and database:get("tags:lock" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Tag] [Gif]")
          end
          if msg.content_.caption_:match("#") then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Hashtag] [Gif]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityHashtag" and database:get("bot:hashtag:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Hashtag] [Gif]")
          end
          if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]:[//]") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]:[//]") or msg.content_.caption_:match("[Ww][Ww][Ww]") or msg.content_.caption_:match(".[Cc][Oo]") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Web] [Gif]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Web] [Gif]")
          end
          if msg.content_.web_page_ and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
          end
          if msg.content_.caption_:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Farsi] [Gif]")
          end
          if (msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]")) and database:get("bot:english:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [English] [Gif]")
          end
        end
      end
    else
      if msg_type == "MSG:Text" then
        database:setex("bot:editid" .. msg.id_, day, msg.content_.text_)
        if database:get("anti-flood:" .. msg.chat_id_) and not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
          database:setex(pm, TIME_CHECK, msgs + 1)
        end
        if database:get("Filtering:" .. msg.sender_user_id_) then
          local chat = database:get("Filtering:" .. msg.sender_user_id_)
          local name = string.sub(msg.content_.text_, 1, 50)
          local hash = "bot:filters:" .. chat
          if msg.content_.text_:match("^الغاء$") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "⚜️ The *Operation* is Over ⚜️", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "🔰- <code>تم الغاء الامر بنجاح🎈 </code>", 1, "html")
            end
            database:del("Filtering:" .. msg.sender_user_id_, 80, chat)
          elseif msg.content_.text_:match("^/[Cc]ancel$") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "⚜️ *Operation* Canceled ⚜️", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "تم الغاء الامر🏌️", 1, "md")
            end
            database:del("Filtering:" .. msg.sender_user_id_, 80, chat)
          elseif filter_ok(name) then
            database:hset(hash, name, "newword")
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "● ◄  Word `[" .. name .. [[
]` has been *Filtered* 🎈
If You No Longer Want To Filter a Word, Send The /done Command !]], 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "● ◄  الكلمه <code>( [ " .. name .. " ] )</code> تم منعها \n\n- للخروج من الامر ارسل\n <b> الغاء</b>  🎈",  1, "html")
            end
            database:setex("Filtering:" .. msg.sender_user_id_, 80, chat)
          else
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "● ◄   Word `[" .. name .. "]` Can Not *Filtering* 🎈", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "● ◄  الكلمه  [ " .. name .. " ] لا استطيع منعها🎋", 1, "md")
            end
            database:setex("Filtering:" .. msg.sender_user_id_, 80, chat)
            return
          end
        end
        if database:get("bot:group:link" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) and (msg.content_.text_:match("(https://telegram.me/joinchat/%S+)") or msg.content_.text_:match("(https://t.me/joinchat/%S+)")) then
          local glink = msg.content_.text_:match("(https://telegram.me/joinchat/%S+)") or msg.content_.text_:match("(https://t.me/joinchat/%S+)")
          local hash = "bot:group:link" .. msg.chat_id_
          database:set(hash, glink)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "▫️↓  *Group link* has been *Saved* ⚜️", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "▫️↓<b> تـــم ✅ حفــــظ الرابط </b>🎈", 1, "html")
          end
          database:del("bot:group:link" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
        end
        if database:get("bot:support:link" .. msg.sender_user_id_) then
          if msg.content_.text_:match("(https://telegram.me/joinchat/%S+)") or msg.content_.text_:match("(https://t.me/joinchat/%S+)") then
            local glink = msg.content_.text_:match("(https://telegram.me/joinchat/%S+)") or msg.content_.text_:match("(https://t.me/joinchat/%S+)")
            local hash = "bot:supports:link"
            database:set(hash, glink)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "▫️↓  *Support link has been Saved* 🎋", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "▫️↓  تم حفظ رابط الدعم بنجاح🎋", 1, "md")
            end
            database:del("bot:support:link" .. msg.sender_user_id_)
          elseif msg.content_.text_:match("^@(.*)[Bb][Oo][Tt]$") or msg.content_.text_:match("^@(.*)_[Bb][Oo][Tt]$") then
            local bID = msg.content_.text_:match("@(.*)")
            local hash = "bot:supports:link"
            database:set(hash, bID)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "▫️↓  *Support Bot ID has been Saved* 🎋", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "▫️↓  تم حفظ ايدي بوت الدعم⚜️", 1, "md")
            end
            database:del("bot:support:link" .. msg.sender_user_id_)
          end
        end
        if database:get("gettextsec" .. msg.sender_user_id_) then
          local clerktext = msg.content_.text_
          database:set("textsec", clerktext)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "▫️↓  *Clerk Text* has been *Saved* ⚜️", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "▫️↓  تم حفظ الكليشه🎈", 1, "md")
          end
          database:del("gettextsec" .. msg.sender_user_id_)
        end
        if database:get("rules" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
          local rules = msg.content_.text_
          database:set("bot:rules" .. msg.chat_id_, rules)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "▫️↓  * Group Rules has been Saved* 🎋", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "▫️↓  تـــم حفــــظ القوانين 🎋",  1, "md")
          end
          database:del("rules" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
        end
        if database:get("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
          if text:match("^/[Cc]ancel$") or text:match("^الغاء$") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, " ✪↓ The *Operation* Was Canceled ⚜️", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "🔰- <code>تم الغاء الامر بنجاح🎈 </code>", 1, "html")
            end
            database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
          else
            local gps = database:scard("bot:groups") or 0
            local gpss = database:smembers("bot:groups") or 0
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            for i = 1, #gpss do
              Forward(gpss[i], msg.chat_id_, msgs)
            end
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "◯↲  Your Message Was *Forwarded* to\n `" .. gps .. "` Groups 🎈 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "◯↲ تم توجيه رسالتك الى\n` " .. gps .. "` مجموعــه🎈 ", 1, "md")
            end
            database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
          end
        end
        if database:get("broadcast2" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
          if text:match("^/[Cc]ancel$") or text:match("^الغاء$") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "✪↓  The *Operation* Was Canceled 🏌️", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "🔰- <code>تم الغاء الامر بنجاح🎈 </code>", 1, "html")
            end
            database:del("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
          else
            local gps = database:scard("bot:groups") or 0
            local gpss = database:smembers("bot:groups") or 0
            local msgs = {
              [0] = id
            }
            for i = 1, #gpss do
              send(gpss[i], 0, 1, text, 1, "md")
            end
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "◯↲  Your Message Was *Sent* to\n `" .. gps .. "` Groups 🎈", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "◯↲ تم نشر رسالتك  في\n` " .. gps .. "` مجموعــه🎈  ", 1, "md")
            end
            database:del("broadcast2" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
          end
        end
        if database:get("bot:feedback" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) and is_momod(msg.sender_user_id_, msg.chat_id_) then
          local feedback = function(extra, result)
            if msg.content_.text_:match("^0$") then
              database:del("bot:feedback" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "- The *Operation* was Canceled 🏌️", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "تم الغاء الامر بنجاح🎈 ", 1, "md")
              end
            else
              local pmfeedback = msg.content_.text_:match("(.*)")
              local fname = result.first_name_ or ""
              if result.last_name_ then
                lname = result.last_name_
              else
                lname = ""
              end
              if result.username_ then
                username = "@" .. result.username_
              else
                username = "لا يوجد"
              end
              local link = database:get("bot:group:link" .. msg.chat_id_)
              if link then
                linkgp = database:get("bot:group:link" .. msg.chat_id_)
              else
                linkgp = "لا يوجد"
              end
              local texti = "◀تم تلقي طلب دعم \n\n¤ ايدي العضو  : " .. msg.sender_user_id_ .. "\n¤ اسم العضو : " .. fname .. " " .. lname .. "\n¤ معرفه : " .. username .. "\n¤ ايدي المجموعه : " .. msg.chat_id_ .. "\n¤ اسم المجموعه : " .. (chat and chat.title_ or "---") .. "\n- رابط المجموعه :" .. linkgp .. "\n\n\n- تم استلام الرساله :\n\n" .. pmfeedback .. "\n\n- للانضمام استخدم الامر التالي :\n\n••  join" .. msg.chat_id_
              database:del("bot:feedback" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
              send(bot_owner, 0, 1, texti, 1, "html")
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "✸- Your *Message* was Sent to *Support* 🎈", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "✱ تم ارسال رسالتك الى مدير الدعم ✞", 1, "md")
              end
            end
          end
          getUser(msg.sender_user_id_, feedback)
        end
        if is_sudo(msg) and database:get("bot:payping") and (msg.content_.text_:match("([Hh][Tt][Tt][Pp][Ss]://[Ww][Ww][Ww].[Pp][Aa][Yy][Pp][Ii][Nn][Gg].[Ii][Rr]/%S+)") or msg.content_.text_:match("([Hh][Tt][Tt][Pp]://[Ww][Ww][Ww].[PP][Aa][Yy][Pp][Ii][Nn][Gg].[Ii][Rr]/%S+)")) then
          local paylink = msg.content_.text_:match("([Hh][Tt][Tt][Pp]://[Ww][Ww][Ww].[Pp][Aa][Yy][Pp][Ii][Nn][Gg].[Ii][Rr]/%S+)") or msg.content_.text_:match("([Hh][Tt][Tt][Pp][Ss]://[Ww][Ww][Ww].[Pp][Aa][Yy][Pp][Ii][Nn][Gg].[Ii][Rr]/%S+)")
          local hash = "bot:payping:owner"
          database:del("bot:payping")
          database:set(hash, paylink)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "", 1, "md")
          end
        end
        if is_sudo(msg) and database:get("bot:zarinpal") and (msg.content_.text_:match("([Hh][Tt][Tt][Pp][Ss]://[Zz][Aa][Rr][Ii][Nn][Pp].[Aa][Ll]/%S+)") or msg.content_.text_:match("([Zz][aA][rR][iI][nN][pP].[aA][lL]/%S+)") or msg.content_.text_:match("([Hh][Tt][Tt][Pp]://[Zz][Aa][Rr][Ii][Nn][Pp].[Aa][Ll]/%S+)")) then
          local paylink = msg.content_.text_:match("(http://[Zz][Aa][Rr][Ii][Nn][Pp].[Aa][Ll]/%S+)") or msg.content_.text_:match("([Zz][Aa][Rr][Ii][Nn][Pp].[Aa][Ll]/%S+)") or msg.content_.text_:match("(https://[Zz][Aa][Rr][Ii][Nn][Pp].[Aa][Ll]/%S+)")
          local hash = "bot:zarinpal:owner"
          database:del("bot:zarinpal")
          database:set(hash, paylink)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "", 1, "md")
          end
        end
        if database:get("bot:joinbylink:" .. msg.sender_user_id_) and (msg.content_.text_:match("(https://telegram.me/joinchat/%S+)") or msg.content_.text_:match("(https://t.me/joinchat/%S+)")) then
        else
        end
        if database:get("Getmenu" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) and msg.content_.text_:match("^(-%d+)$") then
          local chat = msg.content_.text_:match("(-%d+)")
          local BotApi = tonumber(database:get("Bot:Api_ID"))
          if database:get("lang:gp:" .. msg.chat_id_) then
            ln = "En"
          else
            ln = "ar"
          end
          local getmenu = function(extra, result)
            if result.inline_query_id_ then
              tdcli_function({
                ID = "SendInlineQueryResultMessage",
                chat_id_ = msg.chat_id_,
                reply_to_message_id_ = msg.id_,
                disable_notification_ = 0,
                from_background_ = 1,
                query_id_ = result.inline_query_id_,
                result_id_ = result.results_[0].id_
              }, dl_cb, nil)
              database:setex("ReqMenu:" .. msg.sender_user_id_, 130, true)
            elseif not database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "✸↓  توجد مشكله في Api  🎈", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "✸↓ Technical *Problem* In Bot Api 🎈", 1, "md")
            end
          end
          tdcli_function({
            ID = "GetInlineQueryResults",
            bot_user_id_ = BotApi,
            chat_id_ = msg.chat_id_,
            user_location_ = {
              ID = "Location",
              latitude_ = 0,
              longitude_ = 0
            },
            query_ = chat .. "," .. ln,
            offset_ = 0
          }, getmenu, nil)
          database:del("Getmenu" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
        end
        if database:get("bot:getuser:" .. msg.sender_user_id_) then
          local check_msg = function(extra, result)
            if msg.forward_info_.ID == "MessageForwardedFromUser" then
              local userfwd = tostring(result.forward_info_.sender_user_id_)
              if userfwd:match("%d+") then
                local Check_GetUser = function(extra, result)
                  if result.id_ then
                    fnamef = result.first_name_ or "---"
                    lnamef = result.last_name_ or ""
                    namef = fnamef .. " " .. lnamef
                    usernamef = "@" .. result.username_ or "---"
                    phonenumberf = "+" .. result.phone_number_ or "---"
                    useridf = result.id_ or ""
                    fnamee = result.first_name_ or "Not Found"
                    lnamee = result.last_name_ or ""
                    namee = fnamee .. " " .. lnamee
                    usernamee = "@" .. result.username_ or "Not Found"
                    phonenumbere = "+" .. result.phone_number_ or "Not Found"
                    useride = result.id_ or ""
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      send(msg.chat_id_, msg.id_, 1, "• <b>Name</b> : <b>" .. namee .. [[
</b>
> <b>Username</b> : ]] .. usernamee .. [[

> <b>ID</b> : <code>]] .. useride .. [[
</code>
> <b>Phone Number</b> : ]] .. phonenumbere, 1, "html")
                    else
                      send(msg.chat_id_, msg.id_, 1, "⚜️ الاسم: " .. namef .. "\n⚜️ المعرف : " .. usernamef .. "\n⚜️ الايدي : " .. useridf .. "\n- الرقم : " .. phonenumberf, 1, "html")
                    end
                    database:del("bot:getuser:" .. msg.sender_user_id_)
                  else
                    database:del("bot:getuser:" .. msg.sender_user_id_)
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      send(msg.chat_id_, msg.id_, 1, "⚜️  I Can Not Give <b>Information</b> \n Of This User ❗️", 1, "html")
                    else
                      send(msg.chat_id_, msg.id_, 1, "⚜️ لا استطيع اعطائك معلومات عن العضو؟❗️",  1, "html")
                    end
                  end
                end
                getUser(result.forward_info_.sender_user_id_, Check_GetUser)
              end
            end
          end
          getMessage(msg.chat_id_, msg.id_, check_msg)
        end
        if database:get("bot:nerkh" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
          database:del("bot:nerkh" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
          local nerkh = msg.content_.text_:match("(.*)")
          database:set("nerkh", nerkh)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "⇨ Bot *sudo* has been *Setted* ✞", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "⚜️- <b>تم وضــع كليشه المطور.</b>", 1, "html")
          end
        end
        if not is_vipmem(msg.sender_user_id_, msg.chat_id_) then
          check_filter_words(msg, text)
          if msg.content_.text_:match("@") or msg.content_.text_:match("#") then
            if string.len(msg.content_.text_) > senspost.textpostwithtag then
              local post = msg.content_.text_
              if database:get("bot:duplipost:mute" .. msg.chat_id_) then
                if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                  local id = msg.id_
                  local msgs = {
                    [0] = id
                  }
                  local chat = msg.chat_id_
                  delete_msg(chat, msgs)
                  print_del_msg("Deleted Because [Duplicate] [Post]")
                else
                  database:sadd("Gp:Post" .. msg.chat_id_, post)
                end
              end
              if database:get("post:lock" .. msg.chat_id_) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Lock] [Post]")
              end
            end
          elseif string.len(msg.content_.text_) > senspost.textpostwithtag then
            local post = msg.content_.text_
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:sismember("Gp:Post" .. msg.chat_id_, post) then
                local id = msg.id_
                local msgs = {
                  [0] = id
                }
                local chat = msg.chat_id_
                delete_msg(chat, msgs)
                print_del_msg("Deleted Because [Duplicate] [Post]")
              else
                database:sadd("Gp:Post" .. msg.chat_id_, post)
              end
            end
            if database:get("post:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Post]")
            end
          end
          if msg.forward_info_ and database:get("bot:forward:mute" .. msg.chat_id_) and (msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost") then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Fwd] [Text]")
          end
          if (text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]")) and database:get("bot:links:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Link] [Text]")
            if database:get("bot:strict" .. msg.chat_id_) then
              chat_kick(msg.chat_id_, msg.sender_user_id_)
            end
          end
          if database:get("bot:text:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Text]")
          end
          if msg.content_.text_:match("@") then
            if database:get("tags:lock" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Tag] [Text]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityMention" and database:get("tags:lock" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Tag] [Text]")
          end
          if msg.content_.text_:match("#") then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Hashtag] [Text]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityHashtag" and database:get("bot:hashtag:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Hashtag] [Text]")
          end
          if msg.content_.text_:match("[Hh][Tt][Tt][Pp][Ss]:[//]") or msg.content_.text_:match("[Hh][Tt][Tt][Pp]:[//]") or msg.content_.text_:match("[Ww][Ww][Ww]") or msg.content_.text_:match(".[Cc][Oo]") or msg.content_.text_:match(".[Ii][Rr]") or msg.content_.text_:match(".[Oo][Rr][Gg]") then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              local id = msg.id_
              local msgs = {
                [0] = id
              }
              local chat = msg.chat_id_
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Web] [Text]")
            end
          elseif msg.content_.entities_ and msg.content_.entities_[0] and (msg.content_.entities_[0].ID == "MessageEntityTextUrl" or msg.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Web] [Text]")
          end
          if msg.content_.web_page_ and database:get("bot:webpage:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
          end
          if msg.content_.text_:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [Farsi] [Text]")
          end
          if msg.content_.text_ then
            local _nl, ctrl_chars = string.gsub(text, "%c", "")
            local _nl, real_digits = string.gsub(text, "%d", "")
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            local hash = "bot:sens:spam" .. msg.chat_id_
            if not database:get(hash) then
              sens = 400
            else
              sens = tonumber(database:get(hash))
            end
            if database:get("bot:spam:mute" .. msg.chat_id_) and string.len(msg.content_.text_) > sens or ctrl_chars > sens or real_digits > sens then
              delete_msg(chat, msgs)
              print_del_msg("Deleted Because [Lock] [Spam] ")
            end
          end
          if (msg.content_.text_:match("[A-Z]") or msg.content_.text_:match("[a-z]")) and database:get("bot:english:mute" .. msg.chat_id_) then
            local id = msg.id_
            local msgs = {
              [0] = id
            }
            local chat = msg.chat_id_
            delete_msg(chat, msgs)
            print_del_msg("Deleted Because [Lock] [English] [Text]")
          end
        end
        if msg.date_ < os.time() - 10 then
          print("\027[" .. color.white[1] .. ";" .. color.magenta[2] .. "m>>> OLD MSG Pattern <<<\027[00m")
          return false
        end
        if database:get("bot:cmds" .. msg.chat_id_) and not is_momod(msg.sender_user_id_, msg.chat_id_) then
          print("\027[" .. color.white[1] .. ";" .. color.magenta[2] .. "m>>> Lock Cmd Is Active In This Group <<<\027[00m")
          return false
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and (text:match("^[Pp]ing$") or text:match("^اونلاين$")) then
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "⇨ Bot is Now *Online* ✞", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "- البوت اصبح اونلاين✞", 1, "md")
          end
        end
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") and (text:match("^[Ll]eave$") or text:match("^غادر$")) then
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "✺ *Bot Leaves This Group* ✞", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "✺↓ <b>تم مغادره المجموعــه </b>♩†",  1, "html")
          end
          database:srem("bot:groups", msg.chat_id_)
          chat_leave(msg.chat_id_, bot_id)
        end
        local text = msg.content_.text_:gsub("رفع ادمن", "Promote")
        if is_owner(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Pp]romote$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local promote_by_reply_one = function(extra, result)
            local promote_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "bot:momod:" .. msg.chat_id_
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Now Moderator ♩", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓ العضو  " .. te .. "\n\n🔖↓ تم ✅ رفعه ادمن 🎈 ", 8, string.len(tp), result.id_)
                  end
                else
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Moderator ♩", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓ العضو  " .. te .. "\n\n🔖↓ تم ✅ رفعه ادمن 🎈 ", 8, string.len(tp), result.id_)
                  end
                  database:sadd(hash, result.id_)
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(result.sender_user_id_, promote_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, promote_by_reply_one)
        end
        if is_owner(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Pp]romote @(%S+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Pp]romote) @(%S+)$")
          }
          local promote_by_username_one = function(extra, result)
            local promote_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:momod:" .. msg.chat_id_
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Moderator ♩", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓ العضو  " .. te .. "\n\n🔖↓ تم ✅ رفعه ادمن 🎈 ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Moderator ♩ ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓ العضو  " .. te .. "\n\n🔖↓ تم ✅ رفعه ادمن 🎈 ", 8, string.len(tp), result.id_)
                end
                database:sadd(hash, result.id_)
              end
            end
            if result.id_ then
              getUser(result.id_, promote_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          resolve_username(ap[2], promote_by_username_one)
        end
        if is_owner(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Pp]romote (%d+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Pp]romote) (%d+)$")
          }
          local promote_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:momod:" .. msg.chat_id_
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Moderator ♩ ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓ العضو  " .. te .. "\n\n🔖↓ تم ✅ رفعه ادمن 🎈 ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Moderator ♩ ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓ العضو  " .. te .. "\n\n🔖↓ `تم ✅ رفعه ادمن 🎈 ", 8, string.len(tp), result.id_)
                end
                database:sadd(hash, result.id_)
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(ap[2], promote_by_id)
        end
        local text = msg.content_.text_:gsub("تنزيل ادمن", "Demote")
        if is_owner(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Dd]emote$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local demote_by_reply_one = function(extra, result)
            local demote_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "bot:momod:" .. msg.chat_id_
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Moderator 🎈", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم تنزيله من الادمنيه🎈 ", 8, string.len(tp), result.id_)
                  end
                else
                  database:srem(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Moderator 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم تنزيله من الادمنيه🎈 ", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(result.sender_user_id_, demote_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, demote_by_reply_one)
        end
        if is_owner(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Dd]emote @(%S+)$") and check_user_channel(msg) then
          do
            local hash = "bot:momod:" .. msg.chat_id_
            local ap = {
              string.match(text, "^([Dd]emote) @(%S+)$")
            }
            local demote_by_username_one = function(extra, result)
              local demote_by_username = function(extra, result)
                if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                  return false
                end
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Moderator 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم تنزيله من الادمنيه🎈 ", 8, string.len(tp), result.id_)
                  end
                else
                  database:srem(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Moderator 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم تنزيله من الادمنيه🎈 ", 8, string.len(tp), result.id_)
                  end
                end
              end
              if result.id_ then
                getUser(result.id_, demote_by_username)
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ",  1, "md")
              end
            end
            resolve_username(ap[2], demote_by_username_one)
          end
        else
        end
        if is_owner(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Dd]emote (%d+)$") and check_user_channel(msg) then
          local hash = "bot:momod:" .. msg.chat_id_
          local ap = {
            string.match(text, "^([Dd]emote) (%d+)$")
          }
          local demote_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:momod:" .. msg.chat_id_
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Moderator 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم تنزيله من الادمنيه 🎈 ", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Moderator 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم تنزيله من الادمنيه🎈 ", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(ap[2], demote_by_id)
        end
        local text = msg.content_.text_:gsub("رفع عضو مميز", "Setvip")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ss]etvip$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local promotevip_by_reply_one = function(extra, result)
            local promotevip_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "bot:vipmem:" .. msg.chat_id_
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Now VIP Member 🎈", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓ العضو  " .. te .. "\n\n🔖↓ تم رفعه عضو مميز ❗️ ", 8, string.len(tp), result.id_)
                  end
                else
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Now VIP Member 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓ العضو  " .. te .. "\n\n🔖↓ تم رفعه عضو مميز ❗️ ", 8, string.len(tp), result.id_)
                  end
                  database:sadd(hash, result.id_)
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(result.sender_user_id_, promotevip_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, promotevip_by_reply_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ss]etvip @(%S+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Ss]etvip) @(%S+)$")
          }
          local promotevip_by_username_one = function(extra, result)
            local promotevip_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "bot:vipmem:" .. msg.chat_id_
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Now VIP Member 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓ العضو  " .. te .. "\n\n🔖↓ تم رفعه عضو مميز ❗️ ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Now VIP Member 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓ العضو  " .. te .. "\n\n🔖↓ تم رفعه عضو مميز ❗️ ", 8, string.len(tp), result.id_)
                end
                database:sadd(hash, result.id_)
              end
            end
            if result.id_ then
              getUser(result.id_, promotevip_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          resolve_username(ap[2], promotevip_by_username_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ss]etvip (%d+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Ss]etvip) (%d+)$")
          }
          local promotevip_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:vipmem:" .. msg.chat_id_
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Now VIP Member 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓ العضو  " .. te .. "\n\n🔖↓ تم رفعه عضو مميز ❗️ ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Now VIP Member 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓ العضو  " .. te .. "\n\n🔖↓ تم رفعه عضو مميز ❗️ ", 8, string.len(tp), result.id_)
                end
                database:sadd(hash, result.id_)
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(ap[2], promotevip_by_id)
        end
        local text = msg.content_.text_:gsub("تنزيل عضو مميز", "Demvip")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Dd]emvip$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local demotevip_by_reply_one = function(extra, result)
            local demotevip_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "bot:vipmem:" .. msg.chat_id_
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not VIP Member 🎈", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم تنزيله من المميزين🎈 ", 8, string.len(tp), result.id_)
                  end
                else
                  database:srem(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not VIP Member 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم تنزيله من المميزين🎈 ", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(result.sender_user_id_, demotevip_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, demotevip_by_reply_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Dd]emvip @(%S+)$") and check_user_channel(msg) then
          do
            local hash = "bot:vipmem:" .. msg.chat_id_
            local ap = {
              string.match(text, "^([Dd]emvip) @(%S+)$")
            }
            local demotevip_by_username_one = function(extra, result)
              local demotevip_by_username = function(extra, result)
                if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                  return false
                end
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not VIP Member 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم تنزيله من المميزين🎈 ", 8, string.len(tp), result.id_)
                  end
                else
                  database:srem(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not VIP Member 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم تنزيله من المميزين🎈 ", 8, string.len(tp), result.id_)
                  end
                end
              end
              if result.id_ then
                getUser(result.id_, demotevip_by_username)
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            resolve_username(ap[2], demotevip_by_username_one)
          end
        else
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Dd]emvip (%d+)$") and check_user_channel(msg) then
          do
            local hash = "bot:vipmem:" .. msg.chat_id_
            local ap = {
              string.match(text, "^([Dd]emvip) (%d+)$")
            }
            local demotevip_by_id = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not VIP Member 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم تنزيله من المميزين🎈 ", 8, string.len(tp), result.id_)
                  end
                else
                  database:srem(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not VIP Member 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم تنزيله من المميزين🎈 ", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(ap[2], demotevip_by_id)
          end
        else
        end
        if (text:match("^[Gg]p id$") or text:match("^ايدي المجموعه$")) and idf:match("-100(%d+)") then
          if database:get("lang:gp:" .. msg.chat_id_) then
            texts = "⇨ *Group ID* : \n`" .. msg.chat_id_ .. "`"
          else
            texts = "🛃↓- <b>ايــدي المجموعـــه </b>: \n<code>" .. msg.chat_id_ .. "</code>"
          end
          send(msg.chat_id_, msg.id_, 1, texts, 1, "html")
        end
        if text:match("^[Mm]y username$") or text:match("^معرفي$") then
          local get_username = function(extra, result)
            if result.username_ then
              local ust = result.username_
              if database:get("lang:gp:" .. msg.chat_id_) then
                text = "⇨ <b>Your Username</b> : " .. ust
              else
                text = "Ⓜ️↓ <b>معرفـــك</b> : @" .. ust .. " "
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              text = "➢ You <b>have</b> not <b>Username</b> ✞ "
            else
              text = "➢ انت لا تمتلك  معرف ✞"
            end
            send(msg.chat_id_, msg.id_, 1, text, 1, "html")
          end
          getUser(msg.sender_user_id_, get_username)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Dd]el$") or text:match("^حذف$") and msg.reply_to_message_id_ ~= 0) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          delete_msg(msg.chat_id_, {
            [0] = msg.reply_to_message_id_
          })
          delete_msg(msg.chat_id_, msgs)
        end
        local text = msg.content_.text_:gsub("طرد", "Kick")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Kk]ick$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local kick_reply_one = function(extra, result)
            local kick_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not is_momod(result.id_, msg.chat_id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Has Been Kicked ❗️", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓ تم ✅ طرده 📍 ", 8, string.len(tp), result.id_)
                  end
                  chat_kick(msg.chat_id_, result.id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "◾️↓  You *Can not* Ban *Moderators* 📍 ", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "◾️↓  لا يمكنك حضر او طرد او كتم الادمن والمدير 🎈 ", 1, "md")
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(result.sender_user_id_, kick_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, kick_reply_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Kk]ick @(%S+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Kk]ick) @(%S+)$")
          }
          local kick_by_username_one = function(extra, result)
            local kick_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not is_momod(result.id_, msg.chat_id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Has Been Kicked ❗️ ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓ تم ✅ طرده 📍 ", 8, string.len(tp), result.id_)
                end
                chat_kick(msg.chat_id_, result.id_)
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "◾️↓  You *Can not* Ban *Moderators* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "◾️↓  لا يمكنك حضر او طرد او كتم الادمن والمدير 🎈 ", 1, "md")
              end
            end
            if result.id_ then
              getUser(result.id_, kick_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          resolve_username(ap[2], kick_by_username_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Kk]ick (%d+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Kk]ick) (%d+)$")
          }
          local kick_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not is_momod(result.id_, msg.chat_id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Has Been Kicked ❗️ ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓ تم ✅ طرده 📍 ", 8, string.len(tp), result.id_)
                end
                chat_kick(msg.chat_id_, result.id_)
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "◾️↓  You *Can not* Ban *Moderators* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "◾️↓  لا يمكنك حضر او طرد او كتم الادمن والمدير 🎈 ", 1, "md")
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(ap[2], kick_by_id)
        end
        local text = msg.content_.text_:gsub("حظر", "Ban")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Bb]an$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local ban_by_reply_one = function(extra, result)
            local ban_by_reply = function(extra, result)
              local hash = "bot:banned:" .. msg.chat_id_
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not is_momod(result.id_, msg.chat_id_) then
                  if database:sismember(hash, result.id_) then
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Has Been Banned 🎈 ", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "◾️↓ العضو   " .. te .. "\n\n◾️↓ تم ✅ حظره 🎈 ", 8, string.len(tp), result.id_)
                    end
                  else
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Has Been Banned 🎈", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "◾️↓ العضو   " .. te .. "\n\n◾️↓ تم ✅ حظره 🎈 ", 8, string.len(tp), result.id_)
                    end
                    chat_kick(msg.chat_id_, result.id_)
                    database:sadd(hash, result.id_)
                  end
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "▫️↓  You *Can not* Ban *Moderators* 🎈 ", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "◾️↓  لا يمكنك حضر او طرد او كتم الادمن والمدير 🎈 ", 1, "md")
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢ * لا يوجد مستخدم* 📍 ", 1, "md")
              end
            end
            getUser(result.sender_user_id_, ban_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, ban_by_reply_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Bb]an @(%S+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Bb]an) @(%S+)$")
          }
          local ban_by_username_one = function(extra, result)
            local ban_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "bot:banned:" .. msg.chat_id_
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not is_momod(result.id_, msg.chat_id_) then
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Has Been Banned 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓ العضو   " .. te .. "\n\n◾️↓ تم ✅ حظره 🎈 ", 8, string.len(tp), result.id_)
                  end
                else
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Has Been Banned 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓ العضو   " .. te .. "\n\n◾️↓ تم ✅ حظره 🎈 ", 8, string.len(tp), result.id_)
                  end
                  chat_kick(msg.chat_id_, result.id_)
                  database:sadd(hash, result.id_)
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "◾️↓  You *Can not* Ban *Moderators* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "◾️↓  لا يمكنك حضر او طرد او كتم الادمن والمدير 🎈 ", 1, "md")
              end
            end
            if result.id_ then
              getUser(result.id_, ban_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢ * لا يوجد مستخدم* 📍 ",  1, "md")
            end
          end
          resolve_username(ap[2], ban_by_username_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Bb]an (%d+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Bb]an) (%d+)$")
          }
          local ban_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            local hash = "bot:banned:" .. msg.chat_id_
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not is_momod(result.id_, msg.chat_id_) then
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Has Been Banned 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓ العضو   " .. te .. "\n\n◾️↓ تم ✅ حظره🎈 ", 8, string.len(tp), result.id_)
                  end
                else
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Has Been Banned 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓ العضو   " .. te .. "\n\n◾️↓ تم ✅ حظره🎈 ", 8, string.len(tp), result.id_)
                  end
                  chat_kick(msg.chat_id_, result.id_)
                  database:sadd(hash, result.id_)
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "▫️↓  You *Can not* Ban *Moderators* 🎈", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "◾️↓  لا يمكنك حضر او طرد او كتم الادمن والمدير 🎈 ", 1, "md")
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(ap[2], ban_by_id)
        end
        local text = msg.content_.text_:gsub("مسح الكل", "Delall")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Dd]elall$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local delall_by_reply_one = function(extra, result)
            local delall_by_reply = function(extra, result)
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                del_all_msgs(msg.chat_id_, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "✸↓  All Msgs from " .. te .. " Has Been Deleted 🚀 ", 15, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "✸↓ العضو   " .. te .. " \nتم حذف جميع رسائله 🕴️ ",  23, string.len(tp), result.id_)
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(result.sender_user_id_, delall_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, delall_by_reply_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Dd]elall (%d+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Dd]elall) (%d+)$")
          }
          local delall_by_id = function(extra, result)
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              del_all_msgs(msg.chat_id_, result.id_)
              if database:get("lang:gp:" .. msg.chat_id_) then
                sendmen(msg.chat_id_, msg.id_, "✸↓  All Msgs from " .. te .. " Has Been Deleted 🚀 ", 15, string.len(tp), result.id_)
              else
                sendmen(msg.chat_id_, msg.id_, "✸↓ العضو   " .. te .. " \nتم حذف جميع رسائله 🕴️ ", 23, string.len(tp), result.id_)
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(ap[2], delall_by_id)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Dd]elall @(%S+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Dd]elall) @(%S+)$")
          }
          local delall_by_username_one = function(extra, result)
            local delall_by_username = function(extra, result)
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              del_all_msgs(msg.chat_id_, result.id_)
              if database:get("lang:gp:" .. msg.chat_id_) then
                sendmen(msg.chat_id_, msg.id_, "✸↓  All Msgs from " .. te .. " Has Been Deleted 🚀 ", 15, string.len(tp), result.id_)
              else
                sendmen(msg.chat_id_, msg.id_, "✸↓ العضو   " .. te .. " \nتم حذف جميع رسائله 🕴️ ", 23, string.len(tp), result.id_)
              end
            end
            if result.id_ then
              getUser(result.id_, delall_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          resolve_username(ap[2], delall_by_username_one)
        end
        local text = msg.content_.text_:gsub("الغاء حظر", "Unban")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Uu]nban$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local unban_by_reply_one = function(extra, result)
            local unban_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "bot:banned:" .. msg.chat_id_
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Has Been Unbanned 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓ العضو  " .. te .. "\n\n◾️↓ تم ✅ الغاء حظره 🎈 ", 8, string.len(tp), result.id_)
                  end
                else
                  database:srem(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Has Been Unbanned 🎈", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓ العضو  " .. te .. "\n\n◾️↓ تم ✅ الغاء حظره 🎈 ", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(result.sender_user_id_, unban_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, unban_by_reply_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Uu]nban @(%S+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Uu]nban) @(%S+)$")
          }
          local unban_by_username_one = function(extra, result)
            local unban_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "bot:banned:" .. msg.chat_id_
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Has Been Unbanned 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓ العضو  " .. te .. "\n\n◾️↓ تم ✅ الغاء حظره 🎈 ", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Has Been Unbanned 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓ العضو  " .. te .. "\n\n◾️↓ تم ✅ الغاء حظره 🎈 ", 8, string.len(tp), result.id_)
                end
              end
            end
            if result.id_ then
              getUser(result.id_, unban_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          resolve_username(ap[2], unban_by_username_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Uu]nban (%d+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Uu]nban) (%d+)$")
          }
          local unban_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            local hash = "bot:banned:" .. msg.chat_id_
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Has Been Unbanned 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓ العضو  " .. te .. "\n\n◾️↓ تم ✅ الغاء حظره 🎈 ", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Has Been Unbanned 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓ العضو  " .. te .. "\n\n◾️↓ تم ✅ الغاء حظره 🎈 ", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(ap[2], unban_by_id)
        end
        local text = msg.content_.text_:gsub("حظر عام", "Banall")
        if is_sudo(msg) and text:match("^[Bb]anall$") and msg.reply_to_message_id_ ~= 0 then
          local gban_by_reply_one = function(extra, result)
            local gban_by_reply = function(extra, result)
              if result.id_ and (tonumber(result.id_) == tonumber(our_id) or is_admin(result.id_)) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "bot:gban:"
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Globaly Banned 🚀 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓ تم ✅ حظره عام 🎈 ", 8, string.len(tp), result.id_)
                  end
                else
                  database:sadd(hash, result.id_)
                  if tostring(msg.chat_id_):match("-100(%d+)") then
                    chat_kick(msg.chat_id_, result.id_)
                  end
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Globaly Banned 🚀 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓ تم ✅ حظره عام 🎈 ", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(result.sender_user_id_, gban_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, gban_by_reply_one)
        end
        if is_sudo(msg) and text:match("^[Bb]anall @(%S+)$") then
          local aps = {
            string.match(text, "^([Bb]anall) @(%S+)$")
          }
          local gban_by_username_one = function(extra, result)
            local gban_by_username = function(extra, result)
              if result.id_ and (tonumber(result.id_) == tonumber(our_id) or is_admin(result.id_)) then
                return false
              end
              local hash = "bot:gban:"
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Globaly Banned 🚀 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓ تم ✅ حظره عام🎈 ", 8, string.len(tp), result.id_)
                end
              else
                database:sadd(hash, result.id_)
                if tostring(msg.chat_id_):match("-100(%d+)") then
                  chat_kick(msg.chat_id_, result.id_)
                end
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Globaly Banned 🚀 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓ تم ✅ حظره عام 🎈 ", 8, string.len(tp), result.id_)
                end
              end
            end
            if result.id_ then
              getUser(result.id_, gban_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          resolve_username(aps[2], gban_by_username_one)
        end
        if is_sudo(msg) and text:match("^[Bb]anall (%d+)$") then
          local ap = {
            string.match(text, "^([Bb]anall) (%d+)$")
          }
          local hash = "bot:gban:"
          local gban_by_id = function(extra, result)
            if result.id_ and (tonumber(result.id_) == tonumber(our_id) or is_admin(result.id_)) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:gban:"
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Globaly Banned 🚀 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓ تم ✅ حظره عام🎈 ", 8, string.len(tp), result.id_)
                end
              else
                database:sadd(hash, result.id_)
                if tostring(msg.chat_id_):match("-100(%d+)") then
                  chat_kick(msg.chat_id_, result.id_)
                end
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Globaly Banned 🚀 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓ تم ✅ حظره عام🎈 ", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(ap[2], gban_by_id)
        end
        local text = msg.content_.text_:gsub("الغاء العام", "unbanall")
        if is_sudo(msg) and text:match("^[Uu]nbanall$") and msg.reply_to_message_id_ ~= 0 then
          local ungban_by_reply_one = function(extra, result)
            local ungban_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "bot:gban:"
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Not Globaly Banned 🚀 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓   العضو  " .. te .. "\n\n◾️↓  تم ✅ الغاء العام🎈 ", 8, string.len(tp), result.id_)
                  end
                else
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Not Globaly Banned 🚀 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓   العضو  " .. te .. "\n\n◾️↓  تم ✅ الغاء العام🎈 ", 8, string.len(tp), result.id_)
                  end
                  database:srem(hash, result.id_)
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(result.sender_user_id_, ungban_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, ungban_by_reply_one)
        end
        if is_sudo(msg) and text:match("^[Uu]nbanall @(%S+)$") then
          local apid = {
            string.match(text, "^([Uu]nbanall) @(%S+)$")
          }
          local ungban_by_username_one = function(extra, result)
            local ungban_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "bot:gban:"
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Not Globaly Banned 🚀 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓   العضو  " .. te .. "\n\n◾️↓  تم ✅ الغاء العام🎈 ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Not Globaly Banned 🚀 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓   العضو  " .. te .. "\n\n◾️↓  تم ✅ الغاء العام🎈 ", 8, string.len(tp), result.id_)
                end
                database:srem(hash, result.id_)
              end
            end
            if result.id_ then
              getUser(result.id_, ungban_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          resolve_username(apid[2], ungban_by_username_one)
        end
        if is_sudo(msg) and text:match("^[Uu]nbanall (%d+)$") then
          local ap = {
            string.match(text, "^([Uu]nbanall) (%d+)$")
          }
          local hash = "bot:gban:"
          local ungban_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:gban:"
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Not Globaly Banned 🚀 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓   العضو  " .. te .. "\n\n◾️↓  تم ✅ الغاء العام🎈  ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Not Globaly Banned 🚀 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "◾️↓   العضو  " .. te .. "\n\n◾️↓  تم ✅ الغاء العام🎈 ", 8, string.len(tp), result.id_)
                end
                database:srem(hash, result.id_)
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(ap[2], ungban_by_id)
        end
        local text = msg.content_.text_:gsub("كتم", "Muteuser")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Mm]uteuser$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local mute_by_reply_one = function(extra, result)
            local mute_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not is_momod(result.id_, msg.chat_id_) then
                  local hash = "bot:muted:" .. msg.chat_id_
                  local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                  if database:sismember(hash, result.id_) then
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Muted 📍 ", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓  تم ✅ كتمــــه 🎐 ", 8, string.len(tp), result.id_)
                    end
                  else
                    database:sadd(hash, result.id_)
                    database:set(hash2, true)
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Muted 📍 ", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓  تم ✅ كتمــــه 🎐 ", 8, string.len(tp), result.id_)
                    end
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(result.sender_user_id_, mute_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, mute_by_reply_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Mm]uteuser @(%S+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Mm]uteuser) @(%S+)$")
          }
          local mute_by_username_one = function(extra, result)
            local mute_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not is_momod(result.id_, msg.chat_id_) then
                local hash = "bot:muted:" .. msg.chat_id_
                local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Muted 📍 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓  تم ✅ كتمــــه 🎐 ", 8, string.len(tp), result.id_)
                  end
                else
                  database:sadd(hash, result.id_)
                  database:set(hash2, true)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Muted 📍 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓  تم ✅ كتمــــه 🎐 ", 8, string.len(tp), result.id_)
                  end
                end
              end
            end
            if result.id_ then
              getUser(result.id_, mute_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢ * لا يوجد مستخدم* 📍  ", 1, "md")
            end
          end
          resolve_username(ap[2], mute_by_username_one)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Mm]uteuser (%d+)$") and check_user_channel(msg) then
          local ap = {
            string.match(text, "^([Mm]uteuser) (%d+)$")
          }
          local mute_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not is_momod(result.id_, msg.chat_id_) then
                local hash = "bot:muted:" .. msg.chat_id_
                local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Muted 📍 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓  تم ✅ كتمــــه 🎐 ", 8, string.len(tp), result.id_)
                  end
                else
                  database:sadd(hash, result.id_)
                  database:set(hash2, true)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Muted 📍 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓  تم ✅ كتمــــه 🎐 ", 8, string.len(tp), result.id_)
                  end
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍  ", 1, "md")
            end
          end
          getUser(ap[2], mute_by_id)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Mm]uteuser (%d+) (%d+) (%d+)$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
          local mute_by_reply_one_Time = function(extra, result)
            local mute_by_reply_Time = function(extra, result)
              local matches = {
                string.match(text, "^([Mm]uteuser) (%d+) (%d+) (%d+)$")
              }
              local hour = string.gsub(matches[2], "h", "")
              local num1 = tonumber(hour) * 3600
              local minutes = string.gsub(matches[3], "m", "")
              local num2 = tonumber(minutes) * 60
              local second = string.gsub(matches[4], "s", "")
              local num3 = tonumber(second)
              local num4 = tonumber(num1 + num2 + num3)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not is_momod(result.id_, msg.chat_id_) then
                  local hash = "bot:muted:" .. msg.chat_id_
                  local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                  if database:sismember(hash, result.id_) then
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Muted 📍 ", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓  تم ✅ كتمــــه 🎐 ", 8, string.len(tp), result.id_)
                    end
                  else
                    database:sadd(hash, result.id_)
                    database:setex(hash2, num4, true)
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Has Been Muted For \n " .. matches[2] .. " Hours and " .. matches[3] .. " Minutes and " .. matches[4] .. " Seconds 🎈", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\nتم كتمه خلال :\n " .. matches[2] .. " ساعه و " .. matches[3] .. " دقیقه و " .. matches[4] .. " ثانيه🎈", 8, string.len(tp), result.id_)
                    end
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍  ", 1, "md")
              end
            end
            getUser(result.sender_user_id_, mute_by_reply_Time)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, mute_by_reply_one_Time)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Mm]uteuser @(%S+) (%d+) (%d+) (%d+)$") and check_user_channel(msg) then
          do
            local ap = {
              string.match(text, "^([Mm]uteuser) @(%S+) (%d+) (%d+) (%d+)$")
            }
            local mute_by_username_one_Time = function(extra, result)
              local mute_by_username_Time = function(extra, result)
                local hour = string.gsub(ap[3], "h", "")
                local num1 = tonumber(hour) * 3600
                local minutes = string.gsub(ap[4], "m", "")
                local num2 = tonumber(minutes) * 60
                local second = string.gsub(ap[5], "s", "")
                local num3 = tonumber(second)
                local num4 = tonumber(num1 + num2 + num3)
                if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                  return false
                end
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not is_momod(result.id_, msg.chat_id_) then
                  local hash = "bot:muted:" .. msg.chat_id_
                  local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                  if database:sismember(hash, result.id_) then
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Muted 📍 ", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓  تم ✅ كتمــــه 🎐 ", 8, string.len(tp), result.id_)
                    end
                  else
                    database:sadd(hash, result.id_)
                    database:setex(hash2, num4, true)
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Has Been Muted For " .. ap[3] .. " Hours and " .. ap[4] .. " Minutes and " .. ap[5] .. " Seconds 🚀 ", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "◾️↓   العضو  " .. te .. "\nتم كتمه الى الوقت\n " .. ap[3] .. " ساعه و " .. ap[4] .. " دقیقه و " .. ap[5] .. " ثانيه🎈",  8, string.len(tp), result.id_)
                    end
                  end
                end
              end
              if result.id_ then
                getUser(result.id_, mute_by_username_Time)
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            resolve_username(ap[2], mute_by_username_one_Time)
          end
        else
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Mm]uteuser (%d+) (%d+) (%d+) (%d+)$") and check_user_channel(msg) then
          do
            local ap = {
              string.match(text, "^([Mm]uteuser) (%d+) (%d+) (%d+) (%d+)$")
            }
            local mute_by_id_Time = function(extra, result)
              local hour = string.gsub(ap[3], "h", "")
              local num1 = tonumber(hour) * 3600
              local minutes = string.gsub(ap[4], "m", "")
              local num2 = tonumber(minutes) * 60
              local second = string.gsub(ap[5], "s", "")
              local num3 = tonumber(second)
              local num4 = tonumber(num1 + num2 + num3)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not is_momod(result.id_, msg.chat_id_) then
                  local hash = "bot:muted:" .. msg.chat_id_
                  local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                  if database:sismember(hash, result.id_) then
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Already Muted 📍 ", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓  تم ✅ كتمــــه 🎐 ", 8, string.len(tp), result.id_)
                    end
                  else
                    database:sadd(hash, result.id_)
                    database:setex(hash2, num4, true)
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Has Been Muted For " .. ap[3] .. " Hours and " .. ap[4] .. " Minutes and " .. ap[5] .. " Seconds 🚀 ", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "◾️↓ العضو  " .. te .. "\nتم كتمه للوقت\n " .. ap[3] .. " ساعه و " .. ap[4] .. " دقیقه و " .. ap[5] .. " ثانيه🎈", 8, string.len(tp), result.id_)
                    end
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(ap[2], mute_by_id_Time)
          end
        else
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          local text = msg.content_.text_:gsub("الغاء كتم", "Unmuteuser")
          if text:match("^[Uu]nmuteuser$") and msg.reply_to_message_id_ ~= 0 and check_user_channel(msg) then
            local unmute_by_reply_one = function(extra, result)
              local unmute_by_reply = function(extra, result)
                if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                  return false
                end
                local hash = "bot:muted:" .. msg.chat_id_
                if result.id_ then
                  local tf = result.first_name_ or ""
                  local tl = result.last_name_ or ""
                  if result.username_ then
                    tp = result.username_
                  else
                    local st = tf .. " " .. tl
                    if string.len(st) > MaxChar then
                      tp = ""
                    elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                      tp = st
                    elseif st:match("[A-Z]") or st:match("[a-z]") then
                      tp = st
                    else
                      tp = ""
                    end
                  end
                  if tonumber(string.len(tp)) == 0 then
                    te = " [ " .. result.id_ .. " ]"
                  else
                    te = tp
                  end
                  if not database:sismember(hash, result.id_) then
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Not Muted 🚀 ", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓ تم ✅ الغاء كتمه 🎈 ", 8, string.len(tp), result.id_)
                    end
                  else
                    local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                    database:srem(hash, result.id_)
                    database:del(hash2)
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Not Muted 🚀 ", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓ تم ✅ الغاء كتمه 🎈 ", 8, string.len(tp), result.id_)
                    end
                  end
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
                end
              end
              getUser(result.sender_user_id_, unmute_by_reply)
            end
            getMessage(msg.chat_id_, msg.reply_to_message_id_, unmute_by_reply_one)
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          local text = msg.content_.text_:gsub("الغاء كتم", "Unmuteuser")
          if text:match("^[Uu]nmuteuser @(%S+)$") and check_user_channel(msg) then
            local ap = {
              string.match(text, "^([Uu]nmuteuser) @(%S+)$")
            }
            local unmute_by_username_one = function(extra, result)
              local unmute_by_username = function(extra, result)
                if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                  return false
                end
                local hash = "bot:muted:" .. msg.chat_id_
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Not Muted 🚀 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓ تم ✅ الغاء كتمه🎈 ", 8, string.len(tp), result.id_)
                  end
                else
                  local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                  database:srem(hash, result.id_)
                  database:del(hash2)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Not Muted 🚀 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓ تم ✅ الغاء كتمه🎈 ", 8, string.len(tp), result.id_)
                  end
                end
              end
              if result.id_ then
                getUser(result.id_, unmute_by_username)
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            resolve_username(ap[2], unmute_by_username_one)
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          local text = msg.content_.text_:gsub("الغاء كتم", "Unmuteuser")
          if text:match("^[Uu]nmuteuser (%d+)$") and check_user_channel(msg) then
            local ap = {
              string.match(text, "^([Uu]nmuteuser) (%d+)$")
            }
            local unmute_by_id = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "bot:muted:" .. msg.chat_id_
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Not Muted 🚀 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓ تم ✅ الغاء كتمه🎈 ", 8, string.len(tp), result.id_)
                  end
                else
                  local hash2 = "bot:muted:Time" .. msg.chat_id_ .. ":" .. result.id_
                  database:srem(hash, result.id_)
                  database:del(hash2)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  User " .. te .. " Is Not Muted 🚀 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "◾️↓  العضو  " .. te .. "\n\n◾️↓ تم ✅ الغاء كتمه🎈 ", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(ap[2], unmute_by_id)
          end
        end
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") then
          text = msg.content_.text_:gsub("رفع مدير", "Setowner")
          if text:match("^[Ss]etowner$") and msg.reply_to_message_id_ ~= 0 then
            local setowner_by_reply_one = function(extra, result)
              local setowner_by_reply = function(extra, result)
                if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                  return false
                end
                if result.id_ then
                  local tf = result.first_name_ or ""
                  local tl = result.last_name_ or ""
                  if result.username_ then
                    tp = result.username_
                  else
                    local st = tf .. " " .. tl
                    if string.len(st) > MaxChar then
                      tp = ""
                    elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                      tp = st
                    elseif st:match("[A-Z]") or st:match("[a-z]") then
                      tp = st
                    else
                      tp = ""
                    end
                  end
                  if tonumber(string.len(tp)) == 0 then
                    te = " [ " .. result.id_ .. " ]"
                  else
                    te = tp
                  end
                  local hash = "bot:owners:" .. msg.chat_id_
                  if database:sismember(hash, result.id_) then
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Owner 📍 ", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✅ رفعــه مدير 🎋 ", 8, string.len(tp), result.id_)
                    end
                  else
                    database:sadd(hash, result.id_)
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Owner 📍 ", 7, string.len(tp), result.id_)
                    else
                      sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✅ رفعــه مدير 🎋 ", 8, string.len(tp), result.id_)
                    end
                  end
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
                end
              end
              getUser(result.sender_user_id_, setowner_by_reply)
            end
            getMessage(msg.chat_id_, msg.reply_to_message_id_, setowner_by_reply_one)
          end
        end
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") then
          text = msg.content_.text_:gsub("رفع مدير", "Setowner")
          if text:match("^[Ss]etowner @(%S+)$") then
            local ap = {
              string.match(text, "^([Ss]etowner) @(%S+)$")
            }
            local setowner_by_username_one = function(extra, result)
              local setowner_by_username = function(extra, result)
                if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                  return false
                end
                local hash = "bot:owners:" .. msg.chat_id_
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Owner 📍 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✅ رفعــه مدير 🎋 ", 8, string.len(tp), result.id_)
                  end
                else
                  database:sadd(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Owner 📍 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✅ رفعــه مدير 🎋 ", 8, string.len(tp), result.id_)
                  end
                end
              end
              if result.id_ then
                getUser(result.id_, setowner_by_username)
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            resolve_username(ap[2], setowner_by_username_one)
          end
        end
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") then
          text = msg.content_.text_:gsub("رفع مدير", "Setowner")
          if text:match("^[Ss]etowner (%d+)$") then
            local ap = {
              string.match(text, "^([Ss]etowner) (%d+)$")
            }
            local setowner_by_id = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "bot:owners:" .. msg.chat_id_
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Owner 📍 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✅ رفعــه مدير 🎋 ", 8, string.len(tp), result.id_)
                  end
                else
                  database:sadd(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Owner 📍 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✅ رفعــه مدير 🎋 ", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(ap[2], setowner_by_username)
          end
        end
        local text = msg.content_.text_:gsub("تنزيل مدير", "Demowner")
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") and text:match("^[Dd]emowner$") and msg.reply_to_message_id_ ~= 0 then
          local deowner_by_reply_one = function(extra, result)
            local deowner_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "bot:owners:" .. msg.chat_id_
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Removed From Owner 🚀 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  : " .. te .. "\n\n🔖↓  تم تنزيله من الاداره 🎋 ", 8, string.len(tp), result.id_)
                  end
                else
                  database:srem(hash, result.id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Removed From Owner 🚀 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  : " .. te .. "\n\n🔖↓  تم تنزيله من الاداره 🎋 ", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(result.sender_user_id_, deowner_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, deowner_by_reply_one)
        end
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") and text:match("^[Dd]emowner @(%S+)$") then
          local hash = "bot:owners:" .. msg.chat_id_
          local ap = {
            string.match(text, "^([Dd]emowner) @(%S+)$")
          }
          local remowner_by_username_one = function(extra, result)
            local remowner_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "bot:owners:" .. msg.chat_id_
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Removed From Owner 🚀 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  : " .. te .. "\n\n🔖↓  تم تنزيله من الاداره 🎋 ", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Removed From Owner 🚀 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  : " .. te .. "\n\n🔖↓  تم تنزيله من الاداره 🎋 ", 8, string.len(tp), result.id_)
                end
              end
            end
            if result.id_ then
              getUser(result.id_, remowner_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          resolve_username(ap[2], remowner_by_username_one)
        end
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") and text:match("^[Dd]emowner (%d+)$") then
          local hash = "bot:owners:" .. msg.chat_id_
          local ap = {
            string.match(text, "^([Dd]emowner) (%d+)$")
          }
          local remowner_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "bot:owners:" .. msg.chat_id_
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Removed From Owner 🚀 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  : " .. te .. "\n\n🔖↓  تم تنزيله من الاداره 🎋 ", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Removed From Owner 🚀 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  : " .. te .. "\n\n🔖↓  تم تنزيله من الاداره 🎋 ", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(ap[2], remowner_by_id)
        end
        if is_leader(msg) and text:match("^[Ss]etsudo$") and msg.reply_to_message_id_ ~= 0 then
          local promoteSudo_by_reply_one = function(extra, result)
            local promoteSudo_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "Bot:SudoUsers"
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Sudo 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓  تم ✔ رفعه مطور 🎈 ", 8, string.len(tp), result.id_)
                  end
                else
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Sudo 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓  تم ✔ رفعه مطور 🎈 ", 8, string.len(tp), result.id_)
                  end
                  table.insert(_config.Sudo_Users, tonumber(result.id_))
                  save_on_config()
                  load_config()

                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ",  1, "md")
              end
            end
            getUser(result.sender_user_id_, promoteSudo_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, promoteSudo_by_reply_one)
        end
        if is_leader(msg) and text:match("^[Ss]etsudo @(%S+)$") then
          local ap = {
            string.match(text, "^([Ss]etsudo) @(%S+)$")
          }
          local promoteSudo_by_username_one = function(extra, result)
            local promoteSudo_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "Bot:SudoUsers"
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Sudo 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓  تم ✔ رفعه مطور 🎈 ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Sudo 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓  تم ✔ رفعه مطور 🎈 ", 8, string.len(tp), result.id_)
                end
                table.insert(_config.Sudo_Users, tonumber(result.id_))
                save_on_config()
                load_config()

              end
            end
            if result.id_ then
              getUser(result.id_, promoteSudo_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          resolve_username(ap[2], promoteSudo_by_username_one)
        end
        if is_leader(msg) and text:match("^[Ss]etsudo (%d+)$") then
          local ap = {
            string.match(text, "^([Ss]etsudo) (%d+)$")
          }
          local promoteSudo_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "Bot:SudoUsers"
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Sudo 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓  تم ✔ رفعه مطور 🎈 ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Sudo 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓  تم ✔ رفعه مطور 🎈 ", 8, string.len(tp), result.id_)
                end
                table.insert(_config.Sudo_Users, tonumber(result.id_))
                save_on_config()
                load_config()

              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ",  1, "md")
            end
          end
          getUser(ap[2], promoteSudo_by_id)
        end
        if is_leader(msg) and text:match("^[Rr]emsudo$") and msg.reply_to_message_id_ ~= 0 then
          local demoteSudo_by_reply_one = function(extra, result)
            local demoteSudo_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local k = tonumber(result.id_)
              local hash = "Bot:SudoUsers"
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Sudo 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✔ تنزيل المطور🎐 ", 8, string.len(tp), result.id_)
                  end
                else
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Sudo 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✔ تنزيل المطور🎐 ", 8, string.len(tp), result.id_)
                  end
                  table.remove(_config.Sudo_Users, getindex(_config.Sudo_Users, k))
                  save_on_config()
                  load_config()

                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(result.sender_user_id_, demoteSudo_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, demoteSudo_by_reply_one)
        end
        if is_leader(msg) and text:match("^[Rr]emsudo @(%S+)$") then
          local ap = {
            string.match(text, "^([Rr]emsudo) @(%S+)$")
          }
          local demoteSudo_by_username_one = function(extra, result)
            local demoteSudo_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local k = tonumber(result.id_)
              local hash = "Bot:SudoUsers"
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Sudo 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✔ تنزيل المطور🎐  ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Sudo 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✔ تنزيل المطور🎐 ", 8, string.len(tp), result.id_)
                end
                table.remove(_config.Sudo_Users, getindex(_config.Sudo_Users, k))
                save_on_config()
                load_config()

              end
            end
            if result.id_ then
              getUser(result.id_, demoteSudo_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          resolve_username(ap[2], demoteSudo_by_username_one)
        end
        if is_leader(msg) and text:match("^[Rr]emsudo (%d+)$") then
          local ap = {
            string.match(text, "^([Rr]emsudo) (%d+)$")
          }
          local demoteSudo_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local k = tonumber(result.id_)
              local hash = "Bot:SudoUsers"
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Sudo 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✔ تنزيل المطور🎐 ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Sudo 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✔ تنزيل المطور🎐  ", 8, string.len(tp), result.id_)
                end
                table.remove(_config.Sudo_Users, getindex(_config.Sudo_Users, k))
                save_on_config()
                load_config()

              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(ap[2], demoteSudo_by_id)
        end
				if is_leader(msg) and text:match("^رفع مطور$") and msg.reply_to_message_id_ ~= 0 then
          local promoteSudo_by_reply_one = function(extra, result)
            local promoteSudo_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "Bot:SudoUsers"
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Sudo 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓  تم ✔ رفعه مطور 🎈 ", 8, string.len(tp), result.id_)
                  end
                else
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Sudo 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓  تم ✔ رفعه مطور 🎈 ", 8, string.len(tp), result.id_)
                  end
                  table.insert(_config.Sudo_Users, tonumber(result.id_))
                  save_on_config()
                  load_config()

                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ",  1, "md")
              end
            end
            getUser(result.sender_user_id_, promoteSudo_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, promoteSudo_by_reply_one)
        end
        if is_leader(msg) and text:match("^رفع مطور @(%S+)$") then
          local ap = {
            string.match(text, "^(رفع مطور) @(%S+)$")
          }
          local promoteSudo_by_username_one = function(extra, result)
            local promoteSudo_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "Bot:SudoUsers"
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Sudo 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓  تم ✔ رفعه مطور 🎈 ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Sudo 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓  تم ✔ رفعه مطور 🎈 ", 8, string.len(tp), result.id_)
                end
                table.insert(_config.Sudo_Users, tonumber(result.id_))
                save_on_config()
                load_config()

              end
            end
            if result.id_ then
              getUser(result.id_, promoteSudo_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          resolve_username(ap[2], promoteSudo_by_username_one)
        end
        if is_leader(msg) and text:match("^رفع مطور (%d+)$") then
          local ap = {
            string.match(text, "^(رفع مطور) (%d+)$")
          }
          local promoteSudo_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "Bot:SudoUsers"
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Sudo 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓  تم ✔ رفعه مطور 🎈 ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Promoted To Sudo 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓  تم ✔ رفعه مطور 🎈 ", 8, string.len(tp), result.id_)
                end
                table.insert(_config.Sudo_Users, tonumber(result.id_))
                save_on_config()
                load_config()

              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ",  1, "md")
            end
          end
          getUser(ap[2], promoteSudo_by_id)
        end
        if is_leader(msg) and text:match("^تنزيل مطور$") and msg.reply_to_message_id_ ~= 0 then
          local demoteSudo_by_reply_one = function(extra, result)
            local demoteSudo_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local k = tonumber(result.id_)
              local hash = "Bot:SudoUsers"
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Sudo 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✔ تنزيل المطور🎐 ", 8, string.len(tp), result.id_)
                  end
                else
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Sudo 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✔ تنزيل المطور🎐 ", 8, string.len(tp), result.id_)
                  end
                  table.remove(_config.Sudo_Users, getindex(_config.Sudo_Users, k))
                  save_on_config()
                  load_config()

                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(result.sender_user_id_, demoteSudo_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, demoteSudo_by_reply_one)
        end
        if is_leader(msg) and text:match("^تنزيل مطور @(%S+)$") then
          local ap = {
            string.match(text, "^(تنزيل مطور) @(%S+)$")
          }
          local demoteSudo_by_username_one = function(extra, result)
            local demoteSudo_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local k = tonumber(result.id_)
              local hash = "Bot:SudoUsers"
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Sudo 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✔ تنزيل المطور🎐  ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Sudo 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✔ تنزيل المطور🎐 ", 8, string.len(tp), result.id_)
                end
                table.remove(_config.Sudo_Users, getindex(_config.Sudo_Users, k))
                save_on_config()
                load_config()

              end
            end
            if result.id_ then
              getUser(result.id_, demoteSudo_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          resolve_username(ap[2], demoteSudo_by_username_one)
        end
        if is_leader(msg) and text:match("^تنزيل مطور (%d+)$") then
          local ap = {
            string.match(text, "^(تنزيل مطور) (%d+)$")
          }
          local demoteSudo_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local k = tonumber(result.id_)
              local hash = "Bot:SudoUsers"
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Sudo 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✔ تنزيل المطور🎐 ", 8, string.len(tp), result.id_)
                end
              else
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Sudo 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو " .. te .. "\n\n🔖↓  تم ✔ تنزيل المطور🎐  ", 8, string.len(tp), result.id_)
                end
                table.remove(_config.Sudo_Users, getindex(_config.Sudo_Users, k))
                save_on_config()
                load_config()

              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(ap[2], demoteSudo_by_id)
        end
        local text = msg.content_.text_:gsub("اضف ادمن", "Addadmin")
        if is_leader(msg) and text:match("^[Ss]etadmin$") and msg.reply_to_message_id_ ~= 0 then
          local addadmin_by_reply_one = function(extra, result)
            local addadmin_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "Bot:Admins"
                if database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Already Bot Admin 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم اضافه ادمن في البوت🎏 ", 8, string.len(tp), result.id_)
                  end
                else
                  database:sadd(hash, result.id_)

                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Already Bot Admin 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم اضافه ادمن في البوت🎏 ", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(result.sender_user_id_, addadmin_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, addadmin_by_reply_one)
        end
        if is_leader(msg) and text:match("^[Ss]etadmin @(%S+)$") then
          local ap = {
            string.match(text, "^([Ss]etadmin) @(%S+)$")
          }
          local addadmin_by_username_one = function(extra, result)
            local addadmin_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "Bot:Admins"
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Already Bot Admin 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم اضافه ادمن في البوت🎏 ", 8, string.len(tp), result.id_)
                end
              else
                database:sadd(hash, result.id_)

                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Already Bot Admin 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم اضافه ادمن في البوت🎏 ", 8, string.len(tp), result.id_)
                end
              end
            end
            if result.id_ then
              getUser(result.id_, addadmin_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          resolve_username(ap[2], addadmin_by_username_one)
        end
        if is_leader(msg) and text:match("^[Ss]etadmin (%d+)$") then
          local ap = {
            string.match(text, "^([Ss]etadmin) (%d+)$")
          }
          local addadmin_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == tonumber(our_id) then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "Bot:Admins"
              if database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Already Bot Admin 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم اضافه ادمن في البوت🎏 ", 8, string.len(tp), result.id_)
                end
              else
                database:sadd(hash, result.id_)

                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Already Bot Admin 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم اضافه ادمن في البوت🎏 ", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          getUser(ap[2], addadmin_by_reply)
        end
        local text = msg.content_.text_:gsub("حذف ادمن", "Remadmin")
        if is_leader(msg) and text:match("^[Rr]emadmin$") and msg.reply_to_message_id_ ~= 0 then
          local deadmin_by_reply_one = function(extra, result)
            local deadmin_by_reply = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              if result.id_ then
                local tf = result.first_name_ or ""
                local tl = result.last_name_ or ""
                if result.username_ then
                  tp = result.username_
                else
                  local st = tf .. " " .. tl
                  if string.len(st) > MaxChar then
                    tp = ""
                  elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                    tp = st
                  elseif st:match("[A-Z]") or st:match("[a-z]") then
                    tp = st
                  else
                    tp = ""
                  end
                end
                if tonumber(string.len(tp)) == 0 then
                  te = " [ " .. result.id_ .. " ]"
                else
                  te = tp
                end
                local hash = "Bot:Admins"
                if not database:sismember(hash, result.id_) then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Bot Admin 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓   العضو  " .. te .. "\n\n🔖↓  تم حذف الادمن 🎈 ", 8, string.len(tp), result.id_)
                  end
                else
                  database:srem(hash, result.id_)

                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Bot Admin 🎈 ", 7, string.len(tp), result.id_)
                  else
                    sendmen(msg.chat_id_, msg.id_, "🔖↓   العضو  " .. te .. "\n\n🔖↓  تم حذف الادمن 🎈 ", 8, string.len(tp), result.id_)
                  end
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
              end
            end
            getUser(result.sender_user_id_, deadmin_by_reply)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, deadmin_by_reply_one)
        end
        if is_leader(msg) and text:match("^[Rr]emadmin @(%S+)$") then
          local hash = "Bot:Admins"
          local ap = {
            string.match(text, "^([Rr]emadmin) @(%S+)$")
          }
          local remadmin_by_username_one = function(extra, result)
            local remadmin_by_username = function(extra, result)
              if result.id_ and tonumber(result.id_) == tonumber(our_id) then
                return false
              end
              local hash = "Bot:Admins"
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Bot Admin 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓  تم حذف الادمن 🎈 ", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)

                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Bot Admin 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓  تم حذف الادمن 🎈 ", 8, string.len(tp), result.id_)
                end
              end
            end
            if result.id_ then
              getUser(result.id_, remadmin_by_username)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢  لا يوجد مستخدم 📍 ", 1, "md")
            end
          end
          resolve_username(ap[2], remadmin_by_username_one)
        end
        if is_leader(msg) and text:match("^[Rr]emadmin (%d+)$") then
          local ap = {
            string.match(text, "^([Rr]emadmin) (%d+)$")
          }
          local remadmin_by_id = function(extra, result)
            if result.id_ and tonumber(result.id_) == our_id then
              return false
            end
            if result.id_ then
              local tf = result.first_name_ or ""
              local tl = result.last_name_ or ""
              if result.username_ then
                tp = result.username_
              else
                local st = tf .. " " .. tl
                if string.len(st) > MaxChar then
                  tp = ""
                elseif string.len(st) < MaxChar or string.len(st) == MaxChar then
                  tp = st
                elseif st:match("[A-Z]") or st:match("[a-z]") then
                  tp = st
                else
                  tp = ""
                end
              end
              if tonumber(string.len(tp)) == 0 then
                te = " [ " .. result.id_ .. " ]"
              else
                te = tp
              end
              local hash = "Bot:Admins"
              if not database:sismember(hash, result.id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Bot Admin 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم حذف الادمن 🎈 ", 8, string.len(tp), result.id_)
                end
              else
                database:srem(hash, result.id_)

                if database:get("lang:gp:" .. msg.chat_id_) then
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  User " .. te .. " Is Not Bot Admin 🎈 ", 7, string.len(tp), result.id_)
                else
                  sendmen(msg.chat_id_, msg.id_, "🔖↓  العضو  " .. te .. "\n\n🔖↓ تم حذف الادمن 🎈 ", 8, string.len(tp), result.id_)
                end
              end
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ *User Not Found* ✞ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "➢ * لا يوجد مستخدم* 📍 ", 1, "md")
            end
          end
          getUser(ap[2], remadmin_by_username)
        end
        if is_admin(msg.sender_user_id_) and (text:match("^[Gg]plist$") or text:match("^مجموعات البوت$")) then
          if database:get("bot:reloadingtime") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = ""
            else
              text = ""
            end
            send(msg.chat_id_, msg.id_, 1, text, 1, "html")
          else
            local hash = "bot:groups"
            local list = database:smembers(hash)
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "▫️↓  List of <b>Bot Groups</b> : \n\n"
            else
              text = "▫️↓ <code>قائمه المجموعات 📊</code> : \n\n"
            end
            local text2 = ""
            local text3 = ""
            local text4 = ""
            local text5 = ""
            local text6 = ""
            for k, v in pairs(list) do
              local gp_info = database:get("group:Name" .. v)
              local chatname = gp_info
              local ex = database:ttl("bot:charge:" .. v)
              if ex == -1 then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  expire = "<b>Unlimited</b>"
                else
                  expire = "محدود"
                end
              else
                local b = math.floor(ex / day) + 1
                if b == 0 then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    expire = "<b>No Credit</b>"
                  else
                    expire = "بلا حدود"
                  end
                else
                  local d = math.floor(ex / day) + 1
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    expire = "<b>" .. d .. " Days</b>"
                  else
                    expire = d .. " ايام"
                  end
                end
              end
              if k <= 30 then
                if chatname then
                  text = text .. k .. " - " .. chatname .. [[

[]] .. v .. [[
]
[]] .. expire .. [[
]

]]
                else
                  text = text .. k .. " - [" .. v .. [[
]
[]] .. expire .. [[
]

]]
                end
              elseif k > 30 and k <= 60 then
                if chatname then
                  text2 = text2 .. k .. " - " .. chatname .. [[

[]] .. v .. [[
]
[]] .. expire .. [[
]

]]
                else
                  text2 = text2 .. k .. " - [" .. v .. [[
]
[]] .. expire .. [[
]

]]
                end
              elseif k > 60 and k <= 90 then
                if chatname then
                  text3 = text3 .. k .. " - " .. chatname .. [[

[]] .. v .. [[
]
[]] .. expire .. [[
]

]]
                else
                  text3 = text3 .. k .. " - [" .. v .. [[
]
[]] .. expire .. [[
]

]]
                end
              elseif k > 90 and k <= 120 then
                if chatname then
                  text4 = text4 .. k .. " - " .. chatname .. [[

[]] .. v .. [[
]
[]] .. expire .. [[
]

]]
                else
                  text4 = text4 .. k .. " - [" .. v .. [[
]
[]] .. expire .. [[
]

]]
                end
              elseif k > 120 and k <= 150 then
                if chatname then
                  text5 = text5 .. k .. " - " .. chatname .. [[

[]] .. v .. [[
]
[]] .. expire .. [[
]

]]
                else
                  text5 = text5 .. k .. " - [" .. v .. [[
]
[]] .. expire .. [[
]

]]
                end
              elseif k > 150 and k <= 180 then
                if chatname then
                  text6 = text6 .. k .. " - " .. chatname .. [[

[]] .. v .. [[
]
[]] .. expire .. [[
]

]]
                else
                  text6 = text6 .. k .. " - [" .. v .. [[
]
[]] .. expire .. [[
]

]]
                end
              end
            end
            if #list == 0 then
              if database:get("lang:gp:" .. msg.chat_id_) then
                text = "▫️↓  List of <b>Bot Groups</b> is Empty ❗️"
              else
                text = "〖لا توجد مجموعات مفعله🎈〗 "
              end
            end
            send_large_msg(msg.chat_id_, msg.id_, 1, text, 1, "html")
            if text2 then
              send_large_msg(msg.chat_id_, msg.id_, 1, text2, 1, "html")
            end
            if text3 then
              send_large_msg(msg.chat_id_, msg.id_, 1, text3, 1, "html")
            end
            if text4 then
              send_large_msg(msg.chat_id_, msg.id_, 1, text4, 1, "html")
            end
            if text5 then
              send_large_msg(msg.chat_id_, msg.id_, 1, text5, 1, "html")
            end
            if text6 then
              send_large_msg(msg.chat_id_, msg.id_, 1, text6, 1, "html")
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Mm]odlist$") or text:match("^الادمنيه$")) and check_user_channel(msg) then
          local hash = "bot:momod:" .. msg.chat_id_
          local list = database:smembers(hash)
          if database:get("lang:gp:" .. msg.chat_id_) then
            text = "▫️↓  List Of <b>Moderator</b> : \n\n"
          else
            text = "▫️↓ <b>قائمة الادمنيه 📊</b>: \n\n"
          end
          for k, v in pairs(list) do
            local user_info = database:get("user:Name" .. v)
            if user_info then
              local username = user_info
              text = text .. k .. " - " .. username .. " [" .. v .. "]\n"
            else
              text = text .. k .. " - [" .. v .. "]\n"
            end
          end
          if #list == 0 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "● ◄  List Of <b>Moderator</b> is Empty 🎣 "
            else
              text = "〖لا يوجد ادمنيه 📍 〗 "
            end
          end
          send(msg.chat_id_, msg.id_, 1, text, 1, "html")
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Vv]iplist$") or text:match("^الاعضاء المميزين$")) and check_user_channel(msg) then
          local hash = "bot:vipmem:" .. msg.chat_id_
          local list = database:smembers(hash)
          if database:get("lang:gp:" .. msg.chat_id_) then
            text = "▫️↓  List Of <b>VIP Members</b> : \n\n"
          else
            text = "● ◄ <b> قائمه الاعضاء المميزين</b> :\n\n"
          end
          for k, v in pairs(list) do
            local user_info = database:get("user:Name" .. v)
            if user_info then
              local username = user_info
              text = text .. k .. " - " .. username .. " [" .. v .. "]\n"
            else
              text = text .. k .. " - [" .. v .. "]\n"
            end
          end
          if #list == 0 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "▫️↓  List Of <b>VIP Members</b> is Empty 🏌️ "
            else
              text = "〖لا يوجد اعضاء مميزين 🚀 〗 "
            end
          end
          send(msg.chat_id_, msg.id_, 1, text, 1, "html")
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Mm]utelist$") or text:match("^المكتومين$")) and check_user_channel(msg) then
          local hash = "bot:muted:" .. msg.chat_id_
          local list = database:smembers(hash)
          if database:get("lang:gp:" .. msg.chat_id_) then
            text = "▫️↓  List of <b>Muted users</b> : \n\n"
          else
            text = "● ◄  <b>قائمه المكتومين </b>: \n\n"
          end
          for k, v in pairs(list) do
            local TTL = database:ttl("bot:muted:Time" .. msg.chat_id_ .. ":" .. v)
            if TTL == 0 or TTL == -2 then
              if database:get("lang:gp:" .. msg.chat_id_) then
                Time_S = "[ Free ]"
              else
                Time_S = "[ مفتوح ]"
              end
            elseif TTL == -1 then
              if database:get("lang:gp:" .. msg.chat_id_) then
                Time_S = "[ No time ]"
              else
                Time_S = "[ بدون وقت ]"
              end
            else
              local Time_ = getTime(TTL)
              Time_S = "[ " .. Time_ .. " ]"
            end
            local user_info = database:get("user:Name" .. v)
            if user_info then
              local username = user_info
              text = text .. k .. " - " .. username .. " [" .. v .. "]\n" .. Time_S .. "\n"
            else
              text = text .. k .. " - [" .. v .. "]\n" .. Time_S .. "\n"
            end
          end
          if #list == 0 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "▫️↓  List of <b>Muted users</b> is Empty 🎣  "
            else
              text = "〖 لا يوجد مكتومين 🎈 〗  "
            end
          end
          send(msg.chat_id_, msg.id_, 1, text, 1, "html")
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Oo]wner$") or text:match("^[Oo]wnerlist$") or text:match("^المدراء$")) and check_user_channel(msg) then
          local hash = "bot:owners:" .. msg.chat_id_
          local list = database:smembers(hash)
          if not database:get("lang:gp:" .. msg.chat_id_) then
            text = "● ◄ <b>قائمة المدراء<b> : \n\n"
          else
            text = "▫️↓  <b>Owners</b> list : \n\n"
          end
          for k, v in pairs(list) do
            local user_info = database:get("user:Name" .. v)
            if user_info then
              local username = user_info
              text = text .. k .. " - " .. username .. " [" .. v .. "]\n"
            else
              text = text .. k .. " - [" .. v .. "]\n"
            end
          end
          if #list == 0 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "▫️↓  <b>Owner list</b> is Empty 📍 "
            else
              text = "〖 لا يوجد مدراء📍 〗 "
            end
          end
          send(msg.chat_id_, msg.id_, 1, text, 1, "html")
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Bb]anlist$") or text:match("^المحظورين$")) and check_user_channel(msg) then
          local hash = "bot:banned:" .. msg.chat_id_
          local list = database:smembers(hash)
          if database:get("lang:gp:" .. msg.chat_id_) then
            text = "● ◄  List of <b>Banlist</b> : \n\n"
          else
            text = "● ◄  <b>قائمه المحظورين </b>: \n\n"
          end
          for k, v in pairs(list) do
            local user_info = database:get("user:Name" .. v)
            if user_info then
              local username = user_info
              text = text .. k .. " - " .. username .. " [" .. v .. "]\n"
            else
              text = text .. k .. " - [" .. v .. "]\n"
            end
          end
          if #list == 0 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "▫️↓  List of <b>Banlist</b> is Empty 🏌️ "
            else
              text = "〖لا يوجد محضورين 📍 〗 "
            end
          end
          send(msg.chat_id_, msg.id_, 1, text, 1, "html")
        end
        if is_sudo(msg) and (text:match("^[Bb]analllist$") or text:match("^قائمه العام$")) then
          local hash = "bot:gban:"
          local list = database:smembers(hash)
          if database:get("lang:gp:" .. msg.chat_id_) then
            text = "▫️↓  List of <b>Banlist</b> : \n\n"
          else
            text = "● ◄  <b>المحضورين عام</b> : \n\n"
          end
          for k, v in pairs(list) do
            local user_info = database:get("user:Name" .. v)
            if user_info then
              local username = user_info
              text = text .. k .. " - " .. username .. " [" .. v .. "]\n"
            else
              text = text .. k .. " - [" .. v .. "]\n"
            end
          end
          if #list == 0 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "▫️↓  List of <b>BanAll</b> is Empty 🏌️ "
            else
              text = "〖لا يوجد محضورين عام 🚀 〗 "
            end
          end
          send(msg.chat_id_, msg.id_, 1, text, 1, "html")
        end
        if is_admin(msg.sender_user_id_) and (text:match("^[Aa]dminlist$") or text:match("^ادمنيه البوت$")) then
          local hash = "Bot:Admins"
          local list = database:smembers(hash)
          if database:get("lang:gp:" .. msg.chat_id_) then
            text = "▫️↓  List of <b>Bot Admins</b> :\n\n"
          else
            text = "● ◄ <b> ادمنيه البوت</b> :\n\n"
          end
          for k, v in pairs(list) do
            if database:get("SudoNumberGp" .. v) then
              gps = tonumber(database:get("SudoNumberGp" .. v))
            else
              gps = 0
            end
            local user_info = database:get("user:Name" .. v)
            if user_info then
              local username = user_info
              text = text .. k .. " - " .. username .. " [" .. v .. "] (" .. gps .. ")\n"
            else
              text = text .. k .. " - [" .. v .. "] (" .. gps .. ")\n"
            end
          end
          if #list == 0 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "▫️↓  List of <b>Bot Admins</b> is Empty 🏌️ "
            else
              text = "〖لا يوجد ادمنيه في البوت📍 〗 "
            end
          end
          send(msg.chat_id_, msg.id_, 1, text, "html")
        end
        if is_admin(msg.sender_user_id_) and (text:match("^[Ss]udolist$") or text:match("^المطورين$")) then
          local hash = "Bot:SudoUsers"
          local list = database:smembers(hash)
          if database:get("lang:gp:" .. msg.chat_id_) then
            text = "▫️↓  List Of <b>SudoUsers</b> :\n\n"
          else
            text = "● ◄ <b> مطورين البوت</b> :\n\n"
          end
          for k, v in pairs(list) do
            if database:get("SudoNumberGp" .. v) then
              gps = tonumber(database:get("SudoNumberGp" .. v))
            else
              gps = 0
            end
            local user_info = database:get("user:Name" .. v)
            if user_info then
              local username = user_info
              text = text .. k .. " - " .. username .. " [" .. v .. "] (" .. gps .. ")\n"
            else
              text = text .. k .. " - [" .. v .. "] (" .. gps .. ")\n"
            end
          end
          if #list == 0 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "▫️↓  List of <b>Sudousers</b> is Empty 🎈"
            else
              text = "〖لا يوجد مطورين في البوت 📍 〗 "
            end
          end
          send(msg.chat_id_, msg.id_, 1, text, "html")
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Gg]etid$") or text:match("^الايدي$") and msg.reply_to_message_id_ ~= 0) and check_user_channel(msg) then
          local getid_by_reply = function(extra, result)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "✺⇓  *User ID* : `" .. result.sender_user_id_ .. "`", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "✺⇓  الايدي : " .. result.sender_user_id_, 1, "md")
            end
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, getid_by_reply)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and text:match("^[Ii]d @(%S+)$") and check_user_channel(msg) then
          do
            local ap = {
              string.match(text, "^([Ii]d) @(%S+)$")
            }
            local id_by_usernameen = function(extra, result)
              if result.id_ then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  if tonumber(result.id_) == tonumber(karrar) then
                    t = "sudo source 🤹🏻‍♂️"
                  elseif tonumber(result.id_) == tonumber(bot_owner) then
                    t = "Chief🎣"
                  elseif result.id_ == tonumber(bot_id) then
                    t = "bot cli💀"
                  elseif result.id_ == tonumber(api_id) then
                    t = "bot api💀"
                  elseif is_sudoid(result.id_) then
                    t = "Sudo🤹🏻‍♂️"
                  elseif is_admin(result.id_) then
                    t = "Bot Admin🏹"
                  elseif is_owner(result.id_, msg.chat_id_) then
                    t = "Owner🏅"
                  elseif is_momod(result.id_, msg.chat_id_) then
                    t = "Group Admin🕴️"
                  elseif is_vipmem(result.id_, msg.chat_id_) then
                    t = "VIP Member🎗️"
                  else
                    t = "Member🏆"
                  end
                end
                if not database:get("lang:gp:" .. msg.chat_id_) then
                  if tonumber(result.id_) == tonumber(karrar) then
                    t = "مطور السورس 🤹🏻‍♂️"
                  elseif result.id_ == tonumber(bot_id) then
                    t = "بوت cli💀"
                  elseif result.id_ == tonumber(api_id) then
                    t = "بوت api💀"
                  elseif tonumber(result.id_) == tonumber(bot_owner) then
                    t = "مطور الاساسـي 🍃"
                  elseif is_sudoid(result.id_) then
                    t = "مطوري🎭"
                  elseif is_admin(result.id_) then
                    t = "ادمن في البوت🏋️"
                  elseif is_owner(result.id_, msg.chat_id_) then
                    t = "مدير المجموعه🎷"
                  elseif is_momod(result.id_, msg.chat_id_) then
                    t = "ادمن 🎰"
                  elseif is_vipmem(result.id_, msg.chat_id_) then
                    t = "عضو مميز🐣"
                  else
                    t = "عضو🐥"
                  end
                end
                local gpid = tostring(result.id_)
                if gpid:match("^(%d+)") then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    text = "🎴⇓ <b>User</b> : @" .. ap[2] .. "\n\n🎴⇓  <b>ID</b> : <code>" .. result.id_ .. "</code>\n\n🎴⇓  <b>Rank</b> : <b>" .. t .. "</b>"
                  else
                    text = "🎴⇓ <b>معرفــه</b> : @" .. ap[2] .. "\n\n🎴⇓ <b>الايدي</b>  : (" .. result.id_ .. ")\n\n🎴⇓ <b>الرتبه</b>  : " .. t
                  end
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  text = "🎴⇓  <b>Username</b> : @" .. ap[2] .. "\n\n🎴⇓  <b>ID</b> : <code>" .. result.id_ .. "</code>"
                else
                  text = "🎴⇓ <b>معرفــه </b> : @" .. ap[2] .. "\n\n🎴⇓ <b> الايدي</b> : (" .. result.id_ .. ")"
                end
              elseif not result.id_ then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  text = "💡 Username is <b>not faund </b> 💡 "
                else
                  text = "💡 المعرف غير صحيح 💡 "
                end
              end
              send(msg.chat_id_, msg.id_, 1, text, 1, "html")
            end
            resolve_username(ap[2], id_by_usernameen)
          end
        else
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) then
          text = text:gsub("أيدي", "ايدي")
          if text:match("^ايدي @(%S+)$") and check_user_channel(msg) then
            do
              local ap = {
                string.match(text, "^(ايدي) @(%S+)$")
              }
              local id_by_username = function(extra, result)
                if result.id_ then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    if tonumber(result.id_) == tonumber(karrar) then
                      t = "sudo source🤹🏻‍♂️"
                    elseif tonumber(result.id_) == tonumber(bot_owner) then
                      t = "Chief🐯"
                    elseif result.id_ == tonumber(bot_id) then
                      t = "bot cli 💀"
                    elseif is_sudoid(result.id_) then
                      t = "Sudo🐼"
                    elseif is_admin(result.id_) then
                      t = "Bot Admin🐨"
                    elseif is_owner(result.id_, msg.chat_id_) then
                      t = "Owner🐰"
                    elseif is_momod(result.id_, msg.chat_id_) then
                      t = "Group Admin🐱"
                    elseif is_vipmem(result.id_, msg.chat_id_) then
                      t = "VIP Member🐹"
                    else
                      t = "Member🐶"
                    end
                  end
                  if not database:get("lang:gp:" .. msg.chat_id_) then
                    if tonumber(result.id_) == tonumber(karrar) then
                      t = "مطور السورس 🤹🏻‍♂️"
                    elseif result.id_ == tonumber(bot_id) then
                      t = " بوت cli💀"
                    elseif tonumber(result.id_) == tonumber(bot_owner) then
                      t = "مطور الاساسـي 🍃"
                    elseif is_sudoid(result.id_) then
                      t = "مطور 🐯"
                    elseif is_admin(result.id_) then
                      t = "ادمن في البوت🐼"
                    elseif is_owner(result.id_, msg.chat_id_) then
                      t = "مدير المجموعه🐻"
                    elseif is_momod(result.id_, msg.chat_id_) then
                      t = "ادمن🐙"
                    elseif is_vipmem(result.id_, msg.chat_id_) then
                      t = "عضو مميز🐱"
                    else
                      t = "عضو 🐮"
                    end
                  end
                  local gpid = tostring(result.id_)
                  if gpid:match("^(%d+)") then
                    if database:get("lang:gp:" .. msg.chat_id_) then
                      text = "🎴⇓  <b>USER</b> : @" .. ap[2] .. "\n\n🎴⇓  <b>ID</b> : <code>" .. result.id_ .. "</code>\n\n🎴⇓  <b>Rank</b> : <b>" .. t .. "</b>"
                    else
                      text = "🎴⇓ <b>معرفــه </b> : @" .. ap[2] .. "\n\n🎴⇓ <b>الايدي</b> : " .. result.id_ .. " \n\n🎴⇓ <b>الرتبه</b> : " .. t
                    end
                  elseif database:get("lang:gp:" .. msg.chat_id_) then
                    text = "🎴⇓  <b>Username</b> : @" .. ap[2] .. " \n\n🎴⇓  <b>ID</b> : <code>" .. result.id_ .. "</code>"
                  else
                    text = "🎴⇓ <b>معرفــه</b> : @" .. ap[2] .. "\n\n🎴⇓<b> الايدي</b> : (" .. result.id_ .. ")"
                  end
                elseif not result.id_ then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    text = "💡 Username is <b>not faund </b> 💡  "
                  else
                    text = "💡 المعرف غير صحيح 💡  "
                  end
                end
                send(msg.chat_id_, msg.id_, 1, text, 1, "html")
              end
              resolve_username(ap[2], id_by_username)
            end
          end
        else
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Ff]ilterlist") or text:match("^قائمه المنع")) and check_user_channel(msg) then
          local hash = "bot:filters:" .. msg.chat_id_
          local names = database:hkeys(hash)
          if database:get("lang:gp:" .. msg.chat_id_) then
            texti = "▫️↓  <b>Filterlist</b> : \n\n"
          else
            texti = "● ◄ <b>الكلمات الممنوعه</b> : \n\n"
          end
          local b = 1
          for i = 1, #names do
            texti = texti .. b .. ". " .. names[i] .. "\n"
            b = b + 1
          end
          if #names == 0 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              texti = "▫️↓  <b>Filterlist</b> is Empty 🏌️ "
            else
              texti = "〖لا توجد كلمات ممنوعه 📍 〗 "
            end
          end
          if text:match("^[Ff]ilterlist$") or text:match("^قائمه المنع$") then
            send(msg.chat_id_, msg.id_, 1, texti, 1, "html")
          elseif (text:match("^[Ff]ilterlistpv$") or text:match("المنع خاص$")) and is_owner(msg.sender_user_id_, msg.chat_id_) then
            send(msg.sender_user_id_, 0, 1, texti, 1, "html")
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "●◄ <b>Filter List</b> of Group has been <b>Sent</b> to your <b>PV</b> 📍"
            else
              text = "●◄ تم ارسال القائمه خاص 📍"
            end
            send(msg.chat_id_, msg.id_, 1, text, 1, "html")
          end
        end
		if (idf:match("-100(%d+)") or is_momod(msg.sender_user_id_, msg.chat_id_)) and text:match("^اسمي$") and msg.reply_to_message_id_ == 0 and check_user_channel(msg) then
          local get_me = function(extra, result)
            if tonumber(result.id_) == tonumber(karrar) then
        ten = "Sudo source 🍃"
              tar = "مطور السورس 🍃"
            elseif is_leaderid(result.id_) then
              ten = "Chief"
              tar = "مطور الاساسـي 🍃"
            elseif is_sudoid(result.id_) then
              ten = "Sudo"
              tar = "مطور 🐯"
            elseif is_admin(result.id_) then
              ten = "Bot Admin"
              tar = "ادمن في البوت 🐼"
            elseif is_owner(result.id_, msg.chat_id_) then
              ten = "Owner"
              tar = "مدير الكروب 🎐"
            elseif is_momod(result.id_, msg.chat_id_) then
              ten = "Group Admin"
              tar = "ادمن المجموعه🎌"
            elseif is_vipmem(result.id_, msg.chat_id_) then
              ten = "VIP Member"
              tar = "عضو مميز 💀"
            else
              ten = "Member"
              tar = "عـضـــو 🛩️"
            end
            if result.username_ then
              username = "@" .. result.username_
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              username = "Not Found"
            else
              username = "لا يوجد؟"
            end
            local fname = result.first_name_ or ""
            local lname = result.last_name_ or ""
            local name = fname .. " " .. lname
            local _nl, ctrl_chars = string.gsub(text, "%c", "")
            if string.len(name) > 40 or ctrl_chars > 70 then
              name = "---"
            end
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "📛 <b> Your Name</b> :\n <code> " .. name .. "</code>", 1, "html")
            else
              send(msg.chat_id_, msg.id_, 1, "📛 <b>اســمك </b> :\n<code> " .. name .. "</code> " , 1, "html")
            end
          end
          getUser(msg.sender_user_id_, get_me)
         end	
		if (idf:match("-100(%d+)") or is_momod(msg.sender_user_id_, msg.chat_id_)) and text:match("^رتبتي$") and msg.reply_to_message_id_ == 0 and check_user_channel(msg) then
          local get_me = function(extra, result)
            if tonumber(result.id_) == tonumber(karrar) then
        ten = "Sudo source 🍃"
              tar = "مطور السورس 🍃"
            elseif is_leaderid(result.id_) then
              ten = "Chief"
              tar = "مطور الاساسـي 🍃"
            elseif is_sudoid(result.id_) then
              ten = "Sudo"
              tar = "مطور 🐯"
            elseif is_admin(result.id_) then
              ten = "Bot Admin"
              tar = "ادمن في البوت 🐼"
            elseif is_owner(result.id_, msg.chat_id_) then
              ten = "Owner"
              tar = "مدير الكروب 🎐"
            elseif is_momod(result.id_, msg.chat_id_) then
              ten = "Group Admin"
              tar = "ادمن المجموعه🎌"
            elseif is_vipmem(result.id_, msg.chat_id_) then
              ten = "VIP Member"
              tar = "عضو مميز 💀"
            else
              ten = "Member"
              tar = "عـضـــو 🛩️"
            end
            if result.username_ then
              username = "@" .. result.username_
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              username = "Not Found"
            else
              username = "لا يوجد؟"
            end
            local fname = result.first_name_ or ""
            local lname = result.last_name_ or ""
            local name = fname .. " " .. lname
            local _nl, ctrl_chars = string.gsub(text, "%c", "")
            if string.len(name) > 40 or ctrl_chars > 70 then
              name = "---"
            end
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "📛 <b>Your Rank</b> : <code>" .. ten .. "</code>", 1, "html")
            else
              send(msg.chat_id_, msg.id_, 1, "📛 <b>رتبتــك </b> : <code>" .. tar .. "</code>" , 1, "html")
            end
          end
          getUser(msg.sender_user_id_, get_me)
        end
        local text = msg.content_.text_:gsub("اضافه", "Invite")
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") and text:match("^[Ii]nvite$") and msg.reply_to_message_id_ ~= 0 then
          local inv_reply = function(extra, result)
            add_user(result.chat_id_, result.sender_user_id_, 5)
          end
          getMessage(msg.chat_id_, msg.reply_to_message_id_, inv_reply)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ii]nvite @(%S+)$") then
          local ap = {
            string.match(text, "^([Ii]nvite) @(%S+)$")
          }
          local invite_by_username = function(extra, result)
            if result.id_ then
              add_user(msg.chat_id_, result.id_, 5)
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                texts = "✺⇓  User not <b>Found</b> 🎣 "
              else
                texts = "✺⇓  لا يوجد عضو 🐣"
              end
              send(msg.chat_id_, msg.id_, 1, texts, 1, "html")
            end
          end
          resolve_username(ap[2], invite_by_username)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ii]nvite (%d+)$") then
          local ap = {
            string.match(text, "^([Ii]nvite) (%d+)$")
          }
          add_user(msg.chat_id_, ap[2], 5)
        end
        if (idf:match("-100(%d+)") or is_momod(msg.sender_user_id_, msg.chat_id_)) and text:match("^[Ii]d$") and msg.reply_to_message_id_ == 0 and check_user_channel(msg) then
		  		  local getnameEN = function(extra, result)
		              if tonumber(result.id_) == tonumber(karrar) then
        ten = "Sudo source 🍃"
              tar = "مطور السورس 🍃"
            elseif is_leaderid(result.id_) then
              ten = "Chief"
              tar = "مطور الاساسـي 🍃"
            elseif is_sudoid(result.id_) then
              ten = "Sudo"
              tar = "مطور 🐯"
            elseif is_admin(result.id_) then
              ten = "Bot Admin"
              tar = "ادمن في البوت 🐼"
            elseif is_owner(result.id_, msg.chat_id_) then
              ten = "Owner"
              tar = "مدير الكروب 🎐"
            elseif is_momod(result.id_, msg.chat_id_) then
              ten = "Group Admin"
              tar = "ادمن المجموعه🎌"
            elseif is_vipmem(result.id_, msg.chat_id_) then
              ten = "VIP Member"
              tar = "عضو مميز 💀"
            else
              ten = "Member"
              tar = "عـضـــو 🛩️"
            end
            if result.username_ then
              username = "@" .. result.username_
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              username = "Not Found"
            else
              username = "لا يوجد؟"
            end
              local fname = result.first_name_ or ""
              local lname = result.last_name_ or ""
              local name = fname .. " " .. lname
              database:set("Nameuser:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, name)
            end
            getUser(msg.sender_user_id_, getnameEN)
            local _nl, ctrl_chars = string.gsub(text, "%c", "")
            local nm = database:get("Nameuser:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
            if 40 < string.len(nm) or ctrl_chars > 70 then
              name = "---"
            elseif 40 > string.len(nm) or ctrl_chars < 70 or string.len(name) == 40 or ctrl_chars == 70 then
              name = database:get("Nameuser:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
            end
            local getprofa = function(extra, result)
              if database:get("getidstatus" .. msg.chat_id_) == "Photo" then
                if result.photos_[0] then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_, "📛 Name : " .. name .. "\n\n🕹 User : " .. username .. "\n\n💡 Your ID : " .. msg.sender_user_id_ .. "\n\n📪 Your Rank: " .. ten .. " ", msg.id_, msg.id_)
                  else
                    sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_, "-  اسمـك 🍃 :-\n " .. name .. "\n\n- مــعرفـك 🎐 : " .. username .. "\n\n- ايديـك 🐿 : " .. msg.sender_user_id_ .. "\n\n- الرتبۿ 📪 : " .. tar .. " ", msg.id_, msg.id_)
                  end
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "* You don't have Profile photo* 🎈\n\n✸ Your Name : " .. name .. "\n✸ Your ID : `" .. msg.sender_user_id_ .. "`", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "انت لا تمتلك صوره لحسابك🎈\n\n-  اسمـك 🍃 :-\n " .. name .. "\n\n- مــعرفـك 🕹 : " .. username .. "\n\n- ايديـك 🐿: " .. msg.sender_user_id_ .. "\n\n- الرتبۿ 📪 : " .. tar .. " ", 1, "md")
                end
              end
              if database:get("getidstatus" .. msg.chat_id_) == "Simple" then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "✸ Your Name : " .. name .. "\n✸ Your ID : `" .. msg.sender_user_id_ .. "`", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "- * اسمـك* 🍃 :-\n  " .. name .. "\n\n- *ايديـك* 🐿:- \n`" .. msg.sender_user_id_ .. "`", 1, "md")
                end
              end
              if not database:get("getidstatus" .. msg.chat_id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "✸ Your Name : " .. name .. "\n✸ Your ID : " .. msg.sender_user_id_ .. "`", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "- * اسمـك* 🍃 :-\n  " .. name .. "\n\n- *ايديـك* 🐿:- \n`" .. msg.sender_user_id_ .. "`", 1, "md")
                end
              end
            end
			
            tdcli_function({
              ID = "GetUserProfilePhotos",
              user_id_ = msg.sender_user_id_,
              offset_ = 0,
              limit_ = 1
            }, getprofa, nil)
          end
        end
        if idf:match("-100(%d+)") or is_momod(msg.sender_user_id_, msg.chat_id_) then
          text = text:gsub("ايدي", "ايدي")
          if text:match("^ايدي$") and msg.reply_to_message_id_ == 0 and check_user_channel(msg) then
            local getnameEN = function(extra, result)
		              if tonumber(result.id_) == tonumber(karrar) then
        ten = "Sudo source 🍃"
              tar = "مطور السورس 🍃"
            elseif is_leaderid(result.id_) then
              ten = "Chief"
              tar = "مطور الاساسـي 🍃"
            elseif is_sudoid(result.id_) then
              ten = "Sudo"
              tar = "مطور 🐯"
            elseif is_admin(result.id_) then
              ten = "Bot Admin"
              tar = "ادمن في البوت 🐼"
            elseif is_owner(result.id_, msg.chat_id_) then
              ten = "Owner"
              tar = "مدير الكروب 🎐"
            elseif is_momod(result.id_, msg.chat_id_) then
              ten = "Group Admin"
              tar = "ادمن المجموعه🎌"
            elseif is_vipmem(result.id_, msg.chat_id_) then
              ten = "VIP Member"
              tar = "عضو مميز 💀"
            else
              ten = "Member"
              tar = "عـضـــو 🛩️"
            end
            if result.username_ then
              username = "@" .. result.username_
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              username = "Not Found"
            else
              username = "لا يوجد؟"
            end
              local fname = result.first_name_ or ""
              local lname = result.last_name_ or ""
              local name = fname .. " " .. lname
              database:set("Nameuser:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, name)
            end
            getUser(msg.sender_user_id_, getnameEN)
            local _nl, ctrl_chars = string.gsub(text, "%c", "")
            local nm = database:get("Nameuser:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
            if 40 < string.len(nm) or ctrl_chars > 70 then
              name = "---"
            elseif 40 > string.len(nm) or ctrl_chars < 70 or string.len(name) == 40 or ctrl_chars == 70 then
              name = database:get("Nameuser:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
            end
            local getprofa = function(extra, result)
              if database:get("getidstatus" .. msg.chat_id_) == "Photo" then
                if result.photos_[0] then
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_, "📛 Name : " .. name .. "\n\n🕹 User : " .. username .. "\n\n💡 Your ID : " .. msg.sender_user_id_ .. "\n\n📪 Your Rank: " .. ten .. " ", msg.id_, msg.id_)
                  else
                    sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_, "-  اسمـك 🍃 :-\n " .. name .. "\n\n- مــعرفـك 🎐 : " .. username .. "\n\n- ايديـك 🐿 : " .. msg.sender_user_id_ .. "\n\n- الرتبۿ 📪 : " .. tar .. " ", msg.id_, msg.id_)
                  end
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "* You don't have Profile photo* 🎈\n\n✸ Your Name : " .. name .. "\n✸ Your ID : `" .. msg.sender_user_id_ .. "`", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "انت لا تمتلك صوره لحسابك🎈\n\n-  اسمـك 🍃 :-\n " .. name .. "\n\n- مــعرفـك 🕹 : " .. username .. "\n\n- ايديـك 🐿: " .. msg.sender_user_id_ .. "\n\n- الرتبۿ 📪 : " .. tar .. " ", 1, "md")
                end
              end
              if database:get("getidstatus" .. msg.chat_id_) == "Simple" then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "✸ Your Name : " .. name .. "\n✸ Your ID : `" .. msg.sender_user_id_ .. "`", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "- * اسمـك* 🍃 :-\n  " .. name .. "\n\n- *ايديـك* 🐿:- \n`" .. msg.sender_user_id_ .. "`", 1, "md")
                end
              end
              if not database:get("getidstatus" .. msg.chat_id_) then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "✸ Your Name : " .. name .. "\n✸ Your ID : " .. msg.sender_user_id_ .. "`", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "- * اسمـك* 🍃 :-\n  " .. name .. "\n\n- *ايديـك* 🐿:- \n`" .. msg.sender_user_id_ .. "`", 1, "md")
                end
              end
            end
			
            tdcli_function({
              ID = "GetUserProfilePhotos",
              user_id_ = msg.sender_user_id_,
              offset_ = 0,
              limit_ = 1
            }, getprofa, nil)
          end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and msg.reply_to_message_id_ ~= 0 then
          text = text:gsub("ايدي", "ايدي")
          if (text:match("^[Ii]d$") or text:match("^ايدي$")) and check_user_channel(msg) then
            local id_by_reply = function(extra, result)
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "⇨ *User ID* : `" .. result.sender_user_id_ .. "`", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "🌀- <b>ايديــك</b> : <b>" .. result.sender_user_id_ .."</b>", 1, "html")
              end
            end
            getMessage(msg.chat_id_, msg.reply_to_message_id_, id_by_reply)
          end
        end
 local text = msg.content_.text_:gsub("جلب الصور", "Showprofilestatus")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ss]howprofilestatus (.*)$") and check_user_channel(msg) then
          local status = {
            string.match(text, "^([Ss]howprofilestatus) (.*)$")
          }
          if status[2] == "active" or status[2] == "مفعل" then
            if database:get("getpro:" .. msg.chat_id_) == "Active" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "🚦↓  Get Profile photo is \n *Already Actived* 🐣", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "🚦↓ <b>تـم تفعيــل جلــب الصــور </b> 💯", 1, "html")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "🚦↓  Get Profile photo has been \n Changed to *Active*🐥 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "🚦↓ <b>تـم تفعيــل جلــب الصــور </b> 💯", 1, "html")
              end
              database:set("getpro:" .. msg.chat_id_, "Active")
            end
          end
          if status[2] == "deactive" or status[2] == "معطل" then
            if database:get("getpro:" .. msg.chat_id_) == "Deactive" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "🚦↓  Get Profile photo is \n *Already  Deactived*🐔", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "🚦↓ <b>تـم تعطــيل جلــب الصــور </b> 💯", 1, "html")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "🚦 Get Profile photo has been \n Change to *Deactive* 🛰️", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "🚦↓ <b>تـم تعطــيل جلــب الصــور </b> 💯", 1, "html")
              end
              database:set("getpro:" .. msg.chat_id_, "Deactive")
            end
          end
        end
        local text = msg.content_.text_:gsub("صوره", "Getpro")
        if text:match("^[Gg]etpro (%d+)$") and check_user_channel(msg) then
          do
            local pronumb = {
              string.match(text, "^([Gg]etpro) (%d+)$")
            }
            local gproen = function(extra, result)
              if not is_momod(msg.sender_user_id_, msg.chat_id_) and database:get("getpro:" .. msg.chat_id_) == "Deactive" then
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "🛡️ Get Profile photo is *Deactive* 🚬", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "🚦↓ <b>جلــــب الصــور معطـــل من قبـل مديــر البــوت</b> 💯", 1, "html")
                end
              elseif pronumb[2] == "1" then
                if result.photos_[0] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "💡 *You don't Have Profile photo* 🕯️", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "💡 انت لا تمتلك صوره لحسابك💡", 1, "md")
                end
              elseif pronumb[2] == "2" then
                if result.photos_[1] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[1].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "💡 You don't have *2* Profile photo 🕯️", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "💡 انت لا تمتلك صوره 2 لحسابك💡", 1, "md")
                end
              elseif pronumb[2] == "3" then
                if result.photos_[2] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[2].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "💡You don't have *3* Profile photo 🕯️", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "💡 انت لا تمتلك صوره 3 لحسابك💡", 1, "md")
                end
              elseif pronumb[2] == "4" then
                if result.photos_[3] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[3].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "💡You don't have *4* Profile photo 🕯️", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "💡 انت لا تمتلك صوره 4 لحسابك💡", 1, "md")
                end
              elseif pronumb[2] == "5" then
                if result.photos_[4] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[4].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "💡You don't have *5* Profile photo 🕯️", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "💡 انت لا تمتلك صوره 5 لحسابك💡", 1, "md")
                end
              elseif pronumb[2] == "6" then
                if result.photos_[5] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[5].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "💡You don't have *6* Profile photo 🕯️", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "💡 انت لا تمتلك صوره 6 لحسابك💡", 1, "md")
                end
              elseif pronumb[2] == "7" then
                if result.photos_[6] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[6].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "💡You don't have *7* Profile photo 🕯️", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "💡 انت لا تمتلك صوره 7 لحسابك💡", 1, "md")
                end
              elseif pronumb[2] == "8" then
                if result.photos_[7] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[7].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "💡You don't have *8* Profile photo 🕯️", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "💡 انت لا تمتلك صوره 8 لحسابك💡", 1, "md")
                end
              elseif pronumb[2] == "9" then
                if result.photos_[8] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[8].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "💡You don't have *9* Profile photo 🕯️", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "💡 انت لا تمتلك صوره 9 لحسابك 💡", 1, "md")
                end
              elseif pronumb[2] == "10" then
                if result.photos_[9] then
                  sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[9].sizes_[1].photo_.persistent_id_)
                elseif database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "💡You don't have *10* Profile photo 🕯️", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "💡انت لا تمتلك صوره 10 لحسابك💡", 1, "md")
                end
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "✪↓  I just can Get last `10` Profile photos 🎏", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "✪↓  يمكن جلب اول 10 صور فقط 🎏", 1, "md")
              end
            end
            tdcli_function({
              ID = "GetUserProfilePhotos",
              user_id_ = msg.sender_user_id_,
              offset_ = 0,
              limit_ = pronumb[2]
            }, gproen, nil)
          end
        else
        end
		local text = msg.content_.text_:gsub('ضع تكرار','set flood')
	if text:match("^set flood (%d+)$") and is_owner(msg.sender_user_id_, msg.chat_id_) then
	local floodt = {string.match(text, "^(set flood) (%d+)$")} 
	if tonumber(floodt[2]) < 1 then
                if database:get('lang:gp:'..msg.chat_id_) then

         send(msg.chat_id_, msg.id_, 1, '*Wrong number range is*  [5-200]', 1, 'md')
       else 
           send(msg.chat_id_, msg.id_, 1, 'Ⓜ️↓ ضع عدد م <b>[1]</b> الى <b>[200]</b> ', 1, 'html')
end
	else
    database:set('flood:time:'..msg.chat_id_,floodt[2])

                if database:get('lang:gp:'..msg.chat_id_) then

         send(msg.chat_id_, msg.id_, 1, '🕹- Flood has been set : *'..floodt[2]..'*', 1, 'md')
       else 
         send(msg.chat_id_, msg.id_, 1, '🕹- <code>تــم وضـــــع  التكرار </code>: <b>'..floodt[2]..'</b>', 1, 'html')
end
	end
	end
				if text:match("^[Gg]roups$") and is_admin(msg.sender_user_id_, msg.chat_id_) or text:match("^المجموعات$") and is_admin(msg.sender_user_id_, msg.chat_id_) then

    local gps = database:scard("bot:groups")

	local users = database:scard("bot:userss")

    local allmgs = database:get("bot:allmsgs")

                if database:get('lang:gp:'..msg.chat_id_) then

                   send(msg.chat_id_, msg.id_, 1, '📣↓ *Groups :* `'..gps..'`', 1, 'md')
                 else
                   send(msg.chat_id_, msg.id_, 1, '📣↓ <code>عـدد المجموعــات</code> : <b>'..gps..'</b>', 1, 'html')
end
	end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Ll]ock (.*)$") or text:match("^قفل (.*)$")) and check_user_channel(msg) then
          local lockpt = {
            string.match(text, "^([Ll]ock) (.*)$")
          }
          local lockptf = {
            string.match(text, "^(قفل) (.*)$")
          }
          if lockpt[2] == "edit" or lockptf[2] == "التعديل" then
            if not database:get("editmsg" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  *Lock edit has been Activated* 🎐", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1,"💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ قفل التعديل🖇️📍", 1, "md")
              end
              database:set("editmsg" .. msg.chat_id_,'delmsg', true)
              database:del("sayedit" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓ * Lock edit is Already Activated*🎐 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ قفل التعديل🖇️📍 ", 1, "md")
            end
          end
          if lockpt[2] == "cmd" or lockptf[2] == "الاوامر" then
            if not database:get("bot:cmds" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Case of no answer has been *Enable* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ قفل الاوامر🔧📍  ", 1, "md")
              end
              database:set("bot:cmds" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Case of no answer is *Already* enable 📍", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ قفل الاوامر🔧📍 ", 1, "md")
            end
          end
          if lockpt[2] == "bots" or lockptf[2] == "البوتات" then
            if not database:get("bot:bots:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock bots has been *Activated* 👾 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ قفل البوتات 👾📍 ",  1, "md")
              end
              database:set("bot:bots:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock bots is *Already* enable 👾 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ قفل البوتات👾📍 ", 1, "md")
            end
          end
          if lockpt[2] == "flood" or lockptf[2] == "التكرار" then
            if not database:get("anti-flood:" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock flood has been *Activated* 🚀  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ قفل التكرار🎗️📍  ", 1, "md")
              end
              database:set("anti-flood:" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock flood is *Already* enable 🚀  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ قفل التكرار🎗️📍  ", 1, "md")
            end
          end
          if lockpt[2] == "pin" or lockptf[2] == "التثبيت" then
            if not database:get("bot:pin:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock pin has been *Activated* 🚏 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ قفل التثبيت🚏📍  ", 1, "md")
              end
              database:set("bot:pin:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock pin is *Already* enable 🚏 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ قفل التثبيت🚏📍  ", 1, "md")
            end
          end
        end
        local text = msg.content_.text_:gsub("ضع تكرار", "Floodstatus")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ff]loodstatus (.*)$") and check_user_channel(msg) then
          local status = {
            string.match(text, "^([Ff]loodstatus) (.*)$")
          }
          if status[2] == "remove" or status[2] == "بالطرد" then
            if database:get("floodstatus" .. msg.chat_id_) == "Kicked" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "⇛ Flood status is *Already* on Kicked †", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "✸ تم وضع التكرار بالطرد 🐣 ", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "⇛ Flood status change to *Kicking*♩ ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "✸ تم وضع التكرار بالطرد 🎐 ", 1, "md")
              end
              database:set("floodstatus" .. msg.chat_id_, "Kicked")
            end
          end
          if status[2] == "del" or status[2] == "بالمسح" then
            if database:get("floodstatus" .. msg.chat_id_) == "DelMsg" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "※ Flood status is *Already* on Deleting ✞", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "※ تم وضع التكرار بالمسح 📵❗️  ", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "※  Flood status has been change to *Deleting* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "※ تم وضع التكرار بالمسح 📵❗️  ", 1, "md")
              end
              database:set("floodstatus" .. msg.chat_id_, "DelMsg")
            end
          end
        end
        local text = msg.content_.text_:gsub("ضع تحذير", "Setwarn")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ss]etwarn (%d+)$") and check_user_channel(msg) then
          local warnmax = {
            string.match(text, "^([Ss]etwarn) (%d+)$")
          }
          if 2 > tonumber(warnmax[2]) or tonumber(warnmax[2]) > 30 then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "⛔️ Enter a number greater than 2 and smaller than 30 ‼️", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "⛔️ يمكنك وضع تحذير من (2-30) 🔱", 1, "md")
            end
          else
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "🔰 Warning *Number* Change to `" .. warnmax[2] .. "` ‼️", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "🔰 تم وضع التحذير : " .. warnmax[2] .. " ⚜️ ", 1, "md")
            end
            database:set("warn:max:" .. msg.chat_id_, warnmax[2])
          end
        end
        local text = msg.content_.text_:gsub("ضع تحذير", "Warnstatus")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ww]arnstatus (.*)$") and check_user_channel(msg) then
          local status = {
            string.match(text, "^([Ww]arnstatus) (.*)$")
          }
          if status[2] == "mute" or status[2] == "بالكتم" then
            if database:get("warnstatus" .. msg.chat_id_) == "Muteuser" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "🔅↓ Warning status is *Already* on Mute User ✞", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "🔅↓ تم وضع التحذير بالكتم", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "🔅↓ Warning status has been Changed to *Mute User* ♩", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "🔅↓ تم وضع التحذير بالكتم ♩ ", 1, "md")
              end
              database:set("warnstatus" .. msg.chat_id_, "Muteuser")
            end
          end
          if status[2] == "remove" or status[2] == "بالطرد" then
            if database:get("warnstatus" .. msg.chat_id_) == "Remove" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "🔅↓ Warning status is *Already* on Remove User ♩", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "🔅↓ تم وضع تحذير بالطرد 🏌️ ", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "🔅↓  Warning status has been Changed to *Remove User* ✞", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "🔅↓ تم وضع تحذير بالطرد🎋 ", 1, "md")
              end
              database:set("warnstatus" .. msg.chat_id_, "Remove")
            end
          end
        end
        local text = msg.content_.text_:gsub("الايدي", "Showidstatus")
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ss]howidstatus (.*)$") and check_user_channel(msg) then
          local status = {
            string.match(text, "^([Ss]howidstatus) (.*)$")
          }
          if status[2] == "photo" or status[2] == "بالصوره" then
            if database:get("getidstatus" .. msg.chat_id_) == "Photo" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ Get id status is *Already* on Photo ✞", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "🌀↓ <b>تــم تفعــيل الايــدي بالــصور عزيزي </b>🎐", 1, "html")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "➢ Get ID status has been Changed to *Photo* ✞", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "🌀↓ <b>تــم تفعــيل الايــدي بالــصور عزيزي </b>🎐 ", 1, "html")
              end
              database:set("getidstatus" .. msg.chat_id_, "Photo")
            end
          end
          if status[2] == "simple" or status[2] == "بالعدد" then
            if database:get("getidstatus" .. msg.chat_id_) == "Simple" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💡 Get ID status is *Already* on Simple 🏌️", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "🌀↓ <b>تــم تعطيــل الايــدي بالــصور عزيزي </b>🎐", 1, "html")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💡 Get ID status has been Change to *Simple* 🏌️", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "🌀↓ <b>تــم تعطيــل الايــدي بالــصور عزيزي </b>🎐", 1, "html")
              end
              database:set("getidstatus" .. msg.chat_id_, "Simple")
            end
          end
        end
        local text = msg.content_.text_:gsub("الخروج التلقائي", "Autoleave")
        if is_sudo(msg) and text:match("^[Aa]utoleave (.*)$") then
          local status = {
            string.match(text, "^([Aa]utoleave) (.*)$")
          }
          if status[2] == "مفعل" or status[2] == "on" then
            if database:get("autoleave") == "On" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "⚜️ Auto Leave is *now Active* ❗️", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "✧↲ تم تفعيل الخروج التلقائي🎐 ", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "⚜️ Auto Leave has been *Actived* ❗️", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "✧↲ تم تفعيل الخروج التلقائي🎐", 1, "md")
              end
              database:set("autoleave", "On")
            end
          end
          if status[2] == "معطل" or status[2] == "off" then
            if database:get("autoleave") == "Off" then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "⚜️ Auto Leave is *now Deactive* ❗️", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "✧↲ تم تعطيل الخروج التلقائي للبوت✞ ", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "⚜️ Auto leave has been *Deactived* ❗️", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "✧↲ تم تعطيل الخروج التلقائي للبوت✞", 1, "md")
              end
              database:set("autoleave", "Off")
            end
          end
        end
        if is_leader(msg) then
          local text = msg.content_.text_:gsub("[Ss]etprice", "Setnerkh")
          if text:match("^[Ss]etnerkh$") or text:match("^وضع كليشه المطور$") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "※  Plese Send your now 🎣 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "🌀↓ <b>ارســل لــي كليــشه المطــور الان </b>⚜️", 1, "html")
            end
            database:setex("bot:nerkh" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 100, true)
          end
        end
        if (msg.sender_user_id_) then
          local text = msg.content_.text_:gsub("[Pp]rice", "Nerkh")
          if text:match("^[Nn]erkh$") or text:match("^المطور$") then
            local nerkh = database:get("nerkh")
            if nerkh then
              send(msg.chat_id_, msg.id_, 1, nerkh, 1, "html")
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💡 Bot not found 🎐", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, " ", 1, "md")
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Ss]etlink$") or text:match("^ضع رابط$")) and check_user_channel(msg) then
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "▫️↓  Plese Send your *Group link* now 🎐", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "▫️↓ <b>ارســــل لي الرابط الان </b>🎐", 1, "html")
          end
          database:setex("bot:group:link" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 120, true)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Dd]ellink$") or text:match("^حذف الرابط$")) and check_user_channel(msg) then
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "▫️↓  *Group Link* Has Been *Cleared* 📍 ", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "▫️↓  تم حذف الرابط بنجاح✅", 1, "md")
          end
          database:del("bot:group:link" .. msg.chat_id_)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Ll]ink$") or text:match("^الرابط$")) and check_user_channel(msg) then
          local link = database:get("bot:group:link" .. msg.chat_id_)
          if link then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢<b>Group link</b> ⇩\n\n" .. link, 1, "html")
            else
              send(msg.chat_id_, msg.id_, 1, "⛔️- <b>رابط المجموعه </b>⇩\n\n" .. link, 1, "html")
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "✧↳ *Group link* is not set  \n Plese send command *Setlink* and set it✞", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "※↓ لم يتم وضع الرابط \n ارسل ضع رابط الان♩",  1, "md")
          end
        end
        if is_admin(msg.sender_user_id_) then
          msg.content_.text_ = msg.content_.text_:gsub("جلب الرابط", "Getlink")
          if text:match("^[Gg]etlink(-%d+)$") then
            local ap = {
              string.match(text, "^([Gg]etlink)(-%d+)$")
            }
            local tp = tostring(ap[2])
            getGroupLink(msg, tp)
          end
        end
        if is_sudo(msg) and text:match("^[Aa]ction (.*)$") then
          local lockpt = {
            string.match(text, "^([Aa]ction) (.*)$")
          }
          if lockpt[2] == "text" then
            sendaction(msg.chat_id_, "Typing")
          end
          if lockpt[2] == "video" then
            sendaction(msg.chat_id_, "RecordVideo")
          end
          if lockpt[2] == "voice" then
            sendaction(msg.chat_id_, "RecordVoice")
          end
          if lockpt[2] == "photo" then
            sendaction(msg.chat_id_, "UploadPhoto")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ff]ilter (.*)$") and check_user_channel(msg) then
          local filters = {
            string.match(text, "^([Ff]ilter) (.*)$")
          }
          local name = string.sub(filters[2], 1, 50)
          local hash = "bot:filters:" .. msg.chat_id_
          if filter_ok(name) then
            database:hset(hash, name, "newword")
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "● ◄  Word `[" .. name .. "]` has been *Filtered* 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "● ◄  الكلمه<b>〖  " .. name .. "  〗</b>\n\n● ◄ تم ✅ منعها📍  ", 1, "html")
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "✱↓  Word `[" .. name .. "]` Can Not *Filtering* 🚀 ", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "✱↓  الكلمه <b>[ " .. name .. " ]</b> \n لا استطيع منعها❌", 1, "html")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^منع (.*)$") and check_user_channel(msg) then
          local filterss = {
            string.match(text, "^(منع) (.*)$")
          }
          local name = string.sub(filterss[2], 1, 50)
          local hash = "bot:filters:" .. msg.chat_id_
          if filter_ok(name) then
            database:hset(hash, name, "newword")
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "● ◄  Word `[" .. name .. "]` has been *Filtered* 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "● ◄  الكلمه<b>〖  " .. name .. "  〗</b>\n\n● ◄ تم ✅ منعها📍 ", 1, "html")
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "✱↓  Word `[" .. name .. "]` Can Not *Filtering* 🎈 ", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "✱↓  الكلمه <b>[ " .. name .. " ]</b> \n لا استطيع منعها❌", 1, "html")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ff]ilter$") and check_user_channel(msg) then
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "● ◄  Please *Submit* The Words You Want To *Filter* Individually 📍 \nTo *Cancel The Command*, Send The /cancel Command 🎈 ", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "● ◄  <b>ارسل لي الكلمات التي </b>\n\n<code>تريد منعها بشكل فردي🎈</code> \n\n لٱلغاء الامر ارسل <b>الغاء</b> 🎐", 1, "html")
          end
          database:setex("Filtering:" .. msg.sender_user_id_, 80, msg.chat_id_)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^منع$") and check_user_channel(msg) then
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "● ◄  Please *Submit* The Words You Want To *Filter* Individually 🎈\nTo *Cancel The Command*, Send The /cancel Command 🎈", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "● ◄  <b>ارسل لي الكلمات التي </b>\n\n<code>تريد منعها بشكل فردي🎈</code> \n\n لٱلغاء الامر ارسل <b>الغاء</b> 🎐", 1, "html")
          end
          database:setex("Filtering:" .. msg.sender_user_id_, 80, msg.chat_id_)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Uu]nfilter (.*)$") and check_user_channel(msg) then
          local rws = {
            string.match(text, "^([Uu]nfilter) (.*)$")
          }
          local name = string.sub(rws[2], 1, 50)
          local cti = msg.chat_id_
          local hash = "bot:filters:" .. msg.chat_id_
          if not database:hget(hash, name) then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "● ◄  Word `[ " .. name .. " ]` is *not in Filterlist* 🎣 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "● ◄  الكلمه<b>〖  " .. name .. "  〗</b>\n\n● ◄  تم الغاء منعها📍 ", 1, "html")
            end
          else
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "● ◄  Word `[ " .. name .. " ]` *Removed* from Filterlist 🚀 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "● ◄  الكلمه<b>〖  " .. name .. "  〗</b>\n\n● ◄  تم الغاء منعها📍", 1, "html")
            end
            database:hdel(hash, name)
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^الغاء منع (.*)$") and check_user_channel(msg) then
          local rwss = {
            string.match(text, "^(الغاء منع) (.*)$")
          }
          local name = string.sub(rwss[2], 1, 50)
          local cti = msg.chat_id_
          local hash = "bot:filters:" .. msg.chat_id_
          if not database:hget(hash, name) then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "● ◄  Word `[ " .. name .. " ]` is *not in Filterlist* 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "● ◄  الكلمه<b>〖  " .. name .. "  〗</b>\n\n● ◄  تم الغاء منعها📍", 1, "html")
            end
          else
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "● ◄  Word `[ " .. name .. " ]` *Removed* from Filterlist 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "● ◄  الكلمه<b>〖  " .. name .. "  〗</b>\n\n● ◄  تم الغاء منعها📍", 1, "html")
            end
            database:hdel(hash, name)
          end
        end
if text ==   'السلام عليكم'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b>  ﻭ୭ ؏ـليكـمہ آلـسـ﴿﴾ـلآمہ ﻭ୭رحــمة اللّــھہّ˛❥ ٰﻭ୭بـرڪاته</b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'هلاو'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> هـِّـ﴿💜﴾ـلاواتہ 💭🙋 ؏ـيـﻭ୭نـــًّ‏ِـِّـي نــ💡ـﻭ୭رت♩ </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'هلو'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> هـِّـ﴿💜﴾ـلاواتہ 💭🙋 ؏ـيـﻭ୭نـــًّ‏ِـِّـي نــ💡ـﻭ୭رت♩ </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'شلونك'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b>  تُمـ😌﴾ـُُ℘ـامُُہٰ &ٰ آٳنـہتۦ ֆ. شَـşђɭǫǫŋeķـلُوٍنّگٍ ••»؟</b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'شلونج'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> تمـُ﴿😌﴾ـُُ℘ـامُُہٰ &ٰ آٳنـہتۦ ֆ. شَـşђɭǫǫŋeķـلُوٍنّگٍ ••»؟ </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'شلونكم'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> مـُُ﴿😌﴾ـُُ℘ـامُُہٰ &ٰ آٳنـہتۦ ֆ. شَـşђɭǫǫŋeķـلُوٍنّگٍ ••»؟ </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'كيفكم'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> منـۘـيــۘ❈ـحيـ‏ـৡـن 🍃 </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'اكرهك'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b>مـⴅỹــي تـtoـو. & آٌنـ﴿ّℳέ﴾ـّي امـ℘ـوت ؏ـليـك/ﺞ✟♩🍃</b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'ههههههه'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b>  دوه୭ ومـــہٰ۪ الضـحڪٰ۪هــہ↵🌸💛››</b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'هههههههههه'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b>  دوه୭ ومـــہٰ۪ الضـحڪٰ۪هــہ↵🌸💛›› </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'هههه'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b>  دوه୭ ومـــہٰ۪ الضـحڪٰ۪هــہ↵🌸💛›› </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'صباحو'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> صبـٰٖـٰٖ‏ـٳاٲඋ ٰۦٳٲلـِخٰٖـٰٖـ๋͜ـِـيرات يـرﻭ୭حـي ٰۦ˛⁽˛⁽😻💗₎⇣ </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'صباح الخير'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> صبـٰٖـٰٖ‏ـٳاٲඋ ٰۦٳٲلـِخٰٖـٰٖـ๋͜ـِـيرات يـرﻭ୭حـي ٰۦ˛⁽˛⁽😻💗₎⇣ </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   '🌚'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> مۢنٰـۛмєnoـٰوٰﯟ ر ֆ‘ ٳصہخہام الجہدر 🌚🍃 </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'شكو ماكو'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> غـﹻۧ͡℘ـٌيـٰٖــٰٖرڰ ٴ بۛالګلب مہآڪہﯛ ⇣  يرۣﯢζـي </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   '😁'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> بـ👁ـا؏ الـسـنون جنــৡـهن دگم </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   '😁😁'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> بـ👁ـا؏ الـسـنون جنـ‏ـৡـهن دگم </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'بوت'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> عـٰٰـٰود لوتُٰي 🙀 يـٰگول بُِوت عبالـٰه طافٰـُٰي💔 ويضِٰل يمٰـٓسلت وينشٰٰر روابـٰٓط 😳🍃 </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'اتفل'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> خخـ﴿😚﴾ـخ تـ﴿💦﴾ـفوو خخـ﴿😚﴾ـخ تـ﴿💦﴾ـفوو خہــ💦ــخــ💦ـــــہٰٰخ تٌـٌـٌـٌ﴿💦﴾ـٌـٌـٌـٌف✟خــ😚ــخــ😚ـخ تــ💦ــفــ💦ــوو خخخخــووــووــووــوو💦💨😚تفــووــو😹😹 </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'هدى'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> (صٌِـــوتهٌ، صفٌاتهٌ، ضِّـــحكتّهُّ...احلْى شيٌ بالدٌنياْ)🙈😻☝️ </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'فطم'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> اوٌيليْ لك ٌ ضحٌكتهٌ تسوْه الدنٌيا وٌما ُبيههّ😻☝️ </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'شهد'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> ••• اوُٓيٌــلــيْ لكُٰ هاُي تٰٰــــاُجْ 👑 وعِــلٰم شُحٰــدهٰ الــيندٰگ بيٰهه•••😍😻☝️ </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'بوسه'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> خٌِـــايب گـم 😂 يريد بوسهْ وجه القرْد🐵😹😹🙌 </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
				if text ==   'باي'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b>  بٰـہٰٖاٰيٰـہٰٖاٰتٰـہٰٖ   عٰـہٰٖمٰـہٰٖرٰيٰـہٰٖ ﴿🙊💗 </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
								if text ==   'جاو'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b>  جٰـہٰٖاٰوٰاٰتٰـہٰٖ  حٰـہٰٖيٰـہٰٖاٰتٰـہٰٖيٰـہٰٖ 💙🙈</b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'بوسني'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> مْـواحْ💋 نسخْ لصقْ ع الشفهٌْ 🙈 </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'غازلني'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> راح اُحـــط شِفتـِــي 💋 علـٌِ شفتٌِــك 💋 وشُُـــبَع ْ من الـ شفِـفهٌ  ضُوگ😋 راحُ اجرٰبيه عٰ لـ كيفّـي 🙀 والا  اخلــي الُجوُه فوٰگ 😹😻☝️ </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'تخليني'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> اٌيــــُـــــي حبيْ اخُــــليكْ عْـــِلوااا 😔 اليْوم تعْبــانْ انيَ ٌهـٰٰـٰـٰـــاكْ 🐑🐏🐑🐄🐄 اسُْــــرح بيهنْ بــسٰ ديــرْ بالكْ عليِـــ💋ــهن فدِوه موْ تصْير اْثولَ 🙊وتيــهْم😻😹😹☝️ </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   '🤔🤔'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> الحمد لله 😔 راح تنلاص المشكله😿 بالزايد كام يفكر😂🍃 </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   '😳😳'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> شبيك 🙀 مصدوم شنو 🙄 جديده عليك حتى تنصدم ♥️🍃 </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   '🤔'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> على كيفك يترامب😹🍃 </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'فديتك'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> فٰـہٰٖدٰاٰكٰـہٰٖ كٰـہٰٖوٰنٰـہٰٖ وٰقٰـہٰٖوٰاٰطٰـہٰٖيٰـہٰٖ مٰـہٰٖعٰـہٰٖجٰـہٰٖوٰنٰـہٰٖ وٰزٖاٰهٰـہٰٖيٰـہٰٖ وٰلـہٰٖفٰـہٰٖاٰفٰـہٰٖوٰنٰـہٰٖ ➤|💨ֆ🌪 </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'اكلك'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> كٰـہٰٖوٰلـہٰٖ مٰـہٰٖاٰكٰـہٰٖوٰلـہٖ ℠⁽“ֆ🍃🌙ᴖ </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'احبكم'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> ٰـہٰٖدٰ يٰـہٰٖحٰـہٰٖبٰـہٰٖكٰـہٰٖ لـہٰٖتٰـہٰٖزٖحٰـہٰٖفٰـہٰٖ 💥۶ֆ⌯﴾❥ </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'احبك'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b>يٰـہٰٖمٰـہٰٖهٰـہٰٖ اٰعٰـہٰٖشٰـہٰٖقٰـہٰٖكٰـہٰٖ ₎❉ </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'مشتاقلك'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> اٰنٰـہٰٖيٰـہٰٖ اٰكٰـہٰٖثٰـہٰٖرٰ  ⁽࿑♚  </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'لا' then
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> ٰٖانجٰـہٰٖبٰـہٰٖ اٰيٰـہٰٖ 💥۶ֆᵛ͢ᵎᵖ </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   '😘'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> ٰعـہٰٖسٰـہٰٖلـہٰٖ حٰـہٰٖيٰـہٰٖاٰتٰـہٰٖيٰـہٰٖ ⁽🕸🦊↡₎℠</b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   '😑'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b>  شٰـہٰٖكٰـہٰٖوٰ شٰـہٰٖبٰـہٰٖيٰـہٰٖكٰـہٰٖ ✾♛💛¡⌯﴾❥  </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   '😍'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> شٰـہٰٖوٰفٰـہٰٖ الحٰـہٰٖبٰـہٰٖ وٰاٰنٰـہٰٖيٰـہٰٖ حٰـہٰٖدٰيٰـہٰٖقٰـہٰٖهٰـہٰٖ ₎⇣۶ֆ🐿✿ ⁞  </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'رنا'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> 🙄😂كلهم جبس باتو بٍْـßẳȘـﺴٍْﮧ✋️ ﭐﻧـ℘ـتـ✮๋͜‏ٓـي ٴ ͢⁽✨☻₎♤ جبس ليز </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'غيث'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> مٰـہٰٖطٰـہٰٖوٰرٰيٰـہٰٖ عٰـہٰٖشٰـہٰٖقٰـہٰٖ ضٰـہٰٖلـہٰٖعٰـہٰٖ اٰلـہٰٖقٰـہٰٖيٰـہٰٖصٰـہٰٖرٰ ║💙😻🙈</b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'زينا'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> - شٰـہٰٖحٰـہٰٖلـہٰٖاٰتٰـہٰٖ. اٰسٰـہٰٖمٰـہٰٖهٰـہٰٖ ⁽🕸🦊↡₎℠ </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'شغال'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b>  اٰيٰـہٰٖ   شٰـہٰٖغٰـہٰٖاٰلـہٰٖ ♛⇣🐰☄️₎✦ </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   '😂😂'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> كٰـہٰٖاٰفٰـہٰٖيٰـہ  ٰٖ ضٰـہٰٖحٰـہٰٖكٰـہٰٖ ₎⌯﴾🙊💙❁ </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end

if text ==   '🌝'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b>  عٰـہٰٖوٰدٰ نٰـہٰٖضٰـہٰٖيٰـہٰٖفٰـہٰٖ اٰلـہٰٖوٰصٰـہٰٖخٰـہٰٖ ║♜💛⚡️₎⇣✿ ⁞  </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
if text ==   'كيبر'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b> اٰٰي كيـٰٰبـــــــر تُفــــــظـٰٰــــل 🌝🍃 </b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
	if text ==   'القيصر'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<code> شُـٰٰـٰــــرايــد مُــــــٰٰـٰٰـنــه 🌚🍃 </code>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
					if text ==   'كرار'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<code> شُـٰٰـٰــــرايــد مُــــــٰٰـٰٰـنــه 🌚🍃 </code>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end
					if text ==   'رامي'   then 
if not database:get('bot:rep:mute'..msg.chat_id_) then
				keeper = "<b>  ضٰـہٰٖلـہٰٖعٰـہٰٖ كٰـہٰٖرٰاٰرٰ  اٰلـہٰٖسٰـہٰٖوٰرٰيٰـہٰٖ فٰـہٰٖدٰيٰـہٰٖتٰـہٰٖهٰـہٰٖ  ⁽🔱₎ֆ﴾</b>"
else 
                keeper = ''  
end
send(msg.chat_id_, msg.id_, 1, keeper, 1, 'html')
end

if text:match("^رابط حذف$") or text:match("^رابط الحذف$") or text:match("^اريد رابط الحذف$") or  text:match("^رايد احذف حسابي$") or text:match("^اريد رابط حذف$") then
   
   local text =  [[
<b>🎌 رابــط الحذف 🎌</b>
ﮧ━━━━━━━ﮧ
<code>✺. خليــك زلمۿ ابظــاي
واحذف حسابك 😹</code>
ﮧ━━━━━━━ﮧ
✺.<b> الرابــط</b> : https://telegram.org/deactivate 
]]
                send(msg.chat_id_, msg.id_, 1, text, 1, 'html')
end 
		if text:match("^السورس$") or text:match("^مطور السورس$") or text:match("^ياسورس$") or  text:match("^سورس كيبر$") or text:match("^اريد سورس$") then
   
   local text =  [[
<b>(اهــلاً بـك فــي سورس كيـبر)</b> 🍃

<b>(السورس من تطوير🎣 )</b>:

																																																
<code>▪️آلقہٰٰيِٰہٰٰصۛہٰٰڕٰ </code> : @llX8Xll
<code>▫️تواصــل </code> : @lqlxlqlbot

																																																
<b>(رابط حساب Github ):</b> 📣

- https://github.com/alqaser/KEEPER



]]
                send(msg.chat_id_, msg.id_, 1, text, 1, 'html')
end 																																													
				if text:match("^الاوامر$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
   
   local text = [[
					
<b>ﭑهلإ بــك في سورس KEEPER🏌️</b>
ﮧ━─────────━ﮧ
<code>※ الآوامر كالتالــــي : - 

🎌⇣ م1 :  لعرض اوامر الحمايــۿ ⛓️

🎌⇣ م2 : لــعرض اوامر الرفــــــع 🚀

🎌⇣م3 :لعرض اوامر الحظر والمسح🎐

🎌⇣ م4 : لعــرض اوامر الاخرى 🕰️

🎌⇣ م5 : لعرض اوامر المطور 🎎

🎌⇣ م6 : لعرض الاوامر الثانيه 📻</code>


]]
                send(msg.chat_id_, msg.id_, 1, text, 1, 'html')
   end 
   if text:match("^م1$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
   
   local text = [[
<b>ﭑهلإ بــك في سورس KEEPER🏌️
ﮧ━─────────━ﮧ
※ الآوامر الحمايۿ كالتالي :- 
《 استخدم (قفل\فتح) + الامر 》

▫ الروابــط  : الدردشــه
 🖇️
 
▪️ الصــور  : الفيديــو
 📝
 
🔹 المتحركـــه  : التعديـــل
 🖼️
 
🔸 الاوامــر  : المواقع
 📹
 
▫️ البوتــات  : التثبيـــت 
🗺️

▪️ التوجيــه  : العربيــه
 🔧
 
🔹 التكــرار  : الانكليزيــه
 🕹️
 
🔸 التــاك  : اشعارات الدخول
 🎛️

▫️ الصــوت  : الاغانــي
 👾
 
▪️ الاتصــال  : السلفــي 🏋️

ﮧ---------------------ﮧ
🔰 قفل المجموعه بالوقت : لقفلها بالوقت ⏰
⛔️ فتح المجموعه بالوقت : لفتحها 💾

⚙️ ضع وقت : لوضع وقت قفل المجموعه ⏱️
📪 قفل المجموعه + الساعه+ الدقيقه+ الثانيه: 
لقفلها ✔️

⛓ قفل المجموعه + الساعه + الدقيقه : لقفلها¶
🛡 قفل المجموعه + الساعه : لقفلها ® </b>
 
]]
                send(msg.chat_id_, msg.id_, 1, text, 1, 'html')
   end  
if text:match("^م2$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
   
   local text = [[
<b>ﭑهلإ بــك في سورس KEEPER🏌️
ﮧ━─────────━ﮧ
※ اوامر الرفع كالتالي :- 
《 تستخدم بالرد او بالايدي 》√

① رفع المدير : لرفع مدير المجموعه 🗜️

② تنزيل المدير : لتنزيل المدير 🚀

③ رفع مطور : لرفع مطور في البوت 🎐

④ تنزيل مطور : لتنزيل المطور 🗿

⑤ رفع ادمن : رفع العضو ادمن 🌡️

⑥ تنزيل ادمن : لتنزيل العضو 🛋️

⑦ رفع عضو مميز : لآضافته للمميزين 📯

⑧ تنزيل عضو مميز :لتنزيله من المميزين🎣

⑨ اضف ادمن : لاضافة العضو ادمن 🕴️

⑩ حذف ادمن : لحذف العضو 🏅</b>
ﮧ━━━━━━━━━━━━━━━━ﮧ
<code>🔖 ضع تكرار + العدد : لوضع تكرار⌚️

🔖 ضع تكرار بالطرد: لوض التكرار بالطرد🛠️

🔖 ضع تكرار بالمسح : لوضعه بالمسح 📡

🔖 ضع تحذير + العدد : لوضع تحذير 🔬

🔖 ضع تحذير بالكتم : لوضع التحذير بالكتم ⌨️

🔖ضع تحذير بالطرد : لوضع التحذير بالطرد 💸</code>
 
]]
                send(msg.chat_id_, msg.id_, 1, text, 1, 'html')
   end
  if text:match("^م3$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
   
   local text = [[
<b>ﭑهلإ بــك في سورس KEEPER🏌️
ﮧ━─────────━ﮧ
※ اوامر الحظر والمسح كالتالي : - 
〈 تستخدم بالرد او بالايدي〉√

※- حظر  : لحضر العضو 📢

※- الغاء حظر : لٱلغاء الحظر عن العضو 🛋️
※- حظر عام : لحظر العضو عام 📺

🔹- الغاء العام : لٱلغاء العام منه 🔋
▫️- كتم : لكتم العضو  🔇

🔹- الغاء كتم : لٱلغاء كتم العضو 📵
▪️- طرد : لطرد العضو ⚜️

▫️- كتم + ساعه +الدقيقه+ الثانيه :-
لكتم العضو بالوقت ♩ </b>
ﮧ━━━━━━━━━━━━━━━ﮧ
<b>〖 اوامر المسح √ 〗 :-
استخدم مسح + الامر : 🍃

▪️-  الادمنيه : المكتومين
🎐

▫️-  المحضورين : قائمه العام
 ⚜️
 
✰-  البوتات : الاعضاء
 🎈
  
☆-  قائمه المنع : المدراء
 ☑️
 
※-   الحسابات المحذوفه
 🕴️
 
※-  الاعضاء المميزين : ادمنيه البوت
 🎽
 
✪-   </b>حظر المجموعه
 🎯

]]
                send(msg.chat_id_, msg.id_, 1, text, 1, 'html')
   end
  if text:match("^م4$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
   
   local text = [[
<b>ﭑهلإ بــك في سورس KEEPER🏌️</b>
ﮧ━─────────━ﮧ

<b>【 اوامر البوت √ 】

🔹 المجموعات : لإضهار المجموعات📲

▪️ قائمه المجموعات : لعرضها 🍃

🔹 الادمنيه : لٱضهار الادمنــيۿ 👥

🔹 الاعضاء المميزين : لعرضهم 🎓

🔹 المكتومين : لعرض المكتومين ✨

🔹 المدراء : لعرض المدراء 🍸

▪️ المحظورين : لعرض المحظورين 🌀

▪️ قائمه العام : لعرض المحظورين عام ☑️

▪ ادمنيه البوت : لعرض ادمنيه البوت📛

▪️ المطورين : لعرض المطوريــن 📍

▪️ قائمه المنع : لعرض الكلمات الممنوعه ♿️

▫️ ايدي : لعرض ايديك 📨

▫️ ايدي بالرد : لعرض ايدي العضو 💌

▫️ صوره+العدد : لجلب صوره حسابك 📷

🔸 ضع رابط : لوضع رابط ♻️

🔸 الرابط : لعرض الرابط ◀️

▪️  حذف الرابط : لحذفه ✔
▫️  اسمي : لعرض اسمك 🍃

🔸 رتبتي : لعرض رتبتك 🍃</b>

 
]]
                send(msg.chat_id_, msg.id_, 1, text, 1, 'html')
   end
  if text:match("^م6$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
   
   local text = [[
<b> ﭑهلإ بــك في سورس KEEPER🏌️
ﮧ━─────────━ﮧ
〖 الاوامر الاخرى ✔〗 :-

▫️  تنظيف + العدد :- لتنضيف المجموعهⓂ️

▫️ ارسال اذاعه :- ثم ترسل النصل 
لٱلغاء الامر اكتب الغاء

▫️ ارسال توجيه:- ثم ارسل النص او اجلب توجيه 
للنص   لٱرسالۿ  لٱلغائه اكتب الغاء📥

▪️ عدد المشاهدات :- لورئيه مشاهدات المنشور 👾

▪️ مسح الكل :- بالرد ع العضو لحذف رسائله 📌

▪️ منع + الكلمه :- لمنعها 🗺️
▫️ الغاء منع + الكلمه :- لٱلغاء منعها 🎎
▫ منع :- ثم ارسل الكلمات بشكل فردي 
للخروج اكتب الغاء 💰

▫️ايدي المجموعه  :- لعرض ايدي الكروب 🚏
▪️ معرفي  :-  لعرض معرفك ⚓️
▪️ حذف بالرد  :- لحذف الرساله 🔨

▫️ معلومات البوت : لعرض معلوماته ™️
▫️ تحديث البيانات : لتحديثها 🛐
▫️ تحديث الرسائل : لتحديثها

🔹 ضع لغه  عربي : لوضع اللغه عربي✅
🔹ضع لغه انكلش : لوضع اللغه انكليزي ✅
🔹 ضع عدد احرف : لوضع عدد الكلايش ✞
🔹 كول + الكلمه : لتكرار 💽

✪ تنشيط : لتنشيط البوت♬
✪ ضع قوانين : لوضع القوانيــن 📤
 
▪️ وضع ترحيب : لوضع ترحيب 🎐
▪️ تفعيل الترحيب : لتفعيله 📬

▪️ تعطيل الترحيب : لتعطيله 📬					
✪ حذف القوانين : لحذفها 🖱️
✪ القوانين : لعرض القوانين 📠</b>

]]
                send(msg.chat_id_, msg.id_, 1, text, 1, 'html')
   end  
if text:match("^م5$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
   
   local text = [[
<b>ﭑهلإ بــك في سورس KEEPER🏌️
ﮧ━─────────━ﮧ
※ اوامر المطور  كالتالــــي : - 
▪️ تفعيل : لتفعيل البوت ⚜️ •
▪️ تعطيل : لتعطيل البوت 🦋 •

🔹 رفع مطور : لرفع مطور في البوت 🚩 •
🔹 تنزيل مطور : لتنزيل المطور من البوت ✅ •

▫️ مسح المطورين : لمسح جميع المطورين ⚡️ •
▫️ معلومات المطور + المعرف او الايدي او بالرد 🎩 •

🔸 الايدي بالصوره : لتفعيل الايدي بالصورةه 🐾 •
🔸 الايدي بالعدد : لتفعيل الايدي بالعدد ⚠️ •

▪️ الخروج التلقائي مفعل : لتفعيل الخروج التلقائي 📮 •
▪️ الخروج التلقائي معطل " لتعطيل الخروج التلقائي 📬 •

🔸 معلوماتي : لعرض معلوماتك ك مطور 🔱 •
🔸 غادر : لاخراج البوت من المجموعةه 🔗 •

▫️ اضافه : لاضافةه عضو معين 🔖 •
▫️ وضع كليشه المطور : لوضعهـا 🤘🏿 •

¤ ضع اسم+الاسم : لوضع اسم للمجموعه ✔
¤ تثبيت : لتثبيت الرساله 🚸
¤ الغاء تثبيت : لٱلغاء تثبيت الرساله ⚜️
					
¤ موقعي : لعرض موقعك 🚣
� الاعدادات : لعرض الاعدادات🚣</b>


]]
                send(msg.chat_id_, msg.id_, 1, text, 1, 'html')
   end  
if text:match("^help$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
   
   local text = [[
 *Hello in source KEEPER*🏌️
━─────────━
اوامر اللغه الانكليزيه هي:
🔸 *aa* : لعرض اوامر الحمايه

🔸 *a1* : لعرض اوامر الرفع 

🔸 *a2* : لعرض اوامر الحضر 

🔸 *a3* : لعرض الاوامر الاخرى
━─────────━
✸. *sudo source* : @llX8Xll
]]
                send(msg.chat_id_, msg.id_, 1, text, 1, 'md')
   end 
  if text:match("^a2$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
   
   local text = [[
 *Hello in source KEEPER*🏌️
━─────────━
اوامر الحظر :

🔹 ban : لحضر الحضو

🔹 kick : لطرد العضو 

🔹 banall :  لحضر عام

🔹 mute : لكتم العضو
-------------

🔹 unban : الغاء الحضر

🔹 unbanall : الغا الحضر العام

🔹 unmute : الغاء الكتم 
━─────────━
✸. *sudo source* : @llX8Xll

]]
                send(msg.chat_id_, msg.id_, 1, text, 1, 'md')
   end 
				 if text:match("^aa$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
   
   local text = [[
 *Hello in source KEEPER*🏌️
━─────────━
اوامر الحمايه [antispam] :
استخدم *lock* + الامر للقفل or
استخدم *unlock* + الامر للفتح:
✸ `Spam`
✸ `links`
✸ `Webpage`
✸ `Flood`
✸ `Tgservice`
✸ `English`
✸ `arbic`
✸ `Inline`
✸ `Pin`
✸ `Mention`
✸ `Markdown`
✸ `Edit`
✸ `Bots`
✸ `Fwd`
✸ `Hashtag`
✸ `Post`
✸ `Duplipost`
✸ `Game`
✸ `Inline`
✸ `Member`
✸ `Gif`
✸ `Photo`
✸ `Video`
✸ `Selfvideo`
✸ `Text`
✸ `Voice`
✸ `Music`
✸ `location`
✸ `File`
✸ `Contact`
✸ `Sticker`
━─────────━
✸. *sudo source* : @llX8Xll
]]
                send(msg.chat_id_, msg.id_, 1, text, 1, 'md')
   end 
 if text:match("^a3$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
   
   local text = [[
 *Hello in source KEEPER*🏌️
━─────────━
اوامر الاخرى : 

▪️ setlink : لوضع رابط
▪️ dellink : لحذف الرابط
▪️ id : لعرض الايدي
▪️ gpid : لعرض ايدي المجموعه
▪️ add : لتفعيل البوت
▪️ rem : لتعطيل البوت
▪️ to photo :  لتحويل الى صوره
▪️ to stickre : لتحويل الى ملصق
▪️ gif+ ... : لصنع متحركه
▪️ love + ..+.. : لصنع ملصق
▪️ getpro [1 - 10] : لجلب صوره
▪️ Setspam [40 - Up]: لوضع عدد
▪️ Setflood [1 - Up]: لوضع تكرار
▪️ setlang en: لوضع لغه انكليزي
▪️ setlang ar: لوضع لغه عربي
[ use *Clean* : استخدم الامر مع:]
▪️ `Clean deleted` : طرد الحسابات المحذوفع
▪️ Clean filterlist`: مسح الكلمات
▪️ `Clean modlist`: مسح الادمنيه
▪️ `Clean banlist`: مسح المحضورين
▪️ `Clean mutelist`: مسح المكتومين
▪️ `Clean All Members`: مسح الاعضاء وطردهم
▪️ `Clean blocked`: مسح حضر المجموعه
▪️ `Clean msgs`: مسح الرسائل
▪️ `Me : معلومات
▪️ filter : لمنع كلمه
▪️ unfilter :الغاء منع
━─────────━
✸. *sudo source* : @llX8Xll
]]
                send(msg.chat_id_, msg.id_, 1, text, 1, 'md')
   end
  if text:match("^a1$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
   
   local text = [[
 *Hello in source KEEPER*🏌️
━─────────━
اوامر  الرفع :
✪ setowner : رفع مدير 

✪ setsudo : لرفع مطور

✪ remowner : لتنزيل مدير

✪ remsudo : لتنزيل المطور

✪ Promote : لرفع ادمن

✪ Demote : لتنزيل ادمن

✪ setvip : لرفع عضو مميز

✪ remvip : لتنزل العضو

━─────────━
✸. *sudo source* : @llX8Xll
]]
                send(msg.chat_id_, msg.id_, 1, text, 1, 'md')
   end  
---------------------------------------------------------------------------------------------------------------------------  
					if text:match("^welcome on$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
         send(msg.chat_id_, msg.id_, 1, '※↓ Welcome *Enabled* In This group🎌', 1, 'md')
		 database:set("bot:welcome"..msg.chat_id_,true)
	end
	if text:match("^welcome of$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
         send(msg.chat_id_, msg.id_, 1, '※↓ Welcome *Disabled* In This group🎌', 1, 'md')
		 database:del("bot:welcome"..msg.chat_id_)
	end
	
	if text:match("^تفعيل الترحيب$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
         send(msg.chat_id_, msg.id_, 1, '✺↓ تم ✅ تفعيل الترحيب 🎐', 1, 'md')
		 database:set("bot:welcome"..msg.chat_id_,true)
	end
	if text:match("^تعطيل الترحيب$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
         send(msg.chat_id_, msg.id_, 1, '✺↓ تم ✅ تعطيل الترحيب 🎈', 1, 'md')
		 database:del("bot:welcome"..msg.chat_id_)
	end

	if text:match("^[Ss]etwelcome (.*)$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
	local welcome = {string.match(text, "^([Ss]etwelcome) (.*)$")} 
         send(msg.chat_id_, msg.id_, 1, '➢ Welcome add:\n .................... :\n\n*'..welcome[2]..'*', 1, 'md')
		 database:set('welcome:'..msg.chat_id_,welcome[2])
	end
	if text:match("^وضع ترحيب (.*)$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
 local welcome = {string.match(text, "^(وضع ترحيب) (.*)$")}
         send(msg.chat_id_, msg.id_, 1, '✺↓ تم وضع الترحيب : \n\n*'..welcome[2]..'*', 1, 'md')
		 database:set('welcome:'..msg.chat_id_,welcome[2])
	end

          local text = msg.content_.text_:gsub('حذف الترحيب','delwelcome')
	if text:match("^[Dd]elwelcome$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
                if database:get('lang:gp:'..msg.chat_id_) then
         send(msg.chat_id_, msg.id_, 1, '✸ Welcome Deleted 🎈', 1, 'md')
       else 
                  send(msg.chat_id_, msg.id_, 1, '✸ تم حذف الترحيب 🎐', 1, 'md')
end
		 database:del('welcome:'..msg.chat_id_)
	end
	
          local text = msg.content_.text_:gsub('الترحيب','getwelcome')
	if text:match("^[Gg]etwelcome$") and is_momod(msg.sender_user_id_, msg.chat_id_) then
	local wel = database:get('welcome:'..msg.chat_id_)
	if wel then
         send(msg.chat_id_, msg.id_, 1, '🔹 <b>الترحيب</b> : \n'..wel, 1, 'html')
    else 
                if database:get('lang:gp:'..msg.chat_id_) then
         send(msg.chat_id_, msg.id_, 1, '🎌Welcome msg not saved🎌', 1, 'md')
else 
         send(msg.chat_id_, msg.id_, 1, '🔸 <b>لا يوجد ترحيب في المجموعــۿ </b>⚜️', 1, 'html')
end
	end
end
       if is_leader(msg) and text:match("^[Ff]wdtoall$") then
          database:setex("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "▫️↓  Please *Send* Your Message 📍 \nFor Cancel The Operation, Send Command /Cancel 📍 ", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "🔰↲ <b>ارسل لي الرساله الان</b>📲\n\nللخروج ارسل لي <b>الغاء</b> 📍 ", 1, "html")
          end
        end
        if is_leader(msg) and text:match("^ارسال توجيه$") then
          database:setex("broadcast" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "�⇣  Please *Send* Your Message 📍 \nFor Cancel The Operation, Send Command /Cancel 📍 ", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "🔰↲ <b>ارسل لي الرساله الان</b>📲\n\nللخروج ارسل لي <b>الغاء</b> 📍 ", 1, "html")
          end
        end
        if is_leader(msg) and text:match("^[Bb]roadcast$") then
          database:setex("broadcast2" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "�⇣  Please *Send* Your Message 📍 \nFor Cancel The Operation, Send Command /Cancel 📍 ", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "🔰↲ <b> ارسل لي الرساله الان📲</b>\n\nللخروج ارسل لي <b>الغاء</b> 📍 ", 1, "html")
          end
        end
        if is_leader(msg) and text:match("^ارسال اذاعه$") then
          database:setex("broadcast2" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "�⇣  Please *Send* Your Message 📍 \nFor Cancel The Operation, Send Command /Cancel 📍 ", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "🔰↲  <b>ارسل لي الرساله الان</b>📲\n\nللخروج ارسل لي <b>الغاء</b> 📍 ", 1, "html")
          end
        end
        if is_sudo(msg) and (text:match("^[Ss]tats$") or text:match("^معلومات البوت$")) then
          local gps = database:scard("bot:groups")
          local users = database:scard("bot:userss")
          local allmgs = database:get("bot:allmsgs")
          if database:get("bot:reloadingtime") then
            gps = "---"
            users = "---"
            allmgs = "---"
          end
          if database:get("autoleave") == "On" then
            autoleaveen = "Active"
            autoleaveAR = "مفعل"
          elseif database:get("autoleave") == "Off" then
            autoleaveen = "Deactive"
            autoleaveAR = "معطل"
          elseif not database:get("autoleave") then
            autoleaveen = "Deactive"
            autoleaveAR = "معطل"
          end
          if database:get("clerk") == "On" then
            clerken = "Active"
            clerkAR = "مفعل"
          elseif database:get("clerk") == "Off" then
            clerken = "Deactive"
            clerkAR = "معطل"
          elseif not database:get("clerk") then
            clerken = "Deactive"
            clerkAR = "معطل"
          end
          if database:get("fun") == "On" then
            funen = "Active"
            funAR = "مفعل"
          elseif database:get("fun") == "Off" then
            funen = "Deactive"
            funAR = "معطل"
          elseif not database:get("fun") then
            funen = "Deactive"
            funAR = "معطل"
          end
          if database:get("bot:viewmsg") == "On" then
            markreaden = "Active"
            markreadAR = "مفعل"
          elseif database:get("bot:viewmsg") == "Off" then
            markreaden = "Deactive"
            markreadAR = "معطل"
          elseif not database:get("bot:viewmsg") then
            markreaden = "Deactive"
            markreadAR = "معطل"
          end
          if database:get("joinbylink") == "On" then
            joinbylinken = "Active"
            joinbylinkAR = "مفعل"
          elseif database:get("joinbylink") == "Off" then
            joinbylinken = "Deactive"
            joinbylinkAR = "معطل"
          elseif not database:get("joinbylink") then
            joinbylinken = "Deactive"
            joinbylinkAR = "معطل"
          end
          if database:get("savecont") == "On" then
            saveconten = "Active"
            savecontAR = "مفعل"
          elseif database:get("savecont") == "Off" then
            saveconten = "Deactive"
            savecontAR = "معطل"
          elseif not database:get("savecont") then
            saveconten = "Deactive"
            savecontAR = "معطل"
          end
          if database:get("bot:joinch") then
            joinchannelen = "Active"
            joinchannelAR = "مفعل"
          else
            joinchannelen = "Deactive"
            joinchannelAR = "معطل"
          end
          if database:get("lang:gp:" .. msg.chat_id_) then
            lang = "En"
          else
            lang = "Ar"
          end
          local cm = io.popen("uptime -p"):read("*all")
          local ResultUptimeServer = GetUptimeServer(cm, lang)
          if 4 > string.len(ResultUptimeServer) then
            if lang == "En" then
              ResultUptimeServer = "Recently rebooted !"
            elseif lang == "Ar" then
              ResultUptimeServer = "تم التحديث❗️"
            end
          end
          Uptime_1 = database:get("bot:Uptime")
          local osTime = os.time()
          Uptime_ = osTime - tonumber(Uptime_1)
          Uptime = getTimeUptime(Uptime_, lang)
          usersv = io.popen("whoami"):read("*all")
          usersv = usersv:match("%S+")

          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "⚜️ *Status Bot* ⚜️ \n\n➢ *Groups* : `" .. gps .. "`\n\n➢ *Msg Received*  : `" .. allmgs .. "`\n\n➢ *Uptime* : `" .. Uptime .. "`\n\n➢ *Auto Leave* : `" .. autoleaveen .. "`\n\n➢ *Clerk* : `" .. clerken .. "`\n\n➢ *Forced Join Channel* : `" .. joinchannelen .. "`\n\n➢ *Fun Ability* : `" .. funen .. "`\n\n➢ *Markread* : `" .. markreaden .. "`\n\n➢ *Join By Link* : `" .. joinbylinken .. "`\n\n➢ *Save Phone Number* : `" .. saveconten .. "`\n\n☆ *Status Server* ☆\n\n➢ *User* : `" .. usersv .. "`\n\n➢ *UpTime* : `" .. ResultUptimeServer .. [[
`

]] , 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "⇗<code>معلومات حول البوت⇖</code> \n\n⚙️↲ <b>المجموعات</b> : " .. gps .. "\n\n📧↲ الرسائل  : " .. allmgs .. "\n\n🚭↲ <b>الخروج التلقائي</b> : " .. autoleaveAR .. "\n\n⛓↲ <b>الكليشه</b> : " .. clerkAR .. "\n\n♻️↲  الدخول للقناة : " .. joinchannelAR .. "\n\n◊↲ <b>المميزات الجديده</b> : " .. funAR .. "\n\n✳️↲  <b>المشاهده</b> : " .. markreadAR .. "\n\n📊↲  الدخول عبر الرابط : " .. joinbylinkAR .. "\n\n🛋↲ <b>حفظ الرقم </b>: " .. savecontAR .. "\n\n☜<code>معلومات السيرفر</code>☞ :\n\n⇦ <b>يوزر </b>: " .. usersv .. "\n\n⇦ <b>وقت التشغيل</b> : " .. ResultUptimeServer .. [[   

]] , 1, "html")
          end
        end
        if is_sudo(msg) and (text:match("^[Rr]esgp$") or text:match("^تحديث المجموعات$")) then
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "✸↓ Nubmber of Groups bot \n has been *Updated* 🎈", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "◊↲ <code>تم تحديث عدد المجموعات </code>📍 ", 1, "html")
          end
          database:del("bot:groups")
        end
        if is_sudo(msg) and (text:match("^[Rr]esmsg$") or text:match("^تحديث الرسائل$")) then
          database:del("bot:allmsgs")
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "✱↓  All msg Received has been *Reset* 📍 ", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "◊↲ <code>تم تحديث ✅ جميع الرسائل </code>📍 ", 1, "html")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and (text:match("^[Ss]etlang (.*)$") or text:match("^ضع لغه (.*)$")) then
          local langs = {
            string.match(text, "^(.*) (.*)$")
          }
          if langs[2] == "ar" or langs[2] == "عربي" then
            if not database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "➢ <b>تـم تغييــر اللغــه عربــي </b>🎐 ", 1, "html")
            else
              send(msg.chat_id_, msg.id_, 1, "➢ <b>تـم تغييــر اللغــه عربــي </b>🎐 ", 1, "html")
              database:del("lang:gp:" .. msg.chat_id_)
            end
          end
          if langs[2] == "en" or langs[2] == "انكلش" then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💡 *Language Bot is English* 💡", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💡 *Bot Language is English* 💡", 1, "md")
              database:set("lang:gp:" .. msg.chat_id_, true)
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Uu]nlock (.*)$") or text:match("^فتح (.*)$")) and check_user_channel(msg) then
          local unlockpt = {
            string.match(text, "^([Uu]nlock) (.*)$")
          }
          local unlockpts = {
            string.match(text, "^(فتح) (.*)$")
          }
          if unlockpt[2] == "edit" or unlockpts[2] == "التعديل" then
            if database:get("editmsg" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock edit has been *Inactive* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ فتح التعديل🏹📍 ", 1, "md")
              end
              database:del("editmsg" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock edit is *Already* inactive 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ فتح التعديل🏹📍 ", 1, "md")
            end
          end
          if unlockpt[2] == "cmd" or unlockpts[2] == "الاوامر" then
            if database:get("bot:cmds" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Case of no answer has been *Inactive* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ فتح الاوامر🎮📍 ", 1, "md")
              end
              database:del("bot:cmds" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Case of no answer is *Already* inactive 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ فتح الاوامر 🎮📍 ", 1, "md")
            end
          end
          if unlockpt[2] == "bots" or unlockpts[2] == "البوتات" then
            if database:get("bot:bots:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock bot has been *Inactive* 🚀 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ فتح البوتات 👾📍 ", 1, "md")
              end
              database:del("bot:bots:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock bots is *Already* inactive 🚀  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ فتح البوتات 👾📍 ", 1, "md")
            end
          end
          if unlockpt[2] == "flood" or unlockpts[2] == "التكرار" then
            if database:get("anti-flood:" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock flood has been *Inactive* 🚀  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ فتح التكرار 🎌📍 ", 1, "md")
              end
              database:del("anti-flood:" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock flood is *Already* inactive 🚀  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ فتح التكرار 🎌📍", 1, "md")
            end
          end
          if unlockpt[2] == "pin" or unlockpts[2] == "التثبيت" then
            if database:get("bot:pin:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock pin has been *Inactive* 🚀  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ فتح التثبيت 🕯️📍", 1, "md")
              end
              database:del("bot:pin:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock pin is *Already* inactive 🚀 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✔ فتح التثبيت 🕯️📍 ", 1, "md")
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          local text = text:gsub("قفل المجموعه بالوقت", "Lock auto")
          if text:match("^[Ll]ock auto$") and check_user_channel(msg) then
            local s = database:get("bot:muteall:start" .. msg.chat_id_)
            local t = database:get("bot:muteall:stop" .. msg.chat_id_)
            if not s and not t then
              database:setex("bot:SetMuteall:start" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true)
              database:del("bot:SetMuteall:stop" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Please Send *Auto-Lock* Time To *Start* 📍 \nFor example:\n14:38", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓ <b>ارسل لي وقت بدايه القفل </b>\n\n<b>كذالك وقت فتح المجموعه</b>\n<code>مثلاً : 12:23</code> 🎈 ",  1, "html")
              end
            elseif not database:get("bot:muteall:Time" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock Auto has been *Actived* 🎐\nTo Reset The Time🎈\n Send  *Settime* Command 🏌️", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1," 💠↓ تم قفل المجموعه بالوقت❗️\n\n⚠️- لتغير الوقت ارسل ضع وقت 🎐", 1, "md")
              end
              database:set("bot:duplipost:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "• Lock Auto is *Already* actived 🚀 \nTo Reset The Time🎈\n Send  *Settime* Comm and 🚀 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ تم قفل المجموعه بالوقت❗️\n\n⚠️- لتغير الوقت ارسل ضع وقت 🎐",  1, "md")
            end
          end
          if database:get("bot:SetMuteall:start" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) and text:match("^%d+:%d+$") then
            local ap = {
              string.match(text, "^(%d+:)(%d+)$")
            }
            local h = text:match("%d+:")
            h = h:gsub(":", "")
            local m = text:match(":%d+")
            m = m:gsub(":", "")
            local h_ = 23
            local m_ = 59
            if h_ >= tonumber(h) and m_ >= tonumber(m) then
              local TimeStart = text:match("^%d+:%d+")
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Please Send *Auto-Lock* \nTime Of The *End* 🎐", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓ <b>ارسل لي نهايه الوقت الان</b> 📍 \n<code>مثلا  : 10:47</code>", 1, "html")
              end
              database:del("bot:SetMuteall:start" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
              database:set("bot:muteall:start" .. msg.chat_id_, TimeStart)
              database:setex("bot:SetMuteall:stop" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "【  Time Posted is *Not Correct*♩ 】", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "【  الوقت غير صحيح ⚜️ 】", 1, "md")
            end
          end
          if database:get("bot:SetMuteall:stop" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
            local t = database:get("bot:muteall:start" .. msg.chat_id_)
            if text:match("^%d+:%d+") and not text:match(t) then
              local ap = {
                string.match(text, "^(%d+):(%d+)$")
              }
              local h = text:match("%d+:")
              h = h:gsub(":", "")
              local m = text:match(":%d+")
              m = m:gsub(":", "")
              local h_ = 23
              local m_ = 59
              if h_ >= tonumber(h) and m_ >= tonumber(m) then
                local TimeStop = text:match("^%d+:%d+")
                database:del("bot:SetMuteall:stop" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
                database:set("bot:muteall:stop" .. msg.chat_id_, TimeStop)
                database:set("bot:muteall:Time" .. msg.chat_id_, true)
                local start = database:get("bot:muteall:start" .. msg.chat_id_)
                local stop = database:get("bot:muteall:stop" .. msg.chat_id_)
                if database:get("lang:gp:" .. msg.chat_id_) then
                  send(msg.chat_id_, msg.id_, 1, "※ Auto-lock Time Every Day :\n" .. start .. " Will Be *Active* and 🎈\n" .. stop .. " Will Be *Disabled* 🎈", 1, "md")
                else
                  send(msg.chat_id_, msg.id_, 1, "🔰↓ <b>تم قفل المجموعه من </b>:\n\n الساعه :  " .. start .. "⏱️\n الى الساعه : " .. stop .. " 🎐", 1, "html")
                end
                database:del("bot:muteall:start_Unix" .. msg.chat_id_)
                database:del("bot:muteall:stop_Unix" .. msg.chat_id_)
              elseif database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "▫️↓  Time Posted is *Not Correct* 🎣 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "◊↲  الوقت الذي ارسلته غير صعيح🎐", 1, "md")
              end
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          local text = text:gsub("فتح المجموعه بالوقت", "Unlock auto")
          if text:match("^[Uu]nlock auto$") and check_user_channel(msg) then
            if database:get("bot:muteall:Time" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "✱↓  Auto-Lock has been *Inactive* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓ <code>تم ✅ فتح المجموعه بالوقت </code>✨🎈 ", 1, "html")
              end
              database:del("bot:muteall:Time" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "✱↓  Auto-Lock is *Already* inactive 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ <code>تم فتح المجموعه  بالوقت</code> ✨🎋 ", 1, "html")
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          local text = text:gsub("ضع وقت", "Settime")
          if text:match("^[Ss]ettime$") and check_user_channel(msg) then
            database:setex("bot:SetMuteall:start" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true)
            database:del("bot:SetMuteall:stop" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Please Send *Auto-Lock* Time To *Start* 📍 \nFor example:\n14:38", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ <b>ارسل لي وقت بدايه القفل </b>\n\n<b>كذالك وقت فتح المجموعه</b>\n<code>مثلاً : 12:23</code> 🎈 ", 1, "html")
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ll]ock gtime (%d+) (%d+) (%d+)$") and check_user_channel(msg) then
          local matches = {
            string.match(text, "^[Ll]ock gtime (%d+) (%d+) (%d+)$")
          }
          local hour = string.gsub(matches[1], "h", "")
          local num1 = tonumber(hour) * 3600
          local minutes = string.gsub(matches[2], "m", "")
          local num2 = tonumber(minutes) * 60
          local second = string.gsub(matches[3], "s", "")
          local num3 = tonumber(second)
          local num4 = tonumber(num1 + num2 + num3)
          if 1 <= matches[1] + matches[2] + matches[3] then
            database:setex("bot:muteall" .. msg.chat_id_, num4, true)
            database:setex("bot:gtime" .. msg.chat_id_, num4, true)
            database:del("bot:gtime:say" .. msg.chat_id_)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock all has been *Enable* for \n`" .. matches[1] .. "` Hours and \n`" .. matches[2] .. "` Minutes and `" .. matches[3] .. "` Seconds ❗️", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ <b>تم قفل الكل خلال </b>:\n " .. matches[1] .. "ساعه و " .. matches[2] .. " دقیقه و \n " .. matches[3] .. " 🏌️", 1, "html")
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "➢ Please *Use* a Number Greater Than 0 ✞", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "✸ استخدم عدد اكبر من 0 ❗️", 1, "md")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ll]ock gtime (%d+) (%d+)$") and check_user_channel(msg) then
          local matches = {
            string.match(text, "^[Ll]ock gtime (%d+) (%d+)$")
          }
          local hour = string.gsub(matches[1], "h", "")
          local num1 = tonumber(hour) * 3600
          local minutes = string.gsub(matches[2] or 0, "m", "")
          local num2 = tonumber(minutes) * 60
          local num3 = tonumber(num1 + num2)
          if 1 <= matches[1] + matches[2] then
            database:setex("bot:muteall" .. msg.chat_id_, num3, true)
            database:setex("bot:gtime" .. msg.chat_id_, num3, true)
            database:del("bot:gtime:say" .. msg.chat_id_)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock all has been *Enable* for \n`" .. matches[1] .. "` Hours and `" .. matches[2] .. "` Minutes 🚀 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ <b>تم قفل المجموعه خلال</b> :\n\n " .. matches[1] .. " ساعه و " .. matches[2] .. " دقيقه🎋", 1, "html")
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "⇛ Please *Use* a Number Greater Than 0 ✞", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "✸ استخدم عدد اكبر من 0 ❗️", 1, "md")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ll]ock gtime (%d+)$") and check_user_channel(msg) then
          local matches = {
            string.match(text, "^([Ll]ock gtime) (%d+)$")
          }
          local hour = string.gsub(matches[2], "h", "")
          local num1 = tonumber(hour) * 3600
          if 1 <= tonumber(matches[2]) then
            database:setex("bot:muteall" .. msg.chat_id_, num1, true)
            database:setex("bot:gtime" .. msg.chat_id_, num1, true)
            database:del("bot:gtime:say" .. msg.chat_id_)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock all has been *Enable* for \n`" .. matches[2] .. "` Hours 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ <b>تم قفل المجموعه خلال</b>\n\n " .. matches[2] .. " ساعه📍 ", 1, "html")
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "➢ Please *Use* a Number Greater Than 0 📍 ", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "✸ استخدم عدد اكبر من 0 ❗️ ", 1, "md")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and text:match("^قفل المجموعه (%d+) (%d+) (%d+)$") and idf:match("-100(%d+)") and check_user_channel(msg) then
          local matches = {
            string.match(text, "^قفل المجموعه (%d+) (%d+) (%d+)$")
          }
          local hour = string.gsub(matches[1], "h", "")
          local num1 = tonumber(hour) * 3600
          local minutes = string.gsub(matches[2], "m", "")
          local num2 = tonumber(minutes) * 60
          local second = string.gsub(matches[3], "s", "")
          local num3 = tonumber(second)
          local num4 = tonumber(num1 + num2 + num3)
          if 1 <= matches[1] + matches[2] + matches[3] then
            database:setex("bot:muteall" .. msg.chat_id_, num4, true)
            database:setex("bot:gtime" .. msg.chat_id_, num4, true)
            database:del("bot:gtime:say" .. msg.chat_id_)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock all has been *Enable* for \n`" .. matches[1] .. "` Hours and \n`" .. matches[2] .. "` Minutes and `" .. matches[3] .. "` Seconds ❗️ ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ <b>تم قفل الكل خلال </b>:\n\n " .. matches[1] .. "ساعه و " .. matches[2] .. " دقیقه و \n " .. matches[3] .. " 🏌️ ", 1, "html")
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "➢ Please *Use* a Number Greater Than 0 ✞ ", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "✸ استخدم عدد اكبر من 0 ❗️ ", 1, "md")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^قفل المجموعه (%d+) (%d+)$") and check_user_channel(msg) then
          local matches = {
            string.match(text, "^قفل المجموعه (%d+) (%d+)$")
          }
          local hour = string.gsub(matches[1], "h", "")
          local num1 = tonumber(hour) * 3600
          local minutes = string.gsub(matches[2] or 0, "m", "")
          local num2 = tonumber(minutes) * 60
          local num3 = tonumber(num1 + num2)
          if 1 <= matches[1] + matches[2] then
            database:setex("bot:muteall" .. msg.chat_id_, num3, true)
            database:setex("bot:gtime" .. msg.chat_id_, num3, true)
            database:del("bot:gtime:say" .. msg.chat_id_)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock all has been *Enable* for \n`" .. matches[1] .. "` Hours and `" .. matches[2] .. "` Minutes 🚀 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ <b>تم قفل المجموعه خلال </b>:\n\n " .. matches[1] .. " ساعه و " .. matches[2] .. " دقيقه🎋 ", 1, "html")
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "➢ Please *Use* a Number Greater Than 0 ✞ ", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "✸ستخدم عدد اكبر من 0 ❗️", 1, "md")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^قفل المجموعه (%d+)$") and check_user_channel(msg) then
          local matches = {
            string.match(text, "^(قفل المجموعه) (%d+)$")
          }
          local hour = string.gsub(matches[2], "h", "")
          local num1 = tonumber(hour) * 3600
          if 1 <= tonumber(matches[2]) then
            database:setex("bot:muteall" .. msg.chat_id_, num1, true)
            database:setex("bot:gtime" .. msg.chat_id_, num1, true)
            database:del("bot:gtime:say" .. msg.chat_id_)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock all has been *Enable* for \n`" .. matches[2] .. "` Hours 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ <b>تم قفل المجموعه خلال</b>\n <code>" .. matches[2] .. " </code>ساعه📍 ", 1, "html")
            end
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "➢ Please *Use* a Number Greater Than 0 ✞ ", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "✸ستخدم عدد اكبر من 0 ❗️ ", 1, "md")
          end
        end
        if database:get("bot:gtime" .. msg.chat_id_) then
          local gtimeTime = tonumber(database:ttl("bot:gtime" .. msg.chat_id_))
          if gtimeTime < 60 and not database:get("bot:gtime:say" .. msg.chat_id_) then
            database:set("bot:gtime:say" .. msg.chat_id_, true)
            database:setex("bot:gtime:say2", gtimeTime, msg.chat_id_)
          end
        end
        if database:get("bot:gtime:say2") then
          local gtimeTime_ = tonumber(database:ttl("bot:gtime:say2"))
          local gtimeChat_ = tostring(database:get("bot:gtime:say2"))
          if gtimeTime_ < 5 then
            if database:get("lang:gp:" .. gtimeChat_) then
              send(gtimeChat_, 0, 1, "▫️↓  Time *Lock Group* Finished \n All Users can *Send Message* in Group 📍 ", 1, "md")
            else
              send(gtimeChat_, 0, 1, "📛↲ <b>انتهى وقت قفل المجموعه</b>🎈\n\n- <b>يمكن ارسال الرسائل الان </b>🎐", 1, "html")
            end
            database:del("bot:gtime:say2")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Ll]ock (.*)$") or text:match("^قفل (.*)$")) and check_user_channel(msg) then
          local mutept = {
            string.match(text, "^([Ll]ock) (.*)$")
          }
          local mutepts = {
            string.match(text, "^(قفل) (.*)$")
          }
          if mutept[2] == "all" or mutepts[2] == "الكل" then
            if not database:get("bot:muteall" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock all has been *Actived* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الكل🔏📍 ", 1, "md")
              end
              database:set("bot:muteall" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock all is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الكل🔏📍 ", 1, "md")
            end
          end
          if mutept[2] == "text" or mutepts[2] == "الدردشه" then
            if not database:get("bot:text:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock text has been *Actived* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الدردشه📝📍 ", 1, "md")
              end
              database:set("bot:text:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock text is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الدردشه📝📍 ", 1, "md")
            end
          end
          if mutept[2] == "duplipost" or mutepts[2] == "المشاركه" then
            if not database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock duplicate post has been *Actived* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل المشاركه 🗑️📍 ", 1, "md")
              end
              database:set("bot:duplipost:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock duplicate post is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل المشاركه 🗑️📍", 1, "md")
            end
          end
          if mutept[2] == "inline" or mutepts[2] == "الانلاين" then
            if not database:get("bot:inline:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock inline has been *Actived* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الانلاين 🗺️📍 h", 1, "md")
              end
              database:set("bot:inline:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock inline is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الانلاين 🗺️📍", 1, "md")
            end
          end
          if mutept[2] == "post" or mutepts[2] == "البوست" then
            if not database:get("post:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock post has been *Actived* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل البوست 🖼️📍 ", 1, "md")
              end
              database:set("post:lock" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock post is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل البوست 🖼️📍", 1, "md")
            end
          end
          if mutept[2] == "photo" or mutepts[2] == "الصور" then
            if not database:get("bot:photo:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock photo has been *Actived* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الصور 📸📍 ", 1, "md")
              end
              database:set("bot:photo:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock photo is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الصور 📸📍", 1, "md")
            end
          end
          if mutept[2] == "spam" or mutepts[2] == "الكلايش" then
            if not database:get("bot:spam:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock spam has been *Actived* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الكلايش📑📍 ", 1, "md")
              end
              database:set("bot:spam:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock spam is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الكلايش📑📍", 1, "md")
            end
          end
          if mutept[2] == "video" or mutepts[2] == "الفيديو" then
            if not database:get("bot:video:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock video has been *Actived* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الفيديو 🎥📍 ", 1, "md")
              end
              database:set("bot:video:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock video is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الفيديو 🎥📍", 1, "md")
            end
          end
          if mutept[2] == "selfvideo" or mutepts[2] == "السيفلي" then
            if not database:get("bot:selfvideo:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock self video has been *Actived* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الفيديو الامامي📍 ", 1, "md")
              end
              database:set("bot:selfvideo:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock self video is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الفيديو الامامي📍", 1, "md")
            end
          end
          if mutept[2] == "gif" or mutepts[2] == "المتحركه" then
            if not database:get("bot:gifs:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock gif has been *Actived* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل المتحركه 🗜️📍", 1, "md")
              end
              database:set("bot:gifs:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock gif is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل المتحركه 🗜️📍 ", 1, "md")
            end
          end
          if mutept[2] == "music" or mutepts[2] == "الاغاني" then
            if not database:get("bot:music:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock music has been *Actived* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الاغاني 🎻📍 ", 1, "md")
              end
              database:set("bot:music:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock music is *Alraedy* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الاغاني 🎻📍", 1, "md")
            end
          end
          if mutept[2] == "voice" or mutepts[2] == "الصوت" then
            if not database:get("bot:voice:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock voice has been *Actived* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الصوت 🎤📍", 1, "md")
              end
              database:set("bot:voice:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock voice is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الصوت 🎤📍 ", 1, "md")
            end
          end
          if mutept[2] == "links" or mutepts[2] == "الروابط" then
            if not database:get("bot:links:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock links has been *Actived* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الروابط 🖇️📍 ", 1, "md")
              end
              database:set("bot:links:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock links is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الروابط 🖇️📍", 1, "md")
            end
          end
          if mutept[2] == "location" or mutepts[2] == "المواقع" then
            if not database:get("bot:location:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock location has been *Actived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل المواقع 🖱️📍  ", 1, "md")
              end
              database:set("bot:location:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock location is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل المواقع 🖱️📍", 1, "md")
            end
          end
          if mutept[2] == "tag" or mutepts[2] == "التاك" then
            if not database:get("tags:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock tag has been *Actived* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل التاك 🛋️📍 ", 1, "md")
              end
              database:set("tags:lock" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock tag is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل التاك 🛋️📍", 1, "md")
            end
          end
          if mutept[2] == "file" or mutepts[2] == "الفايلات" then
            if not database:get("bot:document:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock file has been *Actived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الفايلات 🗂️📍 ", 1, "md")
              end
              database:set("bot:document:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock file is *Already* actived  📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الفايلات 🗂️📍", 1, "md")
            end
          end
          if mutept[2] == "game" or mutepts[2] == "الالعاب" then
            if not database:get("Game:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock game has been *Actived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الالعاب 🎳📍  ", 1, "md")
              end
              database:set("Game:lock" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock game is *Already* actived  📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الالعاب 🎳📍", 1, "md")
            end
          end
          if mutept[2] == "hashtag" or mutepts[2] == "الهاشتاك" then
            if not database:get("bot:hashtag:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock hastag has been *Actived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الهاشتاك 🎗️📍", 1, "md")
              end
              database:set("bot:hashtag:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock hashtag is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الهاشتاك 🎗️📍 ", 1, "md")
            end
          end
          if mutept[2] == "contact" or mutepts[2] == "الاتصال" then
            if not database:get("bot:contact:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock contact has been *Actived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الاتصال 📱📍  ", 1, "md")
              end
              database:set("bot:contact:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock contact is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الاتصال 📱📍", 1, "md")
            end
          end
          if mutept[2] == "webpage" or mutepts[2] == "الويب" then
            if not database:get("bot:webpage:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock webpage has been *Actived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الويب 🌐📍 ", 1, "md")
              end
              database:set("bot:webpage:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock webpage is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الويب 🌐📍", 1, "md")
            end
          end
          if mutept[2] == "joinmember" or mutepts[2] == "الانضمام" then
            if not database:get("bot:member:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock Join Member has been *Actived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الانضمام 📍 ", 1, "md")
              end
              database:set("bot:member:lock" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock Join Member is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الانضمام 📍", 1, "md")
            end
          end
          if mutept[2] == "arabic" or mutepts[2] == "العربيه" then
            if not database:get("bot:arabic:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock arabic has been *Actived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل العربيه ♣️📍  ", 1, "md")
              end
              database:set("bot:arabic:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock arabic is *Already* actived📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل العربيه ♣️📍", 1, "md")
            end
          end
          if mutept[2] == "english" or mutepts[2] == "الانكليزيه" then
            if not database:get("bot:english:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock english has been *Actived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الانكليزيه 🆎 📍", 1, "md")
              end
              database:set("bot:english:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock english is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الانكليزيه 🆎 📍", 1, "md")
            end
          end
          if mutept[2] == "sticker" or mutepts[2] == "الملصقات" then
            if not database:get("bot:sticker:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock sticker has been *Actived* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الملصقات 💾📍 ", 1, "md")
              end
              database:set("bot:sticker:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock sticker is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الملصقات 💾📍 ", 1, "md")
            end
          end
          if mutept[2] == "markdown" or mutepts[2] == "الماركدون" then
            if not database:get("markdown:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock markdown has been *Actived* ?? ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الماركدون⛓️📍 ", 1, "md")
              end
              database:set("markdown:lock" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock markdown is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الماركدون⛓️📍", 1, "md")
            end
          end
          if mutept[2] == "tgservice" or mutepts[2] == "اشعارات الدخول" then
            if not database:get("bot:tgservice:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock tgservice has been *Actived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الاشعارات 🌡️📍 ", 1, "md")
              end
              database:set("bot:tgservice:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock tgservice is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل الاشعارات 🌡️📍", 1, "md")
            end
          end
          if mutept[2] == "fwd" or mutepts[2] == "التوجيه" then
            if not database:get("bot:forward:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock forward has been *Actived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل التوجيه 📲📍 ", 1, "md")
              end
              database:set("bot:forward:mute" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock forward is *Already* actived 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تــم ✔ قفل التوجيه 📲📍 ", 1, "md")
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Uu]nlock (.*)$") or text:match("^فتح (.*)$")) and check_user_channel(msg) then
          local unmutept = {
            string.match(text, "^([Uu]nlock) (.*)$")
          }
          local unmutepts = {
            string.match(text, "^(فتح) (.*)$")
          }
          if unmutept[2] == "all" or unmutept[2] == "gtime" or unmutepts[2] == "الكل" or unmutepts[2] == "`" then
            if database:get("bot:muteall" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock all has been *Inactived* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✅ فتح الكل 📍  ", 1, "md")
              end
              database:del("bot:muteall" .. msg.chat_id_)
              database:set("bot:gtime:say" .. msg.chat_id_, true)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock all is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✅ فتح الكل 📍 ", 1, "md")
            end
          end
          if unmutept[2] == "text" or unmutepts[2] == "الدردشه" then
            if database:get("bot:text:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock text has been *Inactived*📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✅ فتح الدردشه 📍 ", 1, "md")
              end
              database:del("bot:text:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock text is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓ اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓ تــم ✅ فتح الدردشه 📍", 1, "md")
            end
          end
          if unmutept[2] == "photo" or unmutepts[2] == "الصور" then
            if database:get("bot:photo:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock photo has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الصور 📍  ", 1, "md")
              end
              database:del("bot:photo:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock photo is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الصور 📍 ", 1, "md")
            end
          end
          if unmutept[2] == "duplipost" or unmutepts[2] == "المشاركه" then
            if database:get("bot:duplipost:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock duplicate post has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح المشاركه 📍 ", 1, "md")
              end
              database:del("bot:duplipost:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock duplicate post is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح المشاركه 📍  ", 1, "md")
            end
          end
          if unmutept[2] == "spam" or unmutepts[2] == "الكلايش" then
            if database:get("bot:spam:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock spam has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الكلايش 📍", 1, "md")
              end
              database:del("bot:spam:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock spam is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الكلايش 📍 ", 1, "md")
            end
          end
          if unmutept[2] == "video" or unmutepts[2] == "الفيديو" then
            if database:get("bot:video:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock video has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الفيديو 📍", 1, "md")
              end
              database:del("bot:video:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓ Lock video is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الفيديو 📍 ", 1, "md")
            end
          end
          if unmutept[2] == "selfvideo" or unmutepts[2] == "السيلفي" then
            if database:get("bot:selfvideo:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock self video has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الفيديو الامامي 📍 ", 1, "md")
              end
              database:del("bot:selfvideo:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓ Lock self video is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الفيديو الامامي 📍  ", 1, "md")
            end
          end
          if unmutept[2] == "file" or unmutepts[2] == "الفايلات" then
            if database:get("bot:document:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock file has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الفايلات 📍 ", 1, "md")
              end
              database:del("bot:document:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓ Lock file is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الفايلات 📍 ", 1, "md")
            end
          end
          if unmutept[2] == "game" or unmutepts[2] == "الالعاب" then
            if database:get("Game:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock game has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الالعاب 📍", 1, "md")
              end
              database:del("Game:lock" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓ Lock game is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الالعاب 📍 ", 1, "md")
            end
          end
          if unmutept[2] == "inline" or unmutepts[2] == "الانلاين" then
            if database:get("bot:inline:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock inline has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الانلاين 📍", 1, "md")
              end
              database:del("bot:inline:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓ Lock inline is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الانلاين 📍 ", 1, "md")
            end
          end
          if unmutept[2] == "post" or unmutepts[2] == "البوست" then
            if database:get("post:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock post has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح البوست 📍", 1, "md")
              end
              database:del("post:lock" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓ Lock post is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح البوست 📍  ", 1, "md")
            end
          end
          if unmutept[2] == "markdown" or unmutepts[2] == "الماركدون" then
            if database:get("markdown:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock markdown has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الماركدون 📍", 1, "md")
              end
              database:del("markdown:lock" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓ Lock markdown is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الماركدون 📍  ", 1, "md")
            end
          end
          if unmutept[2] == "gif" or unmutepts[2] == "المتحركه" then
            if database:get("bot:gifs:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock gif has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح المتحركه 📍", 1, "md")
              end
              database:del("bot:gifs:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock gif is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح المتحركه 📍 ", 1, "md")
            end
          end
          if unmutept[2] == "music" or unmutepts[2] == "الاغاني" then
            if database:get("bot:music:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock music has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الاغاني 📍 ", 1, "md")
              end
              database:del("bot:music:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock music is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الاغاني 📍  ", 1, "md")
            end
          end
          if unmutept[2] == "voice" or unmutepts[2] == "الصوت" then
            if database:get("bot:voice:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock voice has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الصوت 📍", 1, "md")
              end
              database:del("bot:voice:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock voice is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الصوت 📍 ", 1, "md")
            end
          end
          if unmutept[2] == "links" or unmutepts[2] == "الروابط" then
            if database:get("bot:links:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock links has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "??↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الروابط 📍 ", 1, "md")
              end
              database:del("bot:links:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓ Lock link is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الروابط 📍  ", 1, "md")
            end
          end
          if unmutept[2] == "location" or unmutepts[2] == "المواقع" then
            if database:get("bot:location:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock location has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح المواقع 📍", 1, "md")
              end
              database:del("bot:location:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓ Lock location is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح المواقع 📍  ", 1, "md")
            end
          end
          if unmutept[2] == "tag" or unmutepts[2] == "التاك" then
            if database:get("tags:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock tag has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح التاك 📍 ", 1, "md")
              end
              database:del("tags:lock" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓ Lock tag is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح التاك 📍  ", 1, "md")
            end
          end
          if unmutept[2] == "hashtag" or unmutepts[2] == "الهاشتاك" then
            if database:get("bot:hashtag:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock hashtag has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الهاشتاك 📍 ", 1, "md")
              end
              database:del("bot:hashtag:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock hashtag is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الهاشتاك 📍  ", 1, "md")
            end
          end
          if unmutept[2] == "contact" or unmutepts[2] == "الاتصال" then
            if database:get("bot:contact:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock contact has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الاتصال 📍", 1, "md")
              end
              database:del("bot:contact:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓ Lock contact is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الاتصال 📍 ", 1, "md")
            end
          end
          if unmutept[2] == "webpage" or unmutepts[2] == "الويب" then
            if database:get("bot:webpage:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock webpage has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الويب 📍 ", 1, "md")
              end
              database:del("bot:webpage:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock webpage is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الويب 📍 ", 1, "md")
            end
          end
          if unmutept[2] == "arabic" or unmutepts[2] == "العربيه" then
            if database:get("bot:arabic:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "• Lock farsi has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح العربيه 📍 ", 1, "md")
              end
              database:del("bot:arabic:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "• Lock farsi is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح العربيه 📍 ", 1, "md")
            end
          end
          if unmutept[2] == "joinmember" or unmutepts[2] == "الانضمام" then
            if database:get("bot:member:lock" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock Join Member has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الانضمام 📍 ", 1, "md")
              end
              database:del("bot:member:lock" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock Join Member is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الانضمام 📍 ", 1, "md")
            end
          end
          if unmutept[2] == "english" or unmutepts[2] == "الانكليزيه" then
            if database:get("bot:english:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock english has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الانكليزيه 📍 ", 1, "md")
              end
              database:del("bot:english:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓ Lock english is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الانكليزيه 📍  ", 1, "md")
            end
          end
          if unmutept[2] == "tgservice" or unmutepts[2] == "اشعارات الدخول" then
            if database:get("bot:tgservice:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock tgservice has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الاشعارات 📍", 1, "md")
              end
              database:del("bot:tgservice:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓ Lock tgservice is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الاشعارات 📍 ", 1, "md")
            end
          end
          if unmutept[2] == "sticker" or unmutepts[2] == "الملصقات" then
            if database:get("bot:sticker:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock sticker has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الملصقات 📍  ", 1, "md")
              end
              database:del("bot:sticker:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock sticker is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح الملصقات 📍", 1, "md")
            end
          end
          if unmutept[2] == "fwd" or unmutepts[2] == "التوجيه" then
            if database:get("bot:forward:mute" .. msg.chat_id_) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠↓  Lock forward has been *Inactived* 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح التوجــيه 📍 ", 1, "md")
              end
              database:del("bot:forward:mute" .. msg.chat_id_)
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "💠↓  Lock forward is *Already* inactived 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "💠↓  اۿــلاًُ تــــــاجَْ راســــــــيٌ 🎣 \n\n💠↓  تم ✅ فتح التوجــيه 📍 ", 1, "md")
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Ss]etspam (%d+)$") and check_user_channel(msg) then
          local sensspam = {
            string.match(text, "^([Ss]etspam) (%d+)$")
          }
          if 40 > tonumber(sensspam[2]) then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "✱↓  Enter a number *Greater* than `40` 🎈 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "◽️↓  قم بوضع عدد من (100-40)❗️", 1, "md")
            end
          else
            database:set("bot:sens:spam" .. msg.chat_id_, sensspam[2])
            if not database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "▫️↓ <code>تم وضع عدد احرف الكلايش </code>\n\n <b>" .. sensspam[2] .. "</b> حـــرف🎈 ", 1, "html")
            else
              send(msg.chat_id_, msg.id_, 1, "▫️↓  Spam *Sensitivity* has been set to : \n " .. sensspam[2] .. " number 🎈", 1, "md")
            end
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^ضع عدد احرف (%d+)$") and check_user_channel(msg) then
          local sensspam = {
            string.match(text, "^(ضع عدد احرف) (%d+)$")
          }
          if 40 > tonumber(sensspam[2]) then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "✱↓  Enter a number *Greater* than `40` 🎈 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "◽️↓ قم بوضع عدد من <b>(100-40)❗</b>️ ", 1, "html")
            end
          else
            database:set("bot:sens:spam" .. msg.chat_id_, sensspam[2])
            if not database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "▫️↓ <code>تم وضع عدد احرف الكلايش </code>\n\n <b>" .. sensspam[2] .. "</b> حـــرف🎈 ", 1, "html")
            else
              send(msg.chat_id_, msg.id_, 1, "▫️↓  Spam *Sensitivity* has been set to : \n " .. sensspam[2] .. " number 🎈 ", 1, "md")
            end
          end
        end
        if is_sudo(msg) and text:match("^[Ee]dit (.*)$") then
          local editmsg = {
            string.match(text, "^([Ee]dit) (.*)$")
          }
          edit(msg.chat_id_, msg.reply_to_message_id_, nil, editmsg[2], 1, "md")
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
        end
        if is_sudo(msg) and text:match("^تعديل (.*)$") then
          local editmsgs = {
            string.match(text, "^(تعديل) (.*)$")
          }
          edit(msg.chat_id_, msg.reply_to_message_id_, nil, editmsgs[2], 1, "md")
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and (text:match("^[Cc]lean (.*)$") or text:match("^مسح (.*)$"))  and check_user_channel(msg) then
          local txt = {
            string.match(text, "^([Cc]lean) (.*)$")
          }
          local txts = {
            string.match(text, "^(مسح) (.*)$")
          } 
          if txt[2] == "banlist" or txts[2] == "المحظورين" and idf:match("-100(%d+)") then
            database:del("bot:banned:" .. msg.chat_id_)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "🔖↓  *Banlist* Has Been Cleared 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "🔖↓ <b>تم √ مسح المحظورين </b>🎋", 1, "html")
            end
          end
          if is_sudo(msg) and (txt[2] == "banalllist" or txts[2] == "قائمه العام") then
            database:del("bot:gban:")
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "🔖↓ *Banalllist* Has Been Cleared 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "🔖↓ <b>تم √ مسح المحظورين عام </b>♩", 1, "html")
            end
          end
          if is_momod(msg.sender_user_id_, msg.chat_id_) and (txt[2] == "msgs" or txts[2] == "الرسائل" and idf:match("-100(%d+)")) then
            if not database:get("clean:msgs" .. msg.chat_id_) or is_admin(msg.sender_user_id_) then
              local hash = "groups:users" .. msg.chat_id_
              local list = database:smembers(hash)
              if list then
                for k, v in pairs(list) do
                  del_all_msgs(msg.chat_id_, v)
                end
              end
              local J = 0
              for i = 1, 7 do
                getChatHistory(msg.chat_id_, msg.chat_id_, J, 100, delmsg)
                J = J + 100
              end
              database:setex("clean:msgs" .. msg.chat_id_, 9 * hour, true)
            else
              local ex = database:ttl("clean:msgs" .. msg.chat_id_)
              local d = math.floor(ex / hour) + 1
              if not database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "◊↲  استخدم الامر بعد  : \n*" .. d .. "* ساعه🏌️", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "✱↓  Please *Use* This Command In \n*" .. d .. "* Hours 📍 ", 1, "md")
              end
            end
          end
          if txt[2] == "deleted" or txts[2] == "الحسابات المحذوفه" and idf:match("-100(%d+)") then
            local deletedlist = function(extra, result)
              local list = result.members_
              for i = 0, #list do
                local cleandeleted = function(extra, result)
                  if not result.first_name_ and not result.last_name_ then
                    chat_kick(msg.chat_id_, result.id_)
                  end
                end
                getUser(list[i].user_id_, cleandeleted)
              end
            end
            local d = 0
            for i = 1, NumberReturn do
              getChannelMembers(msg.chat_id_, d, "Recent", 200, deletedlist)
              d = d + 200
            end
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "🔖↓  All *Delete Account* has been *Removed* 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "🔖↓ <b>تم √ طرد جميع الحسابات المحذوفه </b>🎋", 1, "html")
            end
          end
          if txt[2] == "blocked" or txts[2] == "حظر المجموعه" and idf:match("-100(%d+)") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "🔖↓ If You Want Cleaning Group Blocked List📍  \n Send The Number 1 📍 \nElseif You Want Inviteing Group Blocked List📍 \n Send The Number 2 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "🔖↓ <code>اهــــــــلاً عزيزي ...؟</code>🕵🏻\n\n🅾️↓ <b> اذا اردت مسح المحضورين في المجموعه ارسل لي رقم= 1</b>\n\n🚸↓ <b>اذا اردت اضافتهم للمجموعه ارسل لي رقم= 2</b> 🎋❗️",  1, "html")
            end
            database:setex("CleanBlockList" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 35, true)
          end
          if is_leader(msg) and (txt[2] == "members" or txts[2] == "الاعضاء" and idf:match("-100(%d+)")) then
            do
              local checkclean = function(user_id)
                local var = false
                if is_admin(user_id) then
                  var = true
                end
                if tonumber(user_id) == tonumber(our_id) then
                  var = true
                end
                return var
              end
              local hash = "groups:users" .. msg.chat_id_
              local list = database:smembers(hash)
              if list then
                for k, v in pairs(list) do
                  if not checkclean(v) then
                    chat_kick(msg.chat_id_, v)
                  end
                end
              end
              local cleanmember = function(extra, result)
                local list = result.members_
                for i = 0, #list do
                  if not checkclean(list[i].user_id_) then
                    chat_kick(msg.chat_id_, list[i].user_id_)
                  end
                end
              end
              local d = 0
              for i = 1, 5 do
                getChannelMembers(msg.chat_id_, d, "Recent", 200, cleanmember)
                d = d + 200
              end
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "🔖↓  All *Members* has been *Removed* 📍 ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "🔖↓ <b>تم ✅ طرد الاعضاء </b>🎋🎈", 1, "html")
              end
            end
          else
          end
          if txt[2] == "bots" or txts[2] == "البوتات" and idf:match("-100(%d+)") then
            local botslist = function(extra, result)
              local list = result.members_
              for i = 0, #list do
                chat_kick(msg.chat_id_, list[i].user_id_)
              end
            end
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "🔖↓  All *Bots* has been *Removed* 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "🔖↓<b> تـــم ✔ مسح البوتات </b>♬♩", 1, "html")
            end
            getChannelMembers(msg.chat_id_, 0, "Bots", 200, botslist)
          end
          if is_owner(msg.sender_user_id_, msg.chat_id_) and (txt[2] == "modlist" or txts[2] == "الادمنيه" and idf:match("-100(%d+)")) then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "🔖↓  *Modlist* has been Cleared 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "🔖↓ <b>تـــم √ مسح الادمنيه </b>🎋📍 ", 1, "html")
            end
            database:del("bot:momod:" .. msg.chat_id_)
          end
          if txt[2] == "ownerlist" or txts[2] == "المدراء" and idf:match("-100(%d+)") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "🔖↓  *Owner List* has been Cleared 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "🔖↓ <b>تم ✅ مسح المدراء </b>🏌️", 1, "html")
            end
            database:del("bot:owners:" .. msg.chat_id_)
          end
          if is_leader(msg) and (txt[2] == "sudolist" or txts[2] == "المطورين") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "🔖↓  *Sudo List* has been Cleared 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "🔖↓ <code>تم √ مسح كل المطورين</code> 🕵🏽📍 ", 1, "html")
            end
            local hash = "Bot:SudoUsers"
            local list = database:smembers(hash)
            for k, v in pairs(list) do
              local t = tonumber(v)
              table.remove(_config.Sudo_Users, getindex(_config.Sudo_Users, t))
              save_on_config()
            end
            database:del("Bot:SudoUsers")

          end
          if is_leader(msg) and (txt[2] == "adminlist" or txts[2] == "ادمنيه البوت") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "🔖↓  *Admin List* has been Cleared 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "🔖↓ <b>تم ✅ مسح ادمنية البوت 📍 </b>", 1, "html")
            end
            database:del("Bot:Admins")

          end
          if txt[2] == "viplist" or txts[2] == "الاعضاء المميزين" and idf:match("-100(%d+)") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "🔖↓  *VIP Members* list has been Cleared 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "🔖↓ <b>تم ✅ مسح الاعضاء المميزين</b> 💔🎈", 1, "html")
            end
            database:del("bot:vipmem:" .. msg.chat_id_)
          end
          if txt[2] == "filterlist" or txts[2] == "قائمه المنع" and idf:match("-100(%d+)") then
            local hash = "bot:filters:" .. msg.chat_id_
            database:del(hash)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "🔖↓ *Filterlist* has been Cleared 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "🔖↓ <code>تم ✔ مسح قائمة المنع </code>✞", 1, "html")
            end
          end
          if txt[2] == "mutelist" or txts[2] == "المكتومين" and idf:match("-100(%d+)") then
            database:del("bot:muted:" .. msg.chat_id_)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "🔖↓  *MutedUsers* list has been Cleared 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "🔖↓ <b>تم √ مسح المكتومين</b> 🎋🎈", 1, "html")
            end
          end
        end
        local kickedlist = function(extra, result)
          local list = result.members_
          for i = 0, #list do
            chat_leave(msg.chat_id_, list[i].user_id_)
          end
        end
        local kickedlist2 = function(extra, result)
          local list = result.members_
          for i = 0, #list do
            add_user(msg.chat_id_, list[i].user_id_, 5)
          end
        end
        if database:get("CleanBlockList" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
          local d = 0
          if text:match("^1$") then
            database:del("CleanBlockList" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
            for i = 1, NumberReturn do
              getChannelMembers(msg.chat_id_, d, "Kicked", 200, kickedlist)
              d = d + 200
            end
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "🔊- All *Removed User* has been *Released* ✞", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "🔊- <b>تم ✅ مسح الاعظاء المحضورين في المجموعه </b>🎋🎈", 1, "html")
            end
          elseif text:match("^2$") then
            database:del("CleanBlockList" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
            for i = 1, NumberReturn do
              getChannelMembers(msg.chat_id_, d, "Kicked", 200, kickedlist2)
              d = d + 200
            end
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "🔊- All *Removed User* has been *Invited* ✞", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "🔊- <b>تم ✅ اضافه المحظورين الى المجموعه📍</b> ", 1, "html")
            end
          end
        end
				if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^الاعدادات")) and check_user_channel(msg) then
          if database:get("bot:muteall" .. msg.chat_id_) then
            mute_all = "✅"
          else
            mute_all = "✖️"
          end
          if database:get("bot:text:mute" .. msg.chat_id_) then
            mute_text = "✅"
          else
            mute_text = "✖️"
          end
          if database:get("bot:photo:mute" .. msg.chat_id_) then
            mute_photo = "✅"
          else
            mute_photo = "✖️"
          end
          if database:get("bot:video:mute" .. msg.chat_id_) then
            mute_video = "✅"
          else
            mute_video = "✖️"
          end
          if database:get("bot:selfvideo:mute" .. msg.chat_id_) then
            mute_selfvideo = "✅"
          else
            mute_selfvideo = "✖️"
          end
          if database:get("bot:gifs:mute" .. msg.chat_id_) then
            mute_gifs = "✅"
          else
            mute_gifs = "✖️"
          end
          if database:get("anti-flood:" .. msg.chat_id_) then
            mute_flood = "✅"
          else
            mute_flood = "✖️"
          end
          if database:get("bot:muteall:Time" .. msg.chat_id_) then
            auto_lock = "✅"
          else
            auto_lock = "✖️"
          end
          if not database:get("flood:max:" .. msg.chat_id_) then
            flood_m = 5
          else
            flood_m = database:get("flood:max:" .. msg.chat_id_)
          end
          if not database:get("bot:sens:spam" .. msg.chat_id_) then
            spam_c = 400
          else
            spam_c = database:get("bot:sens:spam" .. msg.chat_id_)
          end
          if database:get("warn:max:" .. msg.chat_id_) then
            sencwarn = tonumber(database:get("warn:max:" .. msg.chat_id_))
          else
            sencwarn = 4
          end
          if database:get("floodstatus" .. msg.chat_id_) == "DelMsg" then
            floodstatus = "المسح"
          elseif database:get("floodstatus" .. msg.chat_id_) == "Kicked" then
            floodstatus = "الطرد"
          elseif not database:get("floodstatus" .. msg.chat_id_) then
            floodstatus = "الطرد"
          end
          if database:get("warnstatus" .. msg.chat_id_) == "Muteuser" then
            warnstatus = "الكتم"
          elseif database:get("warnstatus" .. msg.chat_id_) == "Remove" then
            warnstatus = "الطرد"
          elseif not database:get("warnstatus" .. msg.chat_id_) then
            warnstatus = "الكتم"
          end
          if database:get("bot:music:mute" .. msg.chat_id_) then
            mute_music = "✅"
          else
            mute_music = "✖️"
          end
          if database:get("bot:bots:mute" .. msg.chat_id_) then
            mute_bots = "✅"
          else
            mute_bots = "✖️"
          end
          if database:get("bot:duplipost:mute" .. msg.chat_id_) then
            duplipost = "✅"
          else
            duplipost = "✖️"
          end
          if database:get("bot:member:lock" .. msg.chat_id_) then
            member = "✅"
          else
            member = "✖️"
          end
          if database:get("bot:inline:mute" .. msg.chat_id_) then
            mute_in = "✅"
          else
            mute_in = "✖️"
          end
          if database:get("bot:cmds" .. msg.chat_id_) then
            mute_cmd = "✅"
          else
            mute_cmd = "✖️"
          end
          if database:get("bot:voice:mute" .. msg.chat_id_) then
            mute_voice = "✅"
          else
            mute_voice = "✖️"
          end
          if database:get("editmsg" .. msg.chat_id_) then
            mute_edit = "✅"
          else
            mute_edit = "✖️"
          end
          if database:get("bot:links:mute" .. msg.chat_id_) then
            mute_links = "✅"
          else
            mute_links = "✖️"
          end
          if database:get("bot:pin:mute" .. msg.chat_id_) then
            lock_pin = "✅"
          else
            lock_pin = "✖️"
          end
          if database:get("bot:sticker:mute" .. msg.chat_id_) then
            lock_sticker = "✅"
          else
            lock_sticker = "✖️"
          end
          if database:get("bot:tgservice:mute" .. msg.chat_id_) then
            lock_tgservice = "✅"
          else
            lock_tgservice = "✖️"
          end
          if database:get("bot:webpage:mute" .. msg.chat_id_) then
            lock_wp = "✅"
          else
            lock_wp = "✖️"
          end
          if database:get("bot:strict" .. msg.chat_id_) then
            strict = "✅"
          else
            strict = "✖️"
          end
          if database:get("bot:hashtag:mute" .. msg.chat_id_) then
            lock_htag = "✅"
          else
            lock_htag = "✖️"
          end
          if database:get("tags:lock" .. msg.chat_id_) then
            lock_tag = "✅"
          else
            lock_tag = "✖️"
          end
          if database:get("bot:location:mute" .. msg.chat_id_) then
            lock_location = "✅"
          else
            lock_location = "✖️"
          end
          if database:get("bot:contact:mute" .. msg.chat_id_) then
            lock_contact = "✅"
          else
            lock_contact = "✖️"
          end
          if database:get("bot:english:mute" .. msg.chat_id_) then
            lock_english = "✅"
          else
            lock_english = "✖️"
          end
          if database:get("bot:arabic:mute" .. msg.chat_id_) then
            lock_arabic = "✅"
          else
            lock_arabic = "✖️"
          end
          if database:get("bot:forward:mute" .. msg.chat_id_) then
            lock_forward = "✅"
          else
            lock_forward = "✖️"
          end
          if database:get("bot:document:mute" .. msg.chat_id_) then
            lock_file = "✅"
          else
            lock_file = "✖️"
          end
          if database:get("markdown:lock" .. msg.chat_id_) then
            markdown = "✅"
          else
            markdown = "✖️"
          end
          if database:get("Game:lock" .. msg.chat_id_) then
            game = "✅"
          else
            game = "✖️"
          end
          if database:get("bot:spam:mute" .. msg.chat_id_) then
            lock_spam = "✅"
          else
            lock_spam = "✖️"
          end
          if database:get("post:lock" .. msg.chat_id_) then
            post = "✅"
          else
            post = "✅"
          end
          if database:get("bot:welcome" .. msg.chat_id_) then
            send_welcome = "✅"
          else
            send_welcome = "✅"
          end
          local TXTAR = "┏ اعدادات المجموعه┓⇩\n\n" .. "______________________\n" .. "▪️↓ قفل الكل  : " .. mute_all .. "\n" .. "______________________\n" .. "▫️↓  قفل الاوامر  : " .. mute_cmd .. "\n" .. "______________________\n" .. "▪️↓   قفل المجموعه بالوقت : " .. auto_lock .. "\n" .. "______________________\n" .. "▫️↓  قفل الكلايش  : " .. lock_spam .. "\n" .. "______________________\n" .. "▪️↓   قفل الروابط  : " .. mute_links .. "\n" .. "______________________\n" .. "▫️↓  قفل الويب  :  " .. lock_wp .. "\n" .. "______________________\n" .. "▪️↓   ققل التاك  : " .. lock_tag .. "\n" .. "______________________\n" .. "▪️↓   قفل الهاشتاك  : " .. lock_htag .. "\n" .. "______________________\n" .. "▫️↓  قفل التوجيه : " .. lock_forward .. "\n" .. "______________________\n" .. "▪️↓   قفل المشاركه  : " .. duplipost .. "\n" .. "______________________\n" .. "▫️↓  قفل البوتات :  " .. mute_bots .. "\n" .. "______________________\n" .. "▪️↓  قفل التعديل :  " .. mute_edit .. "\n" .. "______________________\n" .. "▫️↓  قفل التثبيت : " .. lock_pin .. "\n" .. "______________________\n" .. "▪️↓   قفل الانلاين : " .. mute_in .. "\n" .. "______________________\n" .. "▫️↓  قفل العربيه :  " .. lock_arabic .. "\n" .. "______________________\n" .. "▪️↓   قفل الانكليزيه : " .. lock_english .. "\n" .. "______________________\n" .. "▫️↓  قفل الماركدون : " .. markdown .. "\n" .. "______________________\n" .. "▪️↓   قفل البوست : " .. post .. "\n" .. "______________________\n" .. "▫️↓  قفل الالعاب : " .. game .. "\n" .. "______________________\n" .. "▪️↓   قفل الانضمام : " .. member .. "\n" .. "______________________\n" .. "▫️↓  قفل الاشعارات : " .. lock_tgservice .. "\n" .. "______________________\n" .. "▪️↓   قفل التكرار : " .. mute_flood .. "\n" .. "______________________\n" .. "✫ وضع التكرار : " .. floodstatus .. "\n" .. "______________________\n" .. "✫ وضع التحذير  : " .. warnstatus .. "\n" .. "______________________\n" .. "✫ عدد التحذيرات : [ " .. sencwarn .. " ]\n" .. "______________________\n" .. "️✫ عدد الاحرف : [ " .. spam_c .. [[
 ]

]] .. "______________________\n" .. "▫️↓  قفل الكتم  : " .. mute_text .. "\n" .. "______________________\n" .. "▪️↓   قفل الصور  : " .. mute_photo .. "\n" .. "______________________\n" .. "▪️↓   قفل الفيديو : " .. mute_video .. "\n" .. "______________________\n" .. "▪️↓   قفل السيلفي : " .. mute_selfvideo .. "\n" .. "______________________\n" .. "▫️↓  قفل المتحركه : " .. mute_gifs .. "\n" .. "______________________\n" .. "▫️↓  قفل الاغاني : " .. mute_music .. "\n" .. "______________________\n" .. "▫️↓  قفل الصوت : " .. mute_voice .. "\n" .. "______________________\n" .. "▫️↓  قفل الفايلات : " .. lock_file .. "\n" .. "______________________\n" .. "▪️↓   قفل الملصقات : " .. lock_sticker .. "\n" .. "______________________\n" .. "▪️↓   قفل الاتصال : " .. lock_contact .. "\n" .. "______________________\n" .. "▫️↓  قفل المواقع : " .. lock_location .. "\n" .. "______________________\n"
          local TXTARMode = " اعدادات الوسائط🛡️ :\n\n🔅↓  قفل الكل : " .. mute_all .. "\n" .. "______________________\n" .. "🔅↓  قفل الاوامر : " .. mute_cmd .. "\n" .. "______________________\n" .. "🔅↓  قفل المجموعه بالوقت : " .. auto_lock .. "\n"
          local TXTARCent = "<b>اعدادات المجموعــه </b>:\n\n" .. "🚦↓ قفل الكلايش  : " .. lock_spam .. "\n" .. "______________________\n" .. "🚦↓  قفل الروابط  : " .. mute_links .. "\n" .. "______________________\n" .. "🚦↓  قفل الويب :  " .. lock_wp .. "\n" .. "______________________\n" .. "🚦↓  قفل التاك (@) : " .. lock_tag .. "\n" .. "______________________\n" .. "🚦↓  قفل الهاشتاك (#) : " .. lock_htag .. "\n" .. "______________________\n" .. "🚦↓  قفل التوجيه : " .. lock_forward .. "\n" .. "______________________\n" .. "🚦↓  قفل المشاركه : " .. duplipost .. "\n" .. "______________________\n" .. "🚦↓  قفل البوتات :  " .. mute_bots .. "\n" .. "______________________\n" .. "🚦↓  قفل التعديل :  " .. mute_edit .. "\n" .. "______________________\n" .. "🚦↓  قفل التثبيت : " .. lock_pin .. "\n" .. "______________________\n" .. "🚦↓  قفل الانلاين : " .. mute_in .. "\n" .. "______________________\n" .. "🚦↓  قفل العربيه :  " .. lock_arabic .. "\n" .. "______________________\n" .. "🚦↓  قفل الانكليزيه : " .. lock_english .. "\n" .. "______________________\n" .. "🚦↓  قفل الماركدون : " .. markdown .. "\n" .. "______________________\n" .. "🚦↓  قفل البوست : " .. post .. "\n" .. "______________________\n" .. "🚦↓  قفل الالعاب : " .. game .. "\n" .. "______________________\n" .. "🚦↓  قفل الدخول : " .. member .. "\n" .. "______________________\n" .. "🚦↓  قفل الاشعارات : " .. lock_tgservice .. "\n" .. "______________________\n" .. "🚦↓  قفل التكرار : " .. mute_flood .. "\n" .. "______________________\n" .. "🚦↓  وضع التكرار : " .. floodstatus .. "\n" .. "______________________\n" .. "🕹️ وضع التحذير : " .. warnstatus .. "\n" .. "______________________\n" .. "🕹️ عدد التحذير : [ " .. sencwarn .. " ]\n" .. "______________________\n" .. "️🕹️ عدد احرف النص : [ " .. spam_c .. " ]\n\n"
          local TXTARMedia = " اعدادات الحمايه🎈 :\n\n" .. "🔹 قفل الدردشه : " .. mute_text .. "\n" .. "______________________\n" .. "🔹 قفل الصور : " .. mute_photo .. "\n" .. "______________________\n" .. "🔹 قفل الفيديو : " .. mute_video .. "\n" .. "______________________\n" .. "🔹 قفل السيلفي : " .. mute_selfvideo .. "\n" .. "______________________\n" .. "🔹 قفل المتحركه : " .. mute_gifs .. "\n" .. "______________________\n" .. "🔹 قفل الاغاني : " .. mute_music .. "\n" .. "______________________\n" .. "🔹 قفل الصوت : " .. mute_voice .. "\n" .. "______________________\n" .. "🔹 قفل الفايلات : " .. lock_file .. "\n" .. "______________________\n" .. "🔹 قفل الملصقات : " .. lock_sticker .. "\n" .. "______________________\n" .. "🔹 قفل الاتصال : " .. lock_contact .. "\n" .. "______________________\n" .. "🔹 قفل المواقع : " .. lock_location .. "\n"
          local TXTEN = "🔺 Group Settings 🔻:\n\n" .. "🔸  *Group Mode* :\n\n" .. "🔹 *Strict Mode* : " .. strict .. "\n" .. "______________________\n" .. "🔹 *Group Lock All* : " .. mute_all .. "\n" .. "______________________\n" .. "🔸 *Case Of No Answer* : " .. mute_cmd .. "\n" .. "______________________\n" .. "🔹 *Auto-lock Mode* : " .. auto_lock .. "\n" .. "______________________\n" .. "🎌  *Centerial Settings🎌 :\n\n" .. "🔸 *Lock Spam* : " .. lock_spam .. "\n" .. "______________________\n" .. "🔹 *Lock Links* : " .. mute_links .. "\n" .. "______________________\n" .. "🔸 *Lock Web-Page* :  " .. lock_wp .. "\n" .. "______________________\n" .. "🔹 *Lock Tag (@)* : " .. lock_tag .. "\n" .. "______________________\n" .. "🔹 *Lock Hashtag (#)* : " .. lock_htag .. "\n" .. "______________________\n" .. "🔸 *Lock Forward* : " .. lock_forward .. "\n" .. "______________________\n" .. "🔹 *Lock Dupli Post* : " .. duplipost .. "\n" .. "______________________\n" .. "🔸 *Lock Bots* :  " .. mute_bots .. "\n" .. "______________________\n" .. "🔹 *Lock Edit* :  " .. mute_edit .. "\n" .. "______________________\n" .. "🔸 *Lock Pin* : " .. lock_pin .. "\n" .. "______________________\n" .. "🔹 *Lock Inline* : " .. mute_in .. "\n" .. "______________________\n" .. "🔸 *Lock Farsi* :  " .. lock_arabic .. "\n" .. "______________________\n" .. "🔸 *Lock English* : " .. lock_english .. "\n" .. "______________________\n" .. "🔹 *Lock MarkDown* : " .. markdown .. "\n" .. "______________________\n" .. "🔸 *Lock Post* : " .. post .. "\n" .. "______________________\n" .. "🔹 *Lock Game* : " .. game .. "\n" .. "______________________\n" .. "🔸 *Lock Member* : " .. member .. "\n" .. "______________________\n" .. "🔸 *Lock TgService* : " .. lock_tgservice .. "\n" .. "______________________\n" .. "🔹 *Lock Flood* : " .. mute_flood .. "\n" .. "______________________\n" .. "🔸 *Flood Status* : " .. floodstatus .. "\n" .. "______________________\n" .. "🔹 *Flood Sensitivity* : `[" .. flood_m .. "]`\n" .. "______________________\n" .. "🔸 *Warn Status* : " .. warnstatus .. "\n" .. "______________________\n" .. "🔹 *Number Warn* : `[" .. sencwarn .. "]`\n" .. "______________________\n" .. "🔸 *Spam Sensitivity* : `[" .. spam_c .. [[
]`

]] .. " 🎌  *Media Settings*🎌 :\n\n" .. "🔸 *Lock Text* : " .. mute_text .. "\n" .. "______________________\n" .. "🔹 *Lock Photo* : " .. mute_photo .. "\n" .. "______________________\n" .. "🔸 *Lock Videos* : " .. mute_video .. "\n" .. "______________________\n" .. "🔹 *Lock Self Videos* : " .. mute_selfvideo .. "\n" .. "______________________\n" .. "🔹 *Lock Gifs* : " .. mute_gifs .. "\n" .. "______________________\n" .. "🔸 *Lock Music* : " .. mute_music .. "\n" .. "______________________\n" .. "🔹 *Lock Voice* : " .. mute_voice .. "\n" .. "______________________\n" .. "🔹 *Lock File* : " .. lock_file .. "\n" .. "______________________\n" .. "🔹 *Lock Sticker* : " .. lock_sticker .. "\n" .. "______________________\n" .. "🔸 *Lock Contact* : " .. lock_contact .. "\n" .. "______________________\n" .. "🔹 *Lock Location* : " .. lock_location .. "\n"
          local TXTENMode = " Group Settings 💭:\n\n" .. " 🌡️  *Group Mode* :\n\n" .. "🔺 *Strict Mode* : " .. strict .. "\n" .. "______________________\n" .. "🔻 *Group Lock All* : " .. mute_all .. "\n" .. "______________________\n" .. "🔺 *Case Of No Answer* : " .. mute_cmd .. "\n" .. "______________________\n" .. "🔻 *Auto-lock Mode* : " .. auto_lock .. "\n"
          local TXTENCent = "  *Centerial Settings* 🔊:\n\n" .. "▪️ *Lock Spam* : " .. lock_spam .. "\n" .. "______________________\n" .. "▪️ *Lock Links* : " .. mute_links .. "\n" .. "______________________\n" .. "▪️ *Lock Web-Page* :  " .. lock_wp .. "\n" .. "______________________\n" .. "▫️ *Lock Tag (@)* : " .. lock_tag .. "\n" .. "______________________\n" .. "▫️ *Lock Hashtag (#)* : " .. lock_htag .. "\n" .. "______________________\n" .. "▫️ *Lock Forward* : " .. lock_forward .. "\n" .. "______________________\n" .. "🔸 *Lock Duplicate Post* : " .. duplipost .. "\n" .. "______________________\n" .. "🔸 *Lock Bots* :  " .. mute_bots .. "\n" .. "______________________\n" .. "🔸 *Lock Edit* :  " .. mute_edit .. "\n" .. "______________________\n" .. "🔹 *Lock Pin* : " .. lock_pin .. "\n" .. "______________________\n" .. "🔹 *Lock Inline* : " .. mute_in .. "\n" .. "______________________\n" .. "🔹 *Lock Farsi* :  " .. lock_arabic .. "\n" .. "______________________\n" .. "▪️ *Lock English* : " .. lock_english .. "\n" .. "______________________\n" .. "▪️ *Lock MarkDown* : " .. markdown .. "\n" .. "______________________\n" .. "▪️ *Lock Post* : " .. post .. "\n" .. "______________________\n" .. "▫️ *Lock Game* : " .. game .. "\n" .. "______________________\n" .. "▫️ *Lock Join Member* : " .. member .. "\n" .. "______________________\n" .. "▫️ *Lock TgService* : " .. lock_tgservice .. "\n" .. "______________________\n" .. "🔹 *Lock Flood* : " .. mute_flood .. "\n" .. "______________________\n" .. "🔹 *Flood Status* : " .. floodstatus .. "\n" .. "______________________\n" .. "🔹*Flood Sensitivity* : `[" .. flood_m .. "]`\n" .. "______________________\n" .. "🔹 *Warn Status* : " .. warnstatus .. "\n" .. "______________________\n" .. "🔹 *Number Warn* : `[" .. sencwarn .. "]`\n" .. "______________________\n" .. "🔸 *Spam Sensitivity* : `[" .. spam_c .. "]`\n"
          local TXTENMedia = "   *Media Settings*📣 :\n\n" .. "✧ *Lock Text* : " .. mute_text .. "\n" .. "______________________\n" .. "✧ *Lock Photo* : " .. mute_photo .. "\n" .. "______________________\n" .. "✧ *Lock Videos* : " .. mute_video .. "\n" .. "______________________\n" .. "✧ *Lock Self Videos* : " .. mute_selfvideo .. "\n" .. "______________________\n" .. "✧ *Lock Gifs* : " .. mute_gifs .. "\n" .. "______________________\n" .. "✧ *Lock Music* : " .. mute_music .. "\n" .. "______________________\n" .. "✧ *Lock Voice* : " .. mute_voice .. "\n" .. "______________________\n" .. "✧ *Lock File* : " .. lock_file .. "\n" .. "______________________\n" .. "✧ *Lock Sticker* : " .. lock_sticker .. "\n" .. "______________________\n" .. "✧ *Lock Contact* : " .. lock_contact .. "\n" .. "______________________\n" .. "✧ *Lock Location* : " .. lock_location .. "\n"
          TXTEN = TXTEN:gsub("غیرفعال", "`Inactive`")
          TXTEN = TXTEN:gsub("فعال", "`Active`")
          TXTEN = TXTEN:gsub("الحذف", "`Deleting`")
          TXTEN = TXTEN:gsub("الطرد", "`Kicking`")
          TXTEN = TXTEN:gsub("الكتم", "`Mute`")
          TXTENCent = TXTENCent:gsub("غیرفعال", "`Inactive`")
          TXTENCent = TXTENCent:gsub("فعال", "`Active`")
          TXTENCent = TXTENCent:gsub("الحذف", "`Deleting`")
          TXTENCent = TXTENCent:gsub("الطرد", "`Kicking`")
          TXTENCent = TXTENCent:gsub("الكتم", "`Mute`")
          TXTENMode = TXTENMode:gsub("غیرفعال", "`Inactive`")
          TXTENMode = TXTENMode:gsub("فعال", "`Active`")
          TXTENMode = TXTENMode:gsub("الحذف", "`Deleting`")
          TXTENMode = TXTENMode:gsub("الطرد", "`Kicking`")
          TXTENMode = TXTENMode:gsub("الكتم", "`Mute`")
          TXTENMedia = TXTENMedia:gsub("غیرفعال", "`Inactive`")
          TXTENMedia = TXTENMedia:gsub("فعال", "`Active`")
          TXTENMedia = TXTENMedia:gsub("الحذف", "`Deleting`")
          TXTENMedia = TXTENMedia:gsub("الطرد", "`Kicking`")
          TXTENMedia = TXTENMedia:gsub("الكتم", "`Mute`")
          if text:match("^اعدادات المجموعه$") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, TXTEN, 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, TXTAR, 1, "md")
            end
          elseif text:match("^الاعدادات$") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, TXTENCent, 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, TXTARCent, 1, "html")
            end
						elseif text:match("^[Ss]ettings$") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, TXTENCent, 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, TXTARCent, 1, "html")
            end
          elseif (text:match("^الاعدادات خاص$")) and is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "✱↓  *Settings* has been \n*Sent* to your Pv 🎌", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "● ◄  تم ارسال الاعدادات خاص🎐", 1, "md")
            end
            send(msg.sender_user_id_, msg.id_, 1, TXTAR, 1, "md")
          end
        end
        if is_leader(msg) and text:match("^[Ee]cho (.*)$") then
          local txt = {
            string.match(text, "^([Ee]cho) (.*)$")
          }
          send(msg.chat_id_, 0, 1, txt[2], 1, "md")
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
        end
        if is_leader(msg) and text:match("^كول (.*)$") then
          local txt = {
            string.match(text, "^(كول) (.*)$")
          }
          send(msg.chat_id_, 0, 1, txt[2], 1, "md")
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          local chat = msg.chat_id_
          delete_msg(chat, msgs)
        end
        if is_sudo(msg) and (text:match("^[Rr]eload$") or text:match("^تنشيط$")) then
          load_config()
          setnumbergp()

          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "🔹 *Bot Successfully Reloaded* ❗️", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "🔹 تــــم تنشيط البوت 🎈", 1, "md")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") then
          if (text:match("^[Ss]etrules$") or text:match("^ضع قوانين$")) and check_user_channel(msg) then
            database:setex("rules" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true)
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "● ◄  Plese *Send* Group Rules 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "● ◄  <code>ارســـل القوانين الان</code> 📤", 1, "html")
            end
          end
          if (text:match("^[Dd]elrules$") or text:match("^مسح القوانين$")) and check_user_channel(msg) then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "● ◄  *Group Rules* Has Been *Cleared* 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "● ◄  <code> تــم مسح القوانيـــن </code> 📬", 1 , "html")
            end
            database:del("bot:rules" .. msg.chat_id_)
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Rr]ules$") or text:match("^القوانين$")) then
          local rules = database:get("bot:rules" .. msg.chat_id_)
          if rules then
            send(msg.chat_id_, msg.id_, 1, rules, 1, nil)
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "📪 *Group Rules* is not set 🎈", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "🔹 <b>لا توجــــد قوانين</b> 🎌",  1, "html")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Rr]ename (.*)$") and check_user_channel(msg) then
          local txt = {
            string.match(text, "^([Rr]ename) (.*)$")
          }
          changetitle(msg.chat_id_, txt[2])
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "● ◄  Group name has been *Changed* 📍 ", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "● ◄  <code>تم تغييــر اسم المجموعــه </code> 📃", 1, "html")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^ضع اسم (.*)$") and check_user_channel(msg) then
          local txt = {
            string.match(text, "^(ضع اسم) (.*)$")
          }
          changetitle(msg.chat_id_, txt[2])
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "● ◄  Group name has been *Changed* ❗️", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "● ◄  <cobe>تم تغييــر اسم المجموعــه </cobe> 📃", 1, "html")
          end
        end
		if text:match("^[Ss]etphoto$") or text:match("^ضع صوره") and is_owner(msg.sender_user_id_, msg.chat_id_) then
database:set('bot:setphoto'..msg.chat_id_..':'..msg.sender_user_id_,true)
if database:get("lang:gp:" .. msg.chat_id_) then
send(msg.chat_id_, msg.id_, 1, '🔹*Please send a photo noew🎣*', 1, 'md')
else 
send(msg.chat_id_, msg.id_, 1, '🔹 <b>قم بارسال صوره الان 📤</b>', 1, 'html')
end
end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^ضع اسم (.*)$") and check_user_channel(msg) then
          local txt = {
            string.match(text, "^(ضع اسم) (.*)$")
          }
          changetitle(msg.chat_id_, txt[2])
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "● ◄  Group name has been *Changed* ❗️", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "● ◄  تم تغييــر اسم المجموعــه 📃", 1, "md")
          end
        end
        if is_admin(msg.sender_user_id_) and text:match("^[Ll]eave (-%d+)$") or text:match("^غادر (-%d+)$")  then
          local txt = {
            string.match(text, "^([Ll]eave) (-%d+)$")
          }
		  local txt = {
            string.match(text, "^(غادر) (-%d+)$")
          }
          local leavegp = function(extra, result)
            if result.id_ then
              send(msg.chat_id_, msg.id_, 1, "🚺  <b>المجموعــۿ</b> : \n\n- <code>" .. result.title_ .. "</code>\n\n📛 <b>تم اخراج البوت منها💯</b>", 1, "html")
              if database:get("lang:gp:" .. result.id_) then
                send(result.id_, 0, 1, "• *The robot for some reason left the group *", 1, "html")
              else
                send(result.id_, 0, 1, "• <b> تم اخراج البوت 🎐</b>\n\n• <code>راسل المطور للتفعيل</code> 📮", 1, "html")
              end
              chat_leave(result.id_, bot_id)
              database:srem("bot:groups", result.id_)
            else
              send(msg.chat_id_, msg.id_, 1, "🔹 لا توجد مجموعه مفعله ❗️", 1, "md")
            end
          end
          getChat(txt[2], leavegp)
        end
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") and text:match("^[Aa]dd$") or text:match("^تفعيل$") then
          local adding = function(extra, result)
            local txt = {
              string.match(text, "^([Aa]dd)$")
            }
						local txt = {
              string.match(text, "^(تفعيل)$")
            }
            if database:get("bot:enable:" .. msg.chat_id_) then
              if not database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "✿↲<b> اِّهُِـــــلاً   مُــــــطٰٰــورٰٰي</b> 🎭  " .. (chat and chat.title_ or "") .. "\n\n✿↲ <b>تـم ✅ تفعيل المُٰـٰجمَوعــه 📍 </b>", 1, "html")
              else
                send(msg.chat_id_, msg.id_, 1, "✿↲  Group " .. (chat and chat.title_ or "") .. " is *Already* in *Management* list 📍 ", 1, "md")
              end
            else
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "✿↲ Group " .. (chat and chat.title_ or "") .. [[
 has been *Added* to *Management* list 📍
Please *specify* the group and the group reputation !
If you *want* to get the bot phone number , send command *Botphone* .]], 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "✿↲ <b>اِّهُِـــــــلا   مُــــــطٰٰورٰٰي 🎭  </b>" .. (chat and chat.title_ or "") .. "\n\n✿↲<b> المُٰـٰٰـجمَوعـٰٰــه 🚩 مفـٰٰعٰٰــلْهّٰ</b> 📍 ", 1, "html")
              end
              local fname = result.first_name_ or ""
              local lname = result.last_name_ or ""
              local username = "@" .. result.username_ or "---"
              send(bot_owner, 0, 1, "🌀↲ <b>تم اضافه مجموعه جديده</b>\n\n- <code>معلومات عن المطور 📪</code>\n�⇣<b> ايدي </b> : <code>" .. msg.sender_user_id_ .. "</code>\n�⇣ <code>الاسم</code> : " .. fname .. " " .. lname .. "\n�⇣ <code>المعرف</code> : " .. username .. "\n\n➢ <b>ايدي المجموعه </b>: <code>" .. msg.chat_id_ .. "</code>\n➢<b> اسم المجموعه 🐿</b>:\n " .. (chat and chat.title_ or "----") .. "\n\n➢<b> لاخراج البوت ارسل الامر التالي 🍃</b>: \n\n••  <code>غادر " .. msg.chat_id_ .. "</code>", 1, "html")
              database:set("bot:enable:" .. msg.chat_id_, true)
              database:setex("bot:charge:" .. msg.chat_id_, 2 * day, true)
              database:sadd("sudo:data:" .. msg.sender_user_id_, msg.chat_id_)
            end
          end
          getUser(msg.sender_user_id_, adding)
        end
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") and text:match("^[Rr]em$") or text:match("^تعطيل$") then
          local txt = {
            string.match(text, "^([Rr]em)$")
          }
					local txt = {
            string.match(text, "^(تعطيل)$")
          }
          if not database:get("bot:enable:" .. msg.chat_id_) then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "✿↲  Group " .. (chat and chat.title_ or "") .. " is *Not* In *Management* List 🎈", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "✿↲ <b>اِّهُِــــــلاً   مُـــُٰــطٰٰورٰٰي 🎭</b>  " .. (chat and chat.title_ or "") .. "\n\n✿↲ <b>المُٰـٰٰـجمَوعـٰٰــه 🚩 مُعطــلهِّ 📍</b> ", 1, "html")
            end
          else
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "✿↲  Group " .. (chat and chat.title_ or "") .. " Has Been *Removed* From *Management* List 🎈", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "✿↲ <b>اِّهُِـــــــلاً   مُـــُٰــطٰٰورٰٰي 🎭</b>  " .. (chat and chat.title_ or "") .. "\n\n✿↲ <b>تـم ✅ تعطيـل المُٰـٰجمَوعــه 📍 </b>", 1, "html")
            end
            database:del("bot:charge:" .. msg.chat_id_)
            database:del("bot:enable:" .. msg.chat_id_)
            database:srem("bot:groups", msg.chat_id_)
            database:srem("sudo:data:" .. msg.sender_user_id_, msg.chat_id_)
            local send_to_bot_owner = function(extra, result)
              local v = tonumber(bot_owner)
              local fname = result.first_name_ or ""
              local lname = result.last_name_ or ""
              local username = "@" .. result.username_ or "لا يوجد"
              send(v, 0, 1, "�⇣  تم تعطيل المجموعه :\n\n معلومات حول المطور : \n ✺ الاسم : " .. fname .. " " .. lname .. "\n ✺ المعرف : " .. username .. "\n🔰 ايدي المجموعه : <code>" .. msg.chat_id_ .. "</code>\n 🔰 اسم المجموعه : " .. (chat and chat.title_ or "---"), 1, "html")
            end
            getUser(msg.sender_user_id_, send_to_bot_owner)
          end
        end
        if is_admin(msg.sender_user_id_) and idf:match("-100(%d+)") and text:match("^[Rr]em (-%d+)$") or text:match("^تعطيل (-%d+)$") then
          do
            local gp = {
              string.match(text, "^([Rr]em) (-%d+)$")
            }
						local gp = {
              string.match(text, "^(تعطيل) (-%d+)$")
            }
            local send_to_bot_owner = function(extra, result)
              database:del("bot:enable:" .. gp[2])
              database:del("bot:charge:" .. gp[2])
              local v = tonumber(bot_owner)
              local fname = result.first_name_ or ""
              local lname = result.last_name_ or ""
              local username = "@" .. result.username_ or "--"
              send(msg.chat_id_, msg.id_, 1, "�⇣ <b>المجموعه </b? \n" .. gp[2] .. "\n\n<b>تم تعطيلها</b> 🎐", 1, "html")
              send(v, 0, 1, "➢ تم ازالة المجموعه✞\n\n↲ <b>الاسم </b>: " .. fname .. " " .. lname .. "\n • <b>المعرف</b> : " .. username .. "\n•<b> <ايدي المجموعه</b> : <code>" .. gp[2] .. "</code>", 1, "html")
              database:srem("sudo:data:" .. msg.sender_user_id_, gp[2])
              database:srem("bot:groups", gp[2])
            end
            getUser(msg.sender_user_id_, send_to_bot_owner)
          end
        else
        end
        if is_sudo(msg) and text:match("^[Dd]ata (%d+)") or text:match("^معلومات المطور (%d+)")  then
          local txt = {
            string.match(text, "^([Dd]ata) (%d+)$")
          }
          local get_data = function(extra, result)
            if result.id_ then
              if is_admin(result.id_) then
                local hash = "sudo:data:" .. result.id_
                local list = database:smembers(hash)
                local fname = result.first_name_ or ""
                local lname = result.last_name_ or ""
                local name = fname .. " " .. lname or "---"
                local susername = "@" .. result.username_ or ""
                local text = "⇖ معلومات المطور⇗:\n\n🤹🏼‍♀️ <b>اسمــه</b> " .. name .. "\n\n🎲 <b>معرفه</b> : " .. susername .. "\n\n※ <b>المجموعات الي اضافها</b> :\n\n"
                for k, v in pairs(list) do
                  local gp_info = database:get("group:Name" .. v)
                  local chatname = gp_info
                  if chatname then
                    text = text .. k .. " - " .. chatname .. " [" .. v .. "]\n"
                  else
                    text = text .. k .. " - [" .. v .. "]\n"
                  end
                end
                if #list == 0 then
                  text = "⇖ معلومات المطور⇗〽️:\n\n🤹🏼‍♀️ <b>اسمــه</b> " .. name .. "\n\n🎲 <b>معرفه</b> : " .. susername .. "\n\n※ <b>لا توجد مجموعات مضافه</b>⚜️ "
                end
                send_large_msg(msg.chat_id_, msg.id_, 1, text, 1, "html")
              else
                send(msg.chat_id_, msg.id_, 1, "✸↓ <b>العضو ليس من المطورين📍 </b>", 1, "html")
              end
            else
              send(msg.chat_id_, msg.id_, 1, "✸↓ <b>العضو ليس من المطورين📍</b> ", 1, "html")
            end
          end
          if database:get("bot:reloadingtime") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "● ◄  Bot is in a <b>State Reloading</b> 📍 "
            else
              text = "● ◄  تم تحديث البوت 🎐"
            end
            send(msg.chat_id_, msg.id_, 1, text, 1, "html")
          else
            getUser(txt[2], get_data)
          end
        end
        if is_admin(msg.sender_user_id_) and text:match("^[Dd]ata$") or text:match("^معلوماتي$")  and msg.reply_to_message_id_ == 0 then
          local get_data = function(extra, result)
            local hash = "sudo:data:" .. msg.sender_user_id_
            local list = database:smembers(hash)
            local fname = result.first_name_ or ""
            local lname = result.last_name_ or ""
            local name = fname .. " " .. lname or "---"
            local susername = "@" .. result.username_ or ""
            local text = "🚦↓ معلوماتك هيه〽️:\n\n📮 <b>اسمــك</b>: " .. name .. "\n\n🛋 <b>معرفك</b> : " .. susername .. "\n\n🌀 <b>المجموعات التي ضفتها</b> :\n\n"
            for k, v in pairs(list) do
              local gp_info = database:get("group:Name" .. v)
              local chatname = gp_info
              if chatname then
                text = text .. k .. " - " .. chatname .. " [" .. v .. "]\n"
              else
                text = text .. k .. " - [" .. v .. "]\n"
              end
            end
            if #list == 0 then
              text = "🚦↓ معلوماتك هيه〽️:\n\n📮 <b>اسمــك</b>: " .. name .. "\n\n🛋 <b>معرفك</b> : " .. susername .. "\n\n🌀 <b> لم تضف اي مجموعه</b>🎐"
            end
            send_large_msg(msg.chat_id_, msg.id_, 1, text, 1, "html")
          end
          if database:get("bot:reloadingtime") then
            if database:get("lang:gp:" .. msg.chat_id_) then
              text = "● ◄  Bot is in a <b>State Reloading</b> 📍 "
            else
              text = "● ◄  تم تحديث البوت 🎐 "
            end
            send(msg.chat_id_, msg.id_, 1, text, 1, "html")
          else
            getUser(msg.sender_user_id_, get_data)
          end
        end
        if is_sudo(msg) and text:match("^[Dd]ata$") or text:match("^معلومات المطور$")  and msg.reply_to_message_id_ ~= 0 then
          do
            local data_by_reply = function(extra, result)
              if is_admin(result.id_) then
                local hash = "sudo:data:" .. result.id_
                local list = database:smembers(hash)
                local fname = result.first_name_ or ""
                local lname = result.last_name_ or ""
                local name = fname .. " " .. lname
                local susername = "@" .. result.username_ or ""
                local text = "⇖ معلومات المطور⇗〽️:\n\n🤹🏼‍♀️ <b>اسمــه</b> : " .. name .. "\n\n🎲 <b>معرفه</b> : " .. susername .. "\n\n※ <b>المجموعات الي اضافها</b> :\n\n "
                for k, v in pairs(list) do
                  local gp_info = database:get("group:Name" .. v)
                  local chatname = gp_info
                  if chatname then
                    text = text .. k .. " - " .. chatname .. " [" .. v .. "]\n"
                  else
                    text = text .. k .. " - [" .. v .. "]\n"
                  end
                end
                if #list == 0 then
                  text = "⇖ معلومات المطور⇗〽️:\n\n🤹🏼‍♀️ <b>اسمــه</b> : " .. name .. "\n\n🎲 <b>معرفه</b> : " .. susername .. "\n\n※ <b>لا توجد مجموعات مضافه⚜</b>️"
                end
                send_large_msg(msg.chat_id_, msg.id_, 1, text, 1, "html")
              else
                send(msg.chat_id_, msg.id_, 1, "✸↓<b> العضو ليس من المطورين</b>📍 ", 1, "html")
              end
            end
            local start_get_data = function(extra, result)
              getUser(result.sender_user_id_, data_by_reply)
            end
            if database:get("bot:reloadingtime") then
              if database:get("lang:gp:" .. msg.chat_id_) then
                text = "● ◄  Bot is in a <b>State Reloading</b> 📍 "
              else
                text = "● ◄  تم تحديث البوت 🎐 "
              end
              send(msg.chat_id_, msg.id_, 1, text, 1, "html")
            else
              getMessage(msg.chat_id_, msg.reply_to_message_id_, start_get_data)
            end
          end
        else
        end
        if is_sudo(msg) and text:match("^[Dd]ata @(%S+)$") or text:match("^معلومات المطور @(%S+)$") then
          do
            local aps = {
              string.match(text, "^([Dd]ata) @(%S+)$")
            }
            local data_by_username = function(extra, result)
              if is_admin(result.id_) then
                local hash = "sudo:data:" .. result.id_
                local list = database:smembers(hash)
                local fname = result.first_name_ or ""
                local lname = result.last_name_ or ""
                local name = fname .. " " .. lname or "---"
                local susername = "@" .. result.username_ or ""
                local text = "⇖ معلومات المطور⇗ :\n\n🤹🏼‍♀️ <b>اسمــه</b>: " .. name .. "\n\n🎲 <b>معرفه</b> : " .. susername .. "\n\n※ <b>المجموعات الي اضافها </b>:\n\n "
                for k, v in pairs(list) do
                  local gp_info = database:get("group:Name" .. v)
                  local chatname = gp_info
                  if chatname then
                    text = text .. k .. " - " .. chatname .. " [" .. v .. "]\n"
                  else
                    text = text .. k .. " - [" .. v .. "]\n"
                  end
                end
                if #list == 0 then
                  text = "⇖ معلومات المطور⇗:\n\n🤹🏼‍♀️ <b>اسمــه</b>: " .. name .. "\n\n🎲 <b>معرفه</b> : " .. susername .. "\n\n※ <b>لا توجد مجموعات مضافه⚜</b>️ "
                end
                send_large_msg(msg.chat_id_, msg.id_, 1, text, 1, "html")
              else
                send(msg.chat_id_, msg.id_, 1, "✸↓ <b> العضو ليس من المطورين📍</b> ", 1, "html")
              end
            end
            local data_start_username = function(extra, result)
              if result.id_ then
                getUser(result.id_, data_by_username)
              else
                send(msg.chat_id_, msg.id_, 1, "✸↓ <b> العضو ليس من المطورين📍 </b>", 1, "html")
              end
            end
            if database:get("bot:reloadingtime") then
              if database:get("lang:gp:" .. msg.chat_id_) then
                text = "● ◄  Bot is in a <b>State Reloading</b> 📍 "
              else
                text = "● ◄  تم تحديث البوت 🎐 "
              end
              send(msg.chat_id_, msg.id_, 1, text, 1, "html")
            else
              resolve_username(aps[2], data_start_username)
            end
          end
        else
        end
        if is_admin(msg.sender_user_id_) and text:match("^[Jj]oin(-%d+)") or text:match("^ادخل(-%d+)")  then
          local txt = {
            string.match(text, "^([Jj]oin)(-%d+)$")
          }
          local JoinById = function(extra, result)
            send(msg.chat_id_, msg.id_, 1, "● ◄  تم اضافــة المجموعــه : \n\n " .. result.title_ .. " 📭", 1, "md")
            add_user(result.id_, msg.sender_user_id_, 20)
          end
          getChat(txt[2], JoinById)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^[Dd]el (%d+)$") then
          local matches = {
            string.match(text, "^([Dd]el) (%d+)$")
          }
          if msg.chat_id_:match("^-100") then
            if tonumber(matches[2]) > 100 or 1 > tonumber(matches[2]) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                pm = "🔅↓ <b>I can not deleted</b> 📍 "
              else
                pm = "▫️↓  يمكنك مسح من (1-100) رساله ⛱️"
              end
              send(msg.chat_id_, 0, 1, pm, 1, "html")
            else
              tdcli_function({
                ID = "GetChatHistory",
                chat_id_ = msg.chat_id_,
                from_message_id_ = 0,
                offset_ = 0,
                limit_ = tonumber(matches[2])
              }, delmsg, nil)
              if database:get("lang:gp:" .. msg.chat_id_) then
                pm = "● ◄  number 〖  <code>" .. matches[2] .. "</code>\n recent Message <b>Removed</b> 📍 "
              else
                pm = "● ◄  تم √ تنظيــف <b>〖  " .. matches[2] .. " 〗</b> رسالــه 📪"
              end
              send(msg.chat_id_, 0, 1, pm, 1, "html")
            end
          else
            if database:get("lang:gp:" .. msg.chat_id_) then
              pm = "🔅↓  This is not Possible in the <b>Conventional Group</b> 📍 "
            else
              pm = "🔅↓  لا يمكن تنظيف المجموعــه🎈"
            end
            send(msg.chat_id_, msg.id_, 1, pm, 1, "html")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and text:match("^تنظيف (%d+)$") then
          local matches = {
            string.match(text, "^(تنظيف) (%d+)$")
          }
          if msg.chat_id_:match("^-100") then
            if tonumber(matches[2]) > 100 or 1 > tonumber(matches[2]) then
              if database:get("lang:gp:" .. msg.chat_id_) then
                pm = "🔅↓  Please use a Number <b>Greater</b> than <code>1</code> and less than <code>100</code> 📍 "
              else
                pm = "▫️↓ يمكنك مسح من (1-100) رساله ⛱️ "
              end
              send(msg.chat_id_, 0, 1, pm, 1, "html")
            else
              getChatHistory(msg.chat_id_, 0, 0, tonumber(matches[2]), delmsg)
              if database:get("lang:gp:" .. msg.chat_id_) then
                pm = "● ◄  number 〖  <code>" .. matches[2] .. "</code>\n recent Message <b>Removed</b> 📍 "
              else
                pm = "● ◄  تم √ تنظيــف 〖  " .. matches[2] .. " 〗 رسالــه 📪 "
              end
              send(msg.chat_id_, 0, 1, pm, 1, "html")
            end
          else
            if database:get("lang:gp:" .. msg.chat_id_) then
              pm = "🔅↓  This is not Possible in the <b>Conventional Group</b> 📍 "
            else
              pm = "🔅↓  لا يمكن تنظيف المجموعــه🎈 "
            end
            send(msg.chat_id_, msg.id_, 1, pm, 1, "html")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and msg.reply_to_message_id_ ~= 0 and (text:match("^[Pp]in$") or text:match("^تثبيت$")) and check_user_channel(msg) then
          local id = msg.id_
          local msgs = {
            [0] = id
          }
          pinmsg(msg.chat_id_, msg.reply_to_message_id_, 0)
          database:set("pinnedmsg" .. msg.chat_id_, msg.reply_to_message_id_)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "● ◄   The Message has been *Pinned* 📍 ", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "● ◄  <b>تم تثبــيت الرسالــۿ 💌🎈</b>", 1, "html")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Uu]npin$") or text:match("^الغاء تثبيت$")) and check_user_channel(msg) then
          unpinmsg(msg.chat_id_)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "● ◄  The Message has been *UnPinned* 📍 ", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "● ◄ <b> تم الغاء تثبيــت الرسالــۿ </b>🎌", 1, "html")
          end
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and idf:match("-100(%d+)") and (text:match("^[Rr]epin$") or text:match("^اعادة تثبيت$")) and check_user_channel(msg) then
          local pin_id = database:get("pinnedmsg" .. msg.chat_id_)
          if pin_id then
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "● ◄  The Message has been *RePinned* 📍 ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "● ◄ <b> تم √ اعاده تثبــيت الرسالــۿ</b> 🎐", 1, "html")
            end
            pinmsg(msg.chat_id_, pin_id, 0)
          elseif database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "● ◄   Message Pinned the former was *not Found* 📍 ", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "● ◄ <b> لا ✘ توجد رسالۿ مثبته </b>📬", 1, "html")
          end
        end
        if (idf:match("-100(%d+)") or is_momod(msg.sender_user_id_, msg.chat_id_)) and text:match("^[Mm]e$") and msg.reply_to_message_id_ == 0 and check_user_channel(msg) then
          local get_me = function(extra, result)
            if tonumber(result.id_) == tonumber(karrar) then
        ten = "Sudo source 🍃"
              tar = "مطور السورس 🍃"
            elseif is_leaderid(result.id_) then
              ten = "Chief"
              tar = "مطور الاساسـي 🍃"
            elseif is_sudoid(result.id_) then
              ten = "Sudo"
              tar = "مطور 🐯"
            elseif is_admin(result.id_) then
              ten = "Bot Admin"
              tar = "ادمن في البوت 🐼"
            elseif is_owner(result.id_, msg.chat_id_) then
              ten = "Owner"
              tar = "مدير الكروب 🎐"
            elseif is_momod(result.id_, msg.chat_id_) then
              ten = "Group Admin"
              tar = "ادمن المجموعه🎌"
            elseif is_vipmem(result.id_, msg.chat_id_) then
              ten = "VIP Member"
              tar = "عضو مميز 💀"
            else
              ten = "Member"
              tar = "عـضـــو 🛩️"
            end
            if result.username_ then
              username = "@" .. result.username_
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              username = "Not Found !"
            else
              username = "لا يوجد"
            end
            local fname = result.first_name_ or ""
            local lname = result.last_name_ or ""
            local name = fname .. " " .. lname
            local _nl, ctrl_chars = string.gsub(text, "%c", "")
            if string.len(name) > 40 or ctrl_chars > 70 then
              name = "---"
            end
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "📛 <b>Name</b> : " .. name .. "\n\n🕹 <b>User</b> : " .. username .. "\n\n💡 <b>Your ID</b> : <code>" .. result.id_ .. "</code>\n\n📪 <b>Your Rank</b> : <b>" .. ten .. "</b> ", 1, "html")
            else
              send(msg.chat_id_, msg.id_, 1, "📛↓ <b>اســمك </b> : " .. name .. "\n\n🕹↓<b> مــعرفـك </b>: " .. username .. "\n\n💡↓ <b> الايدي </b>: <code>" .. result.id_ .. "</code>\n\n📪↓ <b> الرتبۿ </b>: <code> " .. tar .. "</code> " , 1, "html")
            end
          end
          getUser(msg.sender_user_id_, get_me)
        end
        if (idf:match("-100(%d+)") or is_momod(msg.sender_user_id_, msg.chat_id_)) and text:match("^موقعي$") and msg.reply_to_message_id_ == 0 and check_user_channel(msg) then
          local get_me = function(extra, result)
            if tonumber(result.id_) == tonumber(karrar) then
          ten = "Sudo source 🍃"
              tar = "مطور السورس 🍃"
            elseif is_leaderid(result.id_) then
              ten = "Chief"
              tar = "مطور الاساسـي 🍃"
            elseif is_sudoid(result.id_) then
              ten = "Sudo"
              tar = "مطور 🐯"
            elseif is_admin(result.id_) then
              ten = "Bot Admin"
              tar = "ادمن في البوت 🐼"
            elseif is_owner(result.id_, msg.chat_id_) then
              ten = "Owner"
              tar = "مدير الكروب 🎐"
            elseif is_momod(result.id_, msg.chat_id_) then
              ten = "Group Admin"
              tar = "ادمن المجموعه🎌"
            elseif is_vipmem(result.id_, msg.chat_id_) then
              ten = "VIP Member"
              tar = "عضو مميز 💀"
            else
              ten = "Member"
              tar = "عـضـــو 🛩️"
            end
            if result.username_ then
              username = "@" .. result.username_
            elseif database:get("lang:gp:" .. msg.chat_id_) then
              username = "Not Found"
            else
              username = "لا يوجد؟"
            end
            local fname = result.first_name_ or ""
            local lname = result.last_name_ or ""
            local name = fname .. " " .. lname
            local _nl, ctrl_chars = string.gsub(text, "%c", "")
            if string.len(name) > 40 or ctrl_chars > 70 then
              name = "---"
            end
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "📛 <b>Name</b> : " .. name .. "\n\n🕹 <b>User</b> : " .. username .. "\n\n💡 <b>Your ID</b> : <code>" .. result.id_ .. "</code>\n\n📪 <b>Your Rank</b> : <b>" .. ten .. "</b> ", 1, "html")
            else
              send(msg.chat_id_, msg.id_, 1, "📛↓ <b>اســمك </b> : " .. name .. "\n\n🕹↓<b> معرفـك </b>: " .. username .. "\n\n💡↓ <b> الايدي </b>: <code>" .. result.id_ .. "</code>\n\n📪↓ <b> الرتبۿ </b>: <code> " .. tar .. "</code> " , 1, "html")
            end
          end
          getUser(msg.sender_user_id_, get_me)
        end
        if is_momod(msg.sender_user_id_, msg.chat_id_) and (text:match("^[Gg]view$") or text:match("^عدد المشاهدات$")) then
          database:set("bot:viewget" .. msg.sender_user_id_, true)
          if database:get("lang:gp:" .. msg.chat_id_) then
            send(msg.chat_id_, msg.id_, 1, "● ◄  Plese *Forward* your Post 📍 : ", 1, "md")
          else
            send(msg.chat_id_, msg.id_, 1, "● ◄  ارسل لي توجيــۿ  للمنشــور 🎈: ", 1, "md")
          end
        end
          if is_leader(msg) and text:match("^[Rr]estart$") or text:match("^تحديث البيانات$")  then
            if msg.date_ < os.time() then
              print("\027[" .. color.white[1] .. ";" .. color.magenta[2] .. "m>>> OLD MSG <<<\027[00m")
              return false
            end
            if database:get("lang:gp:" .. msg.chat_id_) then
              send(msg.chat_id_, msg.id_, 1, "▫️↓  *Warning* 📍 \nBy doing this Operation all *Temporary data*  will be *Cleared* 📍 \nIf you wish to *continue* operation are otherwise the number *1* else enter the number *0* 📍  ", 1, "md")
            else
              send(msg.chat_id_, msg.id_, 1, "▪️↓   هل تريد تحديث بيانات البوت:\n\n✸ ارسل لي رقم 1 للموافقه🎌\n\n� ارسل لي رقم 0 للخروج من الامر🎐 ", 1, "md")
            end
            database:setex("Bot:restart" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 40, true)
          end
          if database:get("Bot:restart" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then
            if msg.date_ < os.time() - 1 then
              print("\027[" .. color.white[1] .. ";" .. color.magenta[2] .. "m>>> OLD MSG <<<\027[00m")
              return false
            end
            if text:match("^0$") then
              database:del("Gp:reset" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "🔅↓  The *Operation* was canceled 📍  ", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "🔅↓  تم الخروج من الامر 📬 ", 1, "md")
              end
            elseif text:match("^1$") then
              if database:get("lang:gp:" .. msg.chat_id_) then
                send(msg.chat_id_, msg.id_, 1, "💠 Bot Successfully *Restarted* 🎈", 1, "md")
              else
                send(msg.chat_id_, msg.id_, 1, "🚦↓  تم مسح بيانات البوت 🎐", 1, "md")
              end
              run_cmd("screen -d -m ./keeper autorun")
            end
          end
          if is_leader(msg) and text:match("^[Bb]ackup$") then
            send(msg.chat_id_, msg.id_, 1, " 👍 ", 1, "md")
          end
          elseif data.ID == "UpdateChat" then
            chat = data.chat_
            chats[chat.id_] = chat
          elseif data.ID == "UpdateUserAction" then
            local chat = data.chat_id_
            local user = data.user_id_
            local idf = tostring(chat)
            if idf:match("-100(%d+)") and not database:get("bot:muted:Time" .. chat .. ":" .. user) and database:sismember("bot:muted:" .. chat, user) then
              database:srem("bot:muted:" .. chat, user)
            end
          elseif data.ID == "UpdateMessageEdited" then
            local msg = data
            local get_msg_contact = function(extra, result)
              local text = result.content_.text_ or result.content_.caption_
              if tonumber(msg.sender_user_id_) == tonumber(api_id) then
                print("\027[" .. color.white[1] .. ";" .. color.magenta[2] .. "m>>> Edit From Api Bot <<<\027[00m")
                return false
              end
              if tonumber(result.sender_user_id_) == tonumber(our_id) then
                print("\027[" .. color.white[1] .. ";" .. color.magenta[2] .. "m>>> Edit From Bot <<<\027[00m")
                return false
              end
              if not is_vipmem(result.sender_user_id_, result.chat_id_) then
                check_filter_words(result, text)
                if database:get("editmsg" .. msg.chat_id_) then
                  local msgs = {
                    [0] = data.message_id_
                  }
                  delete_msg(msg.chat_id_, msgs)
                end
                if (text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]")) and database:get("bot:links:mute" .. result.chat_id_) then
                  local msgs = {
                    [0] = data.message_id_
                  }
                  delete_msg(msg.chat_id_, msgs)
                end
                if result.content_.entities_ and result.content_.entities_[0] and (result.content_.entities_[0].ID == "MessageEntityTextUrl" or result.content_.entities_[0].ID == "MessageEntityUrl") and database:get("bot:webpage:mute" .. result.chat_id_) then
                  local msgs = {
                    [0] = data.message_id_
                  }
                  delete_msg(msg.chat_id_, msgs)
                end
                if result.content_.web_page_ and database:get("bot:webpage:mute" .. result.chat_id_) then
                  local msgs = {
                    [0] = data.message_id_
                  }
                  delete_msg(msg.chat_id_, msgs)
                end
                if (text:match("[Hh][Tt][Tt][Pp]") or text:match("[Ww][Ww][Ww]") or text:match(".[Cc][Oo]") or text:match(".[Oo][Rr][Gg]") or text:match(".[Ii][Rr]")) and database:get("bot:webpage:mute" .. result.chat_id_) then
                  local msgs = {
                    [0] = data.message_id_
                  }
                  delete_msg(msg.chat_id_, msgs)
                end
                if text:match("@") and database:get("tags:lock" .. msg.chat_id_) then
                  local msgs = {
                    [0] = data.message_id_
                  }
                  delete_msg(msg.chat_id_, msgs)
                end
                if text:match("#") and database:get("bot:hashtag:mute" .. result.chat_id_) then
                  local msgs = {
                    [0] = data.message_id_
                  }
                  delete_msg(msg.chat_id_, msgs)
                end
                if text:match("[\216-\219][\128-\191]") and database:get("bot:arabic:mute" .. result.chat_id_) then
                  local msgs = {
                    [0] = data.message_id_
                  }
                  delete_msg(msg.chat_id_, msgs)
                end
                if (text:match("[A-Z]") or text:match("[a-z]")) and database:get("bot:english:mute" .. result.chat_id_) then
                  local msgs = {
                    [0] = data.message_id_
                  }
                  delete_msg(msg.chat_id_, msgs)
                end
                if database:get("sayedit" .. msg.chat_id_) and not database:get("editmsg" .. msg.chat_id_) and database:get("bot:editid" .. msg.message_id_) then
                  local old_text = database:get("bot:editid" .. msg.message_id_)
                  if database:get("lang:gp:" .. msg.chat_id_) then
                    send(msg.chat_id_, msg.message_id_, 1, "▶ Your <b>Messages</b> before Edit :\n\n<b>" .. old_text .. "</b>", 1, "html")
                  else
                    send(msg.chat_id_, msg.message_id_, 1, "◁ رسالتك قبل التعديل :\n\n<b>" .. old_text .. "</b>", 1, "html")
                  end
                  if result.id_ and result.content_.text_ then
                    database:set("bot:editid" .. result.id_, result.content_.text_)
                  end
                end
              end
            end
            getMessage(msg.chat_id_, msg.message_id_, get_msg_contact)
          elseif data.ID == "UpdateMessageSendSucceeded" then
            local msg = data.message_
            local d = data.disable_notification_
            local chat = chats[msg.chat_id_]
            local text = msg.content_.text_
            database:sadd("groups:users" .. msg.chat_id_, msg.sender_user_id_)
            if text then
              if text:match("✺⇣  راجع مطور البوت  لتفعيله في مجموعتك🏌️🎈") or text:match("Please visit as soon as possible to recharge the bot support !") then
                pinmsg(msg.chat_id_, msg.id_, 0)
              end

            end
          elseif data.ID == "UpdateOption" and data.name_ == "my_id" then
            tdcli_function({
              ID = "GetChats",
              offset_order_ = "9223372036854775807",
              offset_chat_id_ = 0,
              limit_ = 30
            }, dl_cb, nil)
            if data.value_.value_ then
              database:set("Bot:BotAccount", data.value_.value_)
            end
          end
        end
    end
  end
