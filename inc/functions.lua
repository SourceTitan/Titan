--[[
─▄█▀█▄──▄███▄─
▐█░██████████▌
─██▒█████████─
──▀████████▀──ܛ @Hskh56
─────▀██▀─────
ܛ ＭᎯẊ ‿ @uop70
تم تطوير وبرمجة السورس من قبل حسن العراقي
ܛ @Hskh56 ‿ @uop70 
#-------------------------------------------------------------------
]]

function dl_cb(a,d) end
 
function GetInputFile(file)
local file = file or "" 
if file:match('/') then
infile = {ID= "InputFileLocal", path_  = file}
elseif file:match('^%d+$') then
infile = {ID= "InputFileId", id_ = file}
else
infile = {ID= "InputFilePersistentId", persistent_id_ = file}
end
return infile
end

local clock = os.clock
function sleep(time)  
local untime = clock()
while clock() - untime <= time do end
end

function sendMsg(chat_id,reply_id,text,markup,funcb)
pcall(tdcli_function({
ID="SendMessage",
chat_id_=chat_id,
reply_to_message_id_= reply_id,
disable_notification_=1,
from_background_= 1,
reply_markup_= nil,
input_message_content_={
ID = "InputMessageText",
text_= text,
disable_web_page_preview_= 1,
clear_draft_= 0,
entities_={},
parse_mode_=  {ID = "TextParseModeMarkdown"} ,
}},funcb or dl_cb,nil)
)
end

function sendPhoto(chat_id,reply_id,photo,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessagePhoto",
photo_ = GetInputFile(photo),
added_sticker_file_ids_ = {},
width_ = 0,
height_ = 0,
caption_ = caption or ''
}
},func or dl_cb,nil))
end
	
	 
function sendVoice(chat_id,reply_id,voice,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVoice",
voice_ = GetInputFile(voice),
duration_ = '',
waveform_ = '',
caption_ = caption or ''
}},func or dl_cb,nil))
end

function sendAnimation(chat_id,reply_id,animation,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAnimation",
animation_ = GetInputFile(animation),
width_ = 0,
height_ = 0,
caption_ = caption or ''
}},func or dl_cb,nil))
end

function sendAudio(chat_id,reply_id,audio,title,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAudio",
audio_ = GetInputFile(audio),
duration_ = '',
title_ = title or '',
performer_ = '',
caption_ = caption or ''
}},func or dl_cb,nil))
end

function sendSticker(chat_id,reply_id,sticker,func)
pcall(tdcli_function({
ID='SendMessage',
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageSticker",
sticker_ = GetInputFile(sticker),
width_ = 0,
height_ = 0
}},func or dl_cb,nil))
end

function sendVideo(chat_id,reply_id,video,caption,func)
pcall(tdcli_function({ 
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 0,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVideo",  
video_ = GetInputFile(video),
added_sticker_file_ids_ = {},
duration_ = 0,
width_ = 0,
height_ = 0,
caption_ = caption or ''
}},func or dl_cb,nil))
end


function sendDocument(chat_id,reply_id,document,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageDocument",
document_ = GetInputFile(document),
caption_ = caption
}},func or dl_cb,nil))
end


function fwdMsg(chat_id,from_chat_id,msg_id,func)
pcall(tdcli_function({
ID="ForwardMessages",
chat_id_ = chat_id,
from_chat_id_ = from_chat_id,
message_ids_ = {[0] = msg_id},
disable_notification_ = 0,
from_background_ = 0
},func or dl_cb,nil))
end


function SendMention(chat_id,user_id,msg_id,Text,offset, length) 
pcall(tdcli_function ({ 
ID = "SendMessage", 
chat_id_ = chat_id, 
reply_to_message_id_ = msg_id, 
disable_notification_ = 0, 
from_background_ = 1, 
reply_markup_ = nil, 
input_message_content_ = { 
ID = "InputMessageText", 
text_ = Text, 
disable_web_page_preview_ = 1, 
clear_draft_ = 0, 
entities_ = {[0]={ 
ID="MessageEntityMentionName", 
offset_ = offset , 
length_ = length , 
user_id_ = user_id },},},
},dl_cb, nil))
end
   
function sendChatAction(chatid,action,func)
pcall(tdcli_function({ID = 'SendChatAction',chat_id_ = chatid,action_ = {ID = "SendMessage"..action.."Action",progress_ = 1},}, func or dl_cb,nil))
end

--================================{{  GetChannelFull  }} ===================================
function download_file(Link,Bath)
local Get_Files, res = https.request(Link)
print(res)
if res == 200 then
print("DONLOADING_FROM_URL: "..Link)
local FileD = io.open(Bath,'w+')
FileD:write(Get_Files)
FileD:close()
end
end
--================================{{  GetChannelFull  }} ===================================

function GetFullChat(GroupID,func)
pcall(tdcli_function({ID="GetChannelFull",channel_id_ = GroupID:gsub('-100','')},func or dl_cb,nil))
end

--================================{{  KickUser  }} ===================================

function kick_user(user_id,chat_id,func)
pcall(tdcli_function({ID="ChangeChatMemberStatus",chat_id_=chat_id,user_id_=user_id,status_={ID="ChatMemberStatusKicked"}},func or dl_cb,nil))
end

--================================{{  UnBlock  }} ===================================

function StatusLeft(chat_id,user_id,func)
pcall(tdcli_function({ID="ChangeChatMemberStatus",chat_id_=chat_id,user_id_=user_id,status_={ID="ChatMemberStatusLeft"}},func or dl_cb,nil))
end
--================================{{  DeleteMsg  }} ===================================

function Del_msg(GroupID,msg_id,func)
pcall(tdcli_function({ID="DeleteMessages",chat_id_=GroupID,message_ids_={[0]=msg_id}},func or dl_cb,nil))
end


function GetPhotoUser(User,func)
pcall(tdcli_function({ID='GetUserProfilePhotos',user_id_=User,offset_=0,limit_=1},func,nil))
end
  
function GetMsgInfo(UID,Msg_id,Cb,Arg)
pcall(tdcli_function({ID="GetMessage",chat_id_ = UID,message_id_ = Msg_id},Cb,Arg))
end

function GetUserName(User,Cb,Arg)
pcall(tdcli_function({ID="SearchPublicChat",username_ = User},Cb,Arg))
end

function GetUserID(User,Cb,Arg)
pcall(tdcli_function({ID="GetUser",user_id_ = User},Cb,Arg))
end


function GroupTitle(GroupID,func)
pcall(tdcli_function({ID="GetChat",chat_id_ = GroupID},func or dl_cb,nil))
end

function GetChannelAdministrators(GroupID,func,limit)
pcall(tdcli_function({ID="GetChannelMembers",channel_id_= GroupID:gsub('-100',''),filter_={ID = "ChannelMembersAdministrators"},offset_=0,limit_=40},func,nil))
end 

function GetChatMember(GroupID,UserID,func)
pcall(tdcli_function({ID='GetChatMember',chat_id_ = GroupID,user_id_ = UserID},func,nil))
end

function GetHistory(GroupID,NumDel,func)
pcall(tdcli_function({ID="GetChatHistory",chat_id_ = GroupID,from_message_id_ = 0,offset_ = 0,limit_ = NumDel},func,nil))
end
-----------------------{ Start Api Token Bot}-----------------------------
function getr(br)
if br then
return "✓"
else
return "✖️"
end
end

function GetApi(web)
local info, res = https.request(web)
if res ~= 200 then return false end
local success, res = pcall(JSON.decode, info);
if success then
if not res.ok then return false end
res = res
else
res = false
end
return res
end


--================================{{  ExportChatInviteLink  }} ===================================

function ExportLink(GroupID)
local GetLin,res = https.request(ApiToken..'/exportChatInviteLink?chat_id='..GroupID)
print(res)
if res ~= 200 then return false end
local success, res = pcall(JSON.decode, GetLin)
return (res or "")
end

function Restrict(chat_id,user_id,right)
if right == 1 then
https.request(ApiToken..'/restrictChatMember?chat_id='..chat_id..'&user_id='..user_id..'&can_send_messages=false')
elseif right == 2 then
https.request(ApiToken..'/restrictChatMember?chat_id='..chat_id..'&user_id='..user_id..'&can_send_messages=true&can_send_media_messages=true&can_send_other_messages=true&can_add_web_page_previews=true')
elseif right == 3 then
https.request(ApiToken..'/restrictChatMember?chat_id='..chat_id..'&user_id='..user_id..'&can_send_messages=true&can_send_media_messages=false&can_send_other_messages=false&can_add_web_page_previews=false')
end
end


function send_msg(chat_id,text,msg_id)
local url = ApiToken..'/sendMessage?chat_id='..chat_id..'&text='..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true"
if msg_id then
url = url.."&reply_to_message_id="..msg_id/2097152/0.5
end
return GetApi(url)
end

function EditMsg(chat_id,message_id,text,funcb)
local url = ApiToken..'/editMessageText?chat_id='..chat_id ..'&message_id='..tonumber(message_id/2097152/0.5)..'&text='..URL.escape(text)..'&parse_mode=Markdown&disable_web_page_preview=true'
return GetApi(url)
end

function send_key(chat_id,text,keyboard,inline,msg_id)
local response = {}
response.inline_keyboard = inline
response.keyboard = keyboard
response.resize_keyboard = true
response.one_time_keyboard = false
local Send_api = ApiToken.."/sendMessage?chat_id="..chat_id.."&text="..
URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response))
if msg_id then 
Send_api = Send_api.."&reply_to_message_id="..msg_id/2097152/0.5
end
return GetApi(Send_api)
end 

function GetFilePath(FileID)
local UrlInfo = https.request(ApiToken..'/getfile?file_id='..FileID)
return ApiToken..'/'..JSON.decode(UrlInfo).result.file_path
end

----------------------{ End Api Token Bot }-----------------------------

----------------------{ Get Name Bot }-----------------------------
Bot_Name = redis:get(Titan..":NameBot:")


function GetType(ChatID) 
if tostring(ChatID):match('^-100') then
return 'channel' 
elseif tostring(ChatID):match('-') then
return 'chat' 
else 
return 'pv'
end 
end


function ResolveUser(datax)
if datax.username_ then 
USERNAME = '@'..Flter_Markdown(datax.username_)
else 
USERNAME = FlterName(datax.first_name_..' '..(datax.last_name_ or ""),20) 
USERNAME = "["..USERNAME.."](tg://user?id="..datax.id_..")"
end
return USERNAME
end


function FlterName(Name,Num)
local CharNumber = tonumber(Num or 25)
local Name = tostring(Name):lower()
Name = Name:gsub("https://[%a%d_]+",'') 
Name = Name:gsub("http://[%a%d_]+",'') 
Name = Name:gsub("telegram.dog/[%a%d_]+",'') 
Name = Name:gsub("telegram.me/[%a%d_]+",'') 
Name = Name:gsub("t.me/[%a%d_]+",'') 
Name = Name:gsub("[%a%d_]+.pe[%a%d_]+",'') 
Name = Name:gsub("@[%a%d_]+",'')
Name = Name:gsub("#[%a%d_]+",'')

Name = FlterEmoje(Name)
Name = Flterzhrfa(Name)
Name = utf8.gsub(Name,"✸","")
Name = utf8.gsub(Name,"ﮧ","")
Name = utf8.gsub(Name,"ܛ ","")
Name = utf8.gsub(Name,"ٜ","")
Name = utf8.gsub(Name,"༒","")
Name = utf8.gsub(Name,"ᬼ","")
Name = utf8.gsub(Name,"̅","")
Name = utf8.gsub(Name,"❦","")
Name = utf8.gsub(Name,"ᝢ","")
Name = utf8.gsub(Name,"༼","")
Name = utf8.gsub(Name,"๘","")
Name = utf8.gsub(Name,"༽","")
Name = utf8.gsub(Name,"⎨","")
Name = utf8.gsub(Name,"ௌ","")
Name = utf8.gsub(Name,"⎬","")
Name = utf8.gsub(Name,"ۤ","")
Name = utf8.gsub(Name,"꧄","")
Name = utf8.gsub(Name,"░","")
Name = utf8.gsub(Name,"͝","")
Name = utf8.gsub(Name,"¥","")
Name = utf8.gsub(Name,"َ","")
Name = utf8.gsub(Name,"✧","")
Name = utf8.gsub(Name,"ֆ","")
Name = utf8.gsub(Name,"ۖ","")
Name = utf8.gsub(Name,"(])","")
Name = utf8.gsub(Name,"","")
Name = utf8.gsub(Name,"֧","")
Name = utf8.gsub(Name," ","")
Name = utf8.gsub(Name,"","")
Name = utf8.gsub(Name,"﴿","")
Name = utf8.gsub(Name,"₪","")
Name = utf8.gsub(Name,"ૣ","")
Name = utf8.gsub(Name,"☆","")
Name = utf8.gsub(Name,"͞","")
Name = utf8.gsub(Name,"ٖ","")
Name = utf8.gsub(Name,"֯","")
Name = utf8.gsub(Name,"‘","")
Name = utf8.gsub(Name,"ُ","")
Name = utf8.gsub(Name,"ꪆ","")
Name = utf8.gsub(Name,"↡","")
Name = utf8.gsub(Name,"᭄","")
Name = utf8.gsub(Name,"௵","")
Name = utf8.gsub(Name,"♚","")
Name = utf8.gsub(Name,"ﹻ","")
Name = utf8.gsub(Name,"ۦ","")
Name = utf8.gsub(Name,"͟","")
Name = utf8.gsub(Name,"̶","")
Name = utf8.gsub(Name,"_","")
Name = utf8.gsub(Name,"`","")
Name = utf8.gsub(Name,"‏","")
Name = utf8.gsub(Name,"๘","")
Name = utf8.gsub(Name,"͡","")
Name = utf8.gsub(Name,"⸨","")
Name = utf8.gsub(Name,"▓","")
Name = utf8.gsub(Name,"ـ","")
Name = utf8.gsub(Name,"ஞ","")
Name = utf8.gsub(Name,"❥","")
Name = utf8.gsub(Name,"ꨩ","")
Name = utf8.gsub(Name,"‏","")
Name = utf8.gsub(Name,"ೈ","")
Name = utf8.gsub(Name,"٘","")
Name = utf8.gsub(Name,"ࣧ","")
Name = utf8.gsub(Name,"“","")
Name = utf8.gsub(Name,"•","")
Name = utf8.gsub(Name,']',"")
Name = utf8.gsub(Name,"}","")
Name = utf8.gsub(Name,"ཻ","")
Name = utf8.gsub(Name,"⸩","")
Name = utf8.gsub(Name,"ِ","")
Name = utf8.gsub(Name,"ࣩ","")
Name = utf8.gsub(Name,"ٰ","")
Name = utf8.gsub(Name,"ہ","")
Name = utf8.gsub(Name,"ۙ","")
Name = utf8.gsub(Name,"ৡ","")
Name = utf8.gsub(Name,"҉","")
Name = utf8.gsub(Name,"ٙ","")
Name = utf8.gsub(Name,"ّ","")
Name = utf8.gsub(Name,"ۨ","")
Name = utf8.gsub(Name,"ै","")
Name = utf8.gsub(Name,"ೋ","")
Name = utf8.gsub(Name,"๋","")
Name = utf8.gsub(Name,"͢","")
Name = utf8.gsub(Name,"ﮩ","")
Name = utf8.gsub(Name,"❁","")
Name = utf8.gsub(Name,"⃤","")
Name = utf8.gsub(Name,"ﮮ","")
Name = utf8.gsub(Name,"⸽","")
Name = utf8.gsub(Name,"̝","")
Name = utf8.gsub(Name,"{","")
Name = utf8.gsub(Name,"𖤍","")
Name = utf8.gsub(Name,"|","")
Name = utf8.gsub(Name,"ۧ","")
Name = utf8.gsub(Name,"ۗ","")
Name = utf8.gsub(Name,"ۣ","")
Name = utf8.gsub(Name,"ٍ","")
Name = utf8.gsub(Name,"ؔ","")
Name = utf8.gsub(Name,"ٌ","")
Name = utf8.gsub(Name,"͜","")
Name = utf8.gsub(Name,"ꪸ","")
Name = utf8.gsub(Name,"ۂ","")
Name = utf8.gsub(Name,"»","")
Name = utf8.gsub(Name,"̚","")
Name = utf8.gsub(Name,"𖣁","")
Name = utf8.gsub(Name,"۫","")
Name = utf8.gsub(Name,"ْ","")
Name = utf8.gsub(Name,"ৣ","")
Name = utf8.gsub(Name,"ے","")
Name = utf8.gsub(Name,"♱","")
Name = utf8.gsub(Name,"℘","")
Name = utf8.gsub(Name,"ً","")
Name = utf8.gsub(Name,"۪","")
Name = utf8.gsub(Name,"❰","")
Name = utf8.gsub(Name,"꯭","")
Name = utf8.gsub(Name,"ٚ","")
Name = utf8.gsub(Name,"﷽","")
Name = utf8.gsub(Name,"ۛ","")
Name = utf8.gsub(Name,"〞","")
Name = utf8.gsub(Name,"█","")
Name = utf8.gsub(Name,"✮","")
Name = utf8.gsub(Name,"✿","")
Name = utf8.gsub(Name,"✺","")
Name = utf8.gsub(Name,"̐","")
Name = utf8.gsub(Name,"ྀ","")
Name = utf8.gsub(Name,"←","")
Name = utf8.gsub(Name,"↝","")
Name = utf8.gsub(Name,"ؒ","")
Name = utf8.gsub(Name,"̷","")
Name = utf8.gsub(Name,"⇣","")
Name = utf8.gsub(Name,"«","")
Name = utf8.gsub(Name,"ٛ","")
Name = utf8.gsub(Name,"ॠ","")
Name = utf8.gsub(Name,"̲","")
Name = utf8.gsub(Name,"-","")
Name = utf8.gsub(Name,"͛","")
Name = utf8.gsub(Name,"☬","")
Name = utf8.gsub(Name,"ٓ","")
Name = utf8.gsub(Name,"❱","")
Name = utf8.gsub(Name,"ۓ","")
Name = utf8.gsub(Name,"‏","")
Name = utf8.gsub(Name,"௸","")

if utf8.len(Name) > CharNumber then
Name = utf8.sub(Name,0,CharNumber)..'...' 
end
local CheckName = Name:gsub(' ','')
if not CheckName then 
Name = 'الاسم سبام 📛'
end
return utf8.escape(Name)
end

function Flter_Markdown(TextMsg) 
local Text = tostring(TextMsg)
Text = Text:gsub('_',[[\_]])
Text = Text:gsub(' ','\\ ')
Text = Text:gsub('`','\\`')
local Hyperlink = Text:match('[(](. )[)]')
local Hyperlink1 = Text:match('[[](. )[]]')
if Hyperlink and Hyperlink1 then
Hyperlink = "("..Hyperlink:gsub([[\_]],'_')..")"
Text = Text:gsub('[(](. )[)]',Hyperlink ) 
Hyperlink1 = Hyperlink1:gsub([[\_]],'_')
Hyperlink1 = "["..Hyperlink1:gsub('[[][]]','').."]"
Text = Text:gsub('[[](. )[]]',Hyperlink1 ) 
end
return Text 
end



function Get_Ttl(msgs)
local MsgShow = '' 
local NumMsg = tonumber(msgs)
if NumMsg < 80 then 
MsgShow = 'سايق مخده😹 ' 
elseif NumMsg < 300 then
MsgShow = 'الله بلخير😐💔' 
elseif NumMsg < 900 then 
MsgShow = 'وينك وين التفاعل 😐' 
elseif NumMsg < 5000 then 
MsgShow = 'استمر بطل😻💪🏻' 
elseif NumMsg < 9000 then 
MsgShow = 'جيد جدن😻♥' 
elseif NumMsg < 10000 then 
MsgShow = 'ملك التفاعل😾👊🏻' 
elseif NumMsg < 13000 then 
MsgShow = 'مــلــک✔️💯😻'
elseif NumMsg < 100000 then 
MsgShow = 'ملكوت التفاعل استمر😻❤️' 
elseif NumMsg > 150000 then 
MsgShow = 'ملك التلكرام??♥' 
end
return MsgShow 
end

function Getrtba(UserID,ChatID)
if UserID == our_id then 
var = 'هذا البوت 🙄☝🏿' 
elseif  UserID == SUDO_ID then
var = 'مطور اساسي 👨🏻‍✈️' 
elseif redis:sismember(Titan..':SUDO_BOT:',UserID) then
var = 'مطور البوت 👨🏽‍💻' 
elseif redis:sismember(Titan..':KARA_BOT:'..ChatID,UserID) then
var = ' المنشىء الاساسي👷🏽' 
elseif redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then
var = ' المنشىء 👷🏽' 
elseif redis:sismember(Titan..'owners:'..ChatID,UserID) then
var = 'مدير البوت 👨🏼‍⚕️' 
elseif redis:sismember(Titan..'admins:'..ChatID,UserID) then
var = 'ادمن في البوت 👨🏼‍🎓' 
elseif redis:sismember(Titan..'whitelist:'..ChatID,UserID) then
var = 'عضو مميز ⭐️' 
else
var = 'فقط عضو 🙍🏼‍♂️' 
end
return var
end


function SaveNumMsg(msg)
if msg.edited then
redis:incr(Titan..':edited:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.text and not msg.forward_info then
redis:incr(Titan..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_)
elseif msg.adduser then 
redis:incr(Titan..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.photo then
redis:incr(Titan..':photo:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.sticker then
redis:incr(Titan..':sticker:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.voice then
redis:incr(Titan..':voice:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.audio then
redis:incr(Titan..':audio:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.video or msg.video_note then
redis:incr(Titan..':video:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.animation then
redis:incr(Titan..':animation:'..msg.chat_id_..':'..msg.sender_user_id_)
end
end


--================================{{  We Sudoer  }} ===================================

function we_sudo(msg)
if msg.sender_user_id_ == SUDO_ID then
return true 
else
return false
end 
end


--================================{{  List Sudoer  }} ===================================


function sudolist(msg)
local list = redis:smembers(Titan..':SUDO_BOT:')
message = '👨🏽‍💻 ܛ  قائمه الـمـطـوريـن : \n\n`👨‍✈️ܛ مطور اساسي`  \n'..SUDO_USER..' » ❪' ..SUDO_ID.. '❫\n ┄─┅══┅─┄  \n'
if #list==0 then  message = message.."  لا يوجد مطورين حاليا \n📛  "
else
for k,v in pairs(list) do
local info = redis:hgetall(Titan..'username:'..v)
local count = redis:scard(Titan..'mtwr_count'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '~⪼ '..(info.username or '')..' » ❪`' ..v.. '`❫\n'
else
message = message ..k.. '~⪼ '..(info.username or '')..' l » ❪`' ..v.. '`❫\n'
end
end 
end
send_msg(msg.chat_id_,message,msg.id_)
print(message)
return false 
end

--================================{{  List owner  }} ===================================

function ownerlist(msg)
local message = ' ⭐️ܛ  المنشئيين : \n\n'
local monsha = redis:smembers(Titan..':MONSHA_BOT:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."♦️ܛ Not Creator ~⪼ لا يوجد منشئيين !\n"
else
for k,v in pairs(monsha) do
local info = redis:hgetall(Titan..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '~⪼ '..(info.username or '')..' » ❪`' ..v.. '`❫ \n'
else
message = message ..k.. '~⪼ '..(info.username or '')..' l » ❪`' ..v.. '`❫ \n'
end
end
end
message = message..' ┄─┅══┅─┄ \n\n📋ܛ  قائمه المدراء : \n\n'
local list = redis:smembers(Titan..'owners:'..msg.chat_id_)
if #list == 0 then  
message = message.."♦️ܛ Not Director ~⪼ لا يوجد مدراء !\n" 
else
for k,v in pairs(list) do
local info = redis:hgetall(Titan..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '~⪼ '..(info.username or '')..' » ❪`' ..v.. '`❫ \n'
else
message = message ..k.. '~⪼ '..(info.username or '')..' l » ❪`' ..v.. '`❫ \n'
end
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end

--================================{{ List Admins  }} ===================================

function GetListAdmin(msg)
local list = redis:smembers(Titan..'admins:'..msg.chat_id_)
if #list==0 then  return  "♦️ ܛ  لا يوجد ادمن في هذه المجموعه \n❕" end
message = '📋 ܛ  قائمه الادمنيه : \n\n'
for k,v in pairs(list) do
local info = redis:hgetall(Titan..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '~⪼ '..(info.username or '')..' » ❪`' ..v.. '`❫ \n'
else
message = message ..k.. '~⪼ '..(info.username or '')..' l » ❪`' ..v.. '`❫ \n'
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end

--================================{{  List WhiteList  }} ===================================

function whitelist(msg)
local list = redis:smembers(Titan..'whitelist:'..msg.chat_id_)
if #list == 0 then return " ♦️ܛ لا يوجد مميزين في القائمه  " end
message = '📋 ܛ  قائمه الاعضاء المميزين :\n'   
for k,v in pairs(list) do
local info = redis:hgetall(Titan..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '~⪼ '..(info.username or '')..' » ❪`' ..v.. '`❫ \n'
else
message = message ..k.. '~⪼ '..(info.username or '')..' l » ❪`' ..v.. '`❫ \n'
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end

--================================{{  Mute User And List Mute User   }} ===================================

function MuteUser(Group, User)
if redis:sismember(Titan..'is_silent_users:'..Group,User) then 
return true 
else
return false
end 
end


function MuteUser_list(msg)
local list = redis:smembers(Titan..'is_silent_users:'..msg.chat_id_)
if #list==0 then return "📋 ܛ  لايوجد اعضاء مكتومين " end
message = '📋 ܛ  قائمه الاعضاء المكتومين :\n'
for k,v in pairs(list) do
local info = redis:hgetall(Titan..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '~⪼ '..(info.username or '')..' » ❪`' ..v.. '`❫ \n'
else
message = message ..k.. '~⪼ '..(info.username or '')..' l » ❪`' ..v.. '`❫ \n'
end
end
send_msg(msg.chat_id_,message,msg.id_)
return false
end


--================================{{  Check Banned And List Banned  }} ===================================


function Check_Banned(Group,User)
if redis:sismember(Titan..'banned:'..Group,User) then 
return true 
else
return false
end 
end

function GetListBanned(msg)
local list = redis:smembers(Titan..'banned:'..msg.chat_id_)
if #list==0 then return "📋 ܛ  لايوجد أعضاء محظورين " end
message = '📋 ܛ  قائمه الاعضاء المحظورين :\n'
for k,v in pairs(list) do
local info = redis:hgetall(Titan..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '~⪼ '..(info.username or '')..' » ❪`' ..v.. '`❫ \n'
else
message = message ..k.. '~⪼ '..(info.username or '')..' l » ❪`' ..v.. '`❫ \n'
end
end 
send_msg(msg.chat_id_,message,msg.id_)
return false
end



--================================{{  Sudoer  }} ===================================

function GeneralBanned(User)
if redis:sismember(Titan..'gban_users',User) then 
return true 
else
return false
end 
end

function GetListGeneralBanned(msg)
local list = redis:smembers(Titan..'gban_users')
if #list==0 then return  " ♦️ܛ لايوجد اعضاء محظورين عام " end
message = '🛠 ܛ  قائمه المحظورين عام :\n'
for k,v in pairs(list) do
local info = redis:hgetall(Titan..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '~⪼ '..(info.username or '')..' » ❪`' ..v.. '`❫ \n'
else
message = message ..k.. '~⪼ '..(info.username or '')..' l » ❪`' ..v.. '`❫ \n'
end
end 
send_msg(msg.chat_id_,message,msg.id_)
return false
end

--================================{{  Filter Words  }} ===================================

function FilterX(msg)
local var = false
local Text = (msg.text or msg.content_.caption_)
local list = redis:smembers(Titan..':Filter_Word:'..msg.chat_id_)
if #list ~=0 then
for k,word in pairs(list) do
if Text:match('^('..word..')$') or Text:match(word..' . ') or Text:match('.  '..word) then
Del_msg(msg.chat_id_,msg.id_)
print("Word is Del")
var = true
else
var = false
end
end
else
var = false
end 
return var
end


function FilterXList(msg)
local list = redis:smembers(Titan..':Filter_Word:'..msg.chat_id_)
if #list == 0 then return "🛠 ܛ  قائمه الكلمات الممنوعه فارغه" end
filterlist = '🛠 ܛ  قائمه الكلمات الممنوعه :\n'    
for k,v in pairs(list) do
filterlist = filterlist..' '..k..'  -  '..Flter_Markdown(v)..'\n'
end 
return filterlist
end

function AddFilter(msg, word)
if redis:sismember(Titan..':Filter_Word:'..msg.chat_id_,word) then 
return  "📝 ܛ  الكلمه  {"..word.."}  هي بالتأكيد من قائمه المنع✓️" 
else
redis:sadd(Titan..':Filter_Word:'..msg.chat_id_,word) 
return  "📝 ܛ  الكلمه  {"..word.."}  تمت اضافتها الى قائمه المنع ✓️"
end
end

function RemFilter(msg, word)
if redis:sismember(Titan..':Filter_Word:'..msg.chat_id_,word) then 
redis:srem(Titan..':Filter_Word:'..msg.chat_id_,word) 
return  "📝 ܛ  الكلمه  {"..word.."}  تم السماح بها ✓️" 
else
return  "📝 ܛ  الكلمه  {"..word.."}  هي بالتأكيد مسموح بها✓️" 
end
end

------------------------------------------

function CheckFlood(msg)
EnterCmd = true
local NumberFlood = tonumber(redis:get(Titan..':Flood_Spam:'..msg.sender_user_id_..':msgs') or 0)
if NumberFlood > 3 then 
redis:setex(Titan..':Flood_Spam:'..msg.sender_user_id_..':Stoped',10,true)
EnterCmd = false
elseif redis:get(Titan..':Flood_Spam:'..msg.sender_user_id_..':Stoped') then
EnterCmd = false
else
redis:setex(Titan..':Flood_Spam:'..msg.sender_user_id_..':msgs',3,NumberFlood+1)
end
return EnterCmd
end


function buck_up_groups(msg)

json_data = '{"BotID": '..Titan..',"UserBot": "'..Bot_User..'","Groups" : {'
local All_Groups_ID = redis:smembers(Titan..'group:ids')
for key,GroupS in pairs(All_Groups_ID) do
local NameGroup = (redis:get(Titan..'group:name'..GroupS) or '')
NameGroup = NameGroup:gsub('"','')
NameGroup = NameGroup:gsub([[\]],'')
if key == 1 then
json_data =  json_data ..'"'..GroupS..'":{"Title":"'..NameGroup..'"'
else
json_data =  json_data..',"'..GroupS..'":{"Title":"'..NameGroup..'"'
end

local admins = redis:smembers(Titan..'admins:'..GroupS)
if #admins ~= 0 then
json_data =  json_data..',"Admins" : {'
for key,value in pairs(admins) do
local info = redis:hgetall(Titan..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end
end
json_data =  json_data..'}'
end

local creators = redis:smembers(Titan..':MONSHA_BOT:'..GroupS)
if #creators ~= 0 then
json_data =  json_data..',"Creator" : {'
for key,value in pairs(creators) do
local info = redis:hgetall(Titan..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end 
end
json_data =  json_data..'}'
end


local creator = redis:smembers(Titan..':KARA_BOT:'..GroupS)
if #creator ~= 0 then
json_data =  json_data..',"Kara" : {'
for key,value in pairs(creator) do
local info = redis:hgetall(Titan..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end 
end
json_data =  json_data..'}'
end

local owner = redis:smembers(Titan..'owners:'..GroupS)
if #owner ~= 0 then
json_data =  json_data..',"Owner" : {'
for key,value in pairs(owner) do
local info = redis:hgetall(Titan..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end
end
json_data =  json_data..'}'
end

json_data =  json_data.."}"
end

local Save_Data = io.open("./inc/"..Bot_User..".json","w+")
Save_Data:write(json_data..'}}')
Save_Data:close()
sendDocument(msg.chat_id_,msg.id_,"./inc/"..Bot_User..".json","🚸| ملف النسخه الاحتياطيه ...\n🔖| المجموعات » { "..#All_Groups_ID.." }\n📋| للبوت » "..Bot_User.."\n📆| التاريخ » "..os.date("%Y/%m/%d").."\n",dl_cb,nil)
end

function chat_list(msg)
local list = redis:smembers(Titan..'group:ids')
message = '📋 ܛ  قائمه المجموعات :\n\n'
for k,v in pairs(list) do 
local info = redis:get(Titan..'group:name'..v)
if info then 
if utf8.len(info) > 25 then
info = utf8.escape(utf8.gsub(info,0,25))..'...'
end
message = message..k..'ـ '..Flter_Markdown(info).. ' \nــ •⊱ { `' ..v.. '` } ⊰•\n\n'
else 
message = message..k.. 'ـ '..' ☜ •⊱ { `' ..v.. '` } ⊰• \n'
end 
end
all_groups = '📋ܛ قائمه المجموعات :<br><br>'
for k,v in pairs(list) do 
local info = redis:get(Titan..'group:name'..v)
if info then
all_groups = all_groups..' '..k..'- <span style="color: #bd2a2a;">'..info.. '</span> <br> ايدي ☜ (<span style="color:#078883;">' ..v.. '</span>)<br>'
else
all_groups = all_groups..' '..k.. '- '..' ☜ (<span style="color:#078883;">' ..v.. '</span>) <br>'
end 
end

if utf8.len(message) > 4096 then
sendMsg(msg.chat_id_,1,'🚸 ܛ  عذرا لديك الكثير من المجموعات\n👨🏽‍💻 ܛ  سوف ارسل لك ملف فيها قائمه مجموعات المفعله انتظر لحظه ...')
file = io.open("./inc/All_Groups.html", "w")
file:write([[
<html dir="rtl">
<head>
<title>قائمه المجموعات 🗣</title>
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css?family=Harmattan" rel="stylesheet">

</head>
<style> {font-family: 'Harmattan', sans-serif;font-weight: 600;text-shadow: 1px 1px 16px black;}</style>
<body>
<p style="color:#018bb6;font-size: 17px;font-weight: 600;" aligin="center">قائمه المجموعات 🗣</p>
<hr>
]]..all_groups..[[

</body>
</html>
]])
file:close()
return sendDocument(msg.chat_id_,msg.id_,'./inc/All_Groups.html','👨🏽‍✈️ܛ قائمه المجموعات بالكامله ✓ \n🗃ܛ يحتوي ('..#list..') مجموعه \n🖥ܛ افتح الملف في عارض HTML او بالمتصفح',dl_cb,nil)
else 
return sendMsg(msg.chat_id_,1,message) 
end 
end



function rem_data_group(id_group)
redis:del(
Titan..'group:add'..id_group,
Titan..'lock_link'..id_group, 
Titan..'lock_id'..id_group,
Titan..'lock_spam'..id_group, 
Titan..'lock_webpage'..id_group,
Titan..'lock_markdown'..id_group,
Titan..'lock_flood'..id_group,
Titan..'lock_bots'..id_group,
Titan..'mute_forward'..id_group,
Titan..'mute_contact'..id_group,
Titan..'mute_location'..id_group,
Titan..'mute_document'..id_group,
Titan..'mute_keyboard'..id_group,
Titan..'mute_game'..id_group,
Titan..'mute_inline'..id_group,
Titan..'lock_username'..id_group,
Titan..'num_msg_Titan'..id_group,
Titan..'replay'..id_group
)
redis:srem(Titan..'group:ids',id_group)
end



function set_admins(msg) 
GetChannelAdministrators(msg.chat_id_,function(arg,data)
local NumAdmin = 0
for k,v in pairs(data.members_) do
if not data.members_[k].bot_info_ and data.members_[k].status_.ID == "ChatMemberStatusEditor" then
NumAdmin = NumAdmin + 1
GetUserID(v.user_id_,function(arg,data)
redis:hset(Titan..'username:'..data.id_,'username',ResolveUser(data))
redis:sadd(Titan..'admins:'..msg.chat_id_,data.id_)
end,nil)
end
end
if NumAdmin == 0 then 
return sendMsg(msg.chat_id_,msg.id_,"♦️ܛ لا يـوجـد أدمـنـيـه لكي يتـم رفعهم \n")
else
return sendMsg(msg.chat_id_,msg.id_,"♦️ܛ تم رفع  {  "..NumAdmin.."  } مـن آلآدمـنيهہ‌‏ في آلبوت \n✓️")
end
end,100)
end

function modadd(msg)
if redis:get(Titan..'lock_service') then
service = true
Get_Director = 30
else
service = false
Get_Director = 1
end 
if not msg.SudoUser and not service then return '🚸ܛ أنـت لـسـت الـمـطـور ⚙️' end
if msg.is_post_ then return "🚸ܛ عذرا هذا بوت حمايه المجموعات وليس القنوات  " end
if msg.type ~= "channel" then return '🚸ܛ لا يمكنك تفعيل البوت في المجوعات العاديه / البوت يدعم فقط المجموعات الخارقه ⚙️' end
if redis:get(Titan..'group:add'..msg.chat_id_) then  return '🎗 ܛ  المجموعه بالتأكيد ✓️ تم تفعيلها' end

local UserChaneel = redis:get(Titan..":UserNameChaneel")
if UserChaneel and not msg.SudoBase then
local url , res = https.request(ApiToken..'/getchatmember?chat_id='..UserChaneel..'&user_id='..msg.sender_user_id_)
if res == 200 then
print(url) 
local Req = JSON.decode(url)
if Req.ok and Req.result and Req.result.status == "left" or Req.result.status == "kicked" then
return "🚸ܛ آشـترگ بآلقنآ‌‏هہ آولآ ["..UserChaneel.."] \n🔛ܛ ثم آرجع آرسـل تفعيل ."
end
else
return "🚸ܛ آشـترگ بآلقنآ‌‏هہ آولآ ["..UserChaneel.."] \n🔛ܛ ثم آرجع آرسـل تفعيل ."
end
end
 
redis:setex(Titan..":ismember:"..msg.sender_user_id_,1500,true)
GetFullChat(msg.chat_id_,function(arg,data) 
local GroupUsers = tonumber(redis:get(Titan..':addnumberusers') or 0)
local Groupcount = tonumber(data.member_count_)
if GroupUsers  >= Groupcount and not msg.SudoBase then
return sendMsg(msg.chat_id_,msg.id_,'🚸 ܛ  لآ يمـگنني تفعيل آلبوت في آلمـجمـوعهہ‏ يجب آن يگون آگثر مـن  【'..GroupUsers..'】  عضـو 👤')
else 
GetChatMember(msg.chat_id_,our_id,function(arg,data)
if data.status_.ID == "ChatMemberStatusMember" then
return sendMsg(msg.chat_id_,msg.id_,'♦️ ܛ  عذرا البوت ليس ادمن  في المجموعه ♨️\n🔙 ܛ  يرجى ترقيته ادمن لتتمكن من تفعيل البوت ✓️')
else
local lock_service = redis:get(Titan..'lock_service')
if lock_service then 
sendMsg(msg.chat_id_,msg.id_,'📮 ܛ تـم تـفـعـيـل الـمـجـمـوعـه ✓️ \n👨🏽‍🔧ܛ  وتم رفع جمـيع آلآدمـنيهہ‏‏‏ آلگروب بآلبوت \n✓')
else
sendMsg(msg.chat_id_,msg.id_,'📮ܛ تـم تـفـعـيـل آلمـجمـوعهہ‏‏ \n✓️')
end
GetChannelAdministrators(msg.chat_id_,function(arg,data)
for k,v in pairs(data.members_) do
if data.members_[k].status_.ID == "ChatMemberStatusCreator" then
GetUserID(v.user_id_,function(arg,data)
redis:hset(Titan..'username:'..data.id_, 'username', ResolveUser(data))
redis:sadd(Titan..':KARA_BOT:'..msg.chat_id_,data.id_)
end)
elseif lock_service and not data.members_[k].bot_info_ and data.members_[k].status_.ID == "ChatMemberStatusEditor" then
GetUserID(v.user_id_,function(arg,data)
redis:hset(Titan..'username:'..data.id_,'username',ResolveUser(data))
redis:sadd(Titan..'admins:'..msg.chat_id_,data.id_)
end,nil)
end
end 

redis:mset(
Titan..'group:add'..msg.chat_id_,true,
Titan..'lock_link'..msg.chat_id_,true, 
Titan..'lock_id'..msg.chat_id_,true,
Titan..'lock_spam'..msg.chat_id_,true,
Titan..'lock_webpage'..msg.chat_id_,true,
Titan..'lock_markdown'..msg.chat_id_,true,
Titan..'lock_flood'..msg.chat_id_,true,
Titan..'lock_bots'..msg.chat_id_,true,
Titan..'mute_forward'..msg.chat_id_,true,
Titan..'mute_contact'..msg.chat_id_,true,
Titan..'mute_location'..msg.chat_id_,true,
Titan..'mute_document'..msg.chat_id_,true,
Titan..'mute_keyboard'..msg.chat_id_,true,
Titan..'mute_game'..msg.chat_id_,true,
Titan..'mute_inline'..msg.chat_id_,true,
Titan..'lock_username'..msg.chat_id_,true,
Titan..'num_msg_Titan'..msg.chat_id_,5, 
Titan..'replay'..msg.chat_id_,true
)

redis:sadd(Titan..'group:ids',msg.chat_id_) 
redis:sadd(Titan..'mtwr_count'..msg.sender_user_id_,msg.chat_id_)

GroupTitle(msg.chat_id_,function(arg,data)
local NameGroup = data.title_
redis:set(Titan..'group:name'..msg.chat_id_,NameGroup)
local Gp_Link = ExportLink(msg.chat_id_)
if Gp_Link and Gp_Link.result then
Gp_Link = Gp_Link.result
else
Gp_Link = ""
end
redis:set(Titan..'linkGroup'..msg.chat_id_,Gp_Link)
if not we_sudo(msg) then
GetUserID(msg.sender_user_id_,function(arg,datai)
if datai.username_ then 
USERNAME_T = '🎟 ܛ  الـمعرف ❪ @['..datai.username_..'] ❫\n'
else 
USERNAME_T = ''
end
return send_msg(SUDO_ID,'⚜ ܛ  تــــم تــفــعــيــل الـــبـــوت ...\n●ـ▬ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ▬ـ●\n📑ܛ معلومات المجموعه\n'
..'🗯ܛ اسم المجموعه ❪ ['..NameGroup..']('..Gp_Link..') ❫\n'
..'📛ܛ ايدي المجموعه ❪ '..msg.chat_id_..' ❫\n'
..'👥ܛ عدد اعضاء المجموعه ❪  '..Groupcount..'  ❫ \n●ـ▬ـ▬ـ▬ஜ۩۞۩ஜ▬ـ▬ـ▬ـ●\n⚖️ܛ معلومات الشخص الي ضافني \n'
..'👨🏽‍💻 ܛ  الاسـم ❪ ['..FlterName(datai.first_name_..' '..(datai.last_name_ or ""),23)..'](tg://user?id='..msg.sender_user_id_..') ❫\n'
..USERNAME_T..'\n📆ܛ تاريخ التفعيل ❪  '..os.date("%Y/%m/%d")
..'  ❫\n⏱ܛ الساعه ❪  '..os.date("%I:%M%p")..'  ❫')
end,nil)
end
end)
end,Get_Director) 
end
end)
end 
end)
return false
end 

function modrem(msg)
if not msg.SudoUser then return 'ܛ  أنـت لـسـت الـمـطـور'end
if not redis:get(Titan..'group:add'..msg.chat_id_) then return 'ܛ  المجموعه بالتأكيد ✓️ تم تعطيلها' end  
rem_data_group(msg.chat_id_)
return 'ܛ  تـم تـعـطـيـل الـمـجـمـوعـه '
end

function modrem(msg)
if not msg.SudoUser then return 'ܛ  أنـت لـسـت الـمـطـور'end
if not redis:get(Titan..'group:add'..msg.chat_id_) then return 'ܛ  المجموعه بالتأكيد ✓️ تم تعطيلها' end  
rem_data_group(msg.chat_id_)
return 'ܛ  تـم تـعـطـيـل الـمـجـمـوعـه'
end

function action_by_reply(arg,data)  --===  معلومات الرد 
local MsgID = arg.msg.id_
local ChatID = arg.msg.chat_id_
if data.sender_user_id_ then
local cmd = arg.cmd
local UserID = data.sender_user_id_
GetUserID(UserID,function(arg,data)

local Resolv = ResolveUser(data)

if data.username_ then 
USERNAME = '@'..data.username_
else 
USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or ""),20) 
end
USERCAR = utf8.len(USERNAME)


if cmd =="tqeed" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك تقييد البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك تقييد المطور الاساسي\n🛠") 
elseif redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك تقييد المطور\n🛠") 
elseif redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك تقييد المنشئ\n🛠") 
elseif redis:sismember(Titan..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك تقييد المدير\n🛠") 
elseif redis:sismember(Titan..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك تقييد الادمن\n🛠") 
end
GetChatMember(ChatID,UserID,function(arg,data)
if data.status_.ID == "ChatMemberStatusMember" then
Restrict(ChatID,UserID,1)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n🙍🏻‍♂ܛ تم تقييد آلعضـو بنجآح \n✓️',17,USERCAR) 
else
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنني تقييد المشرف\n🛠") 
end
end)
end

if cmd =="fktqeed" then
if UserID == our_id then  
return sendMsg(ChatID,MsgID,"  ܛ  البوت ليس مقييد  \n📛") 
end
Restrict(ChatID,UserID,2)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم فگ تقييد آلعضـو بنجآح \n✓️',17,USERCAR) 
end

if cmd == "setmnsha" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكنني رفع نفسي \n📛") 
elseif data.type_.ID  == "UserTypeBot" then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكن رفع بوت في البوت \n📛") 
elseif data.type_.ID == "chatTypeChannel" then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكن رفع قناة في البوت \n📛") 
end
if redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد منشىء  \n✓️',17,USERCAR) 
end
redis:hset(Titan..'username:'..UserID,'username',Resolv)
redis:sadd(Titan..':MONSHA_BOT:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ تمت ترقيته ليصبح منشىء في البوت \n✓️',17,USERCAR) 
end

if cmd == "remmnsha" then
if not redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد ليس منشىء \n✓️',17,USERCAR) 
end
redis:srem(Titan..':MONSHA_BOT:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم تنزيله من المنشىء \n✓️',17,USERCAR) 
end

if cmd == "setkara" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكنني رفع نفسي \n📛") 
elseif data.type_.ID  == "UserTypeBot" then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكن رفع بوت في البوت \n📛") 
elseif data.type_.ID == "chatTypeChannel" then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكن رفع قناة في البوت \n📛") 
end
if redis:sismember(Titan..':KARA_BOT:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد منشىء اساسي \n✓️',17,USERCAR) 
end
redis:hset(Titan..'username:'..UserID,'username',Resolv)
redis:sadd(Titan..':KARA_BOT:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ تمت ترقيته ليصبح منشىء اساسي في البوت \n✓️',17,USERCAR) 
end

if cmd == "remkara" then
if not redis:sismember(Titan..':KARA_BOT:'..ChatID,UserID) then
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد ليس منشىء اساسي\n✓️',17,USERCAR) 
end
redis:srem(Titan..':KARA_BOT:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم تنزيله من المنشىء الاساسي\n✓️',17,USERCAR) 
end

if cmd == "setwhitelist" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكنني رفع نفسي \n📛") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكن رفع بوت في البوت \n📛") 
elseif data.type_.ID == "ChatTypeChannel" then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكن رفع قناة في البوت \n📛") 
end
if redis:sismember(Titan..'whitelist:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد عضو مميز \n✓️',17,USERCAR) 
end
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:sadd(Titan..'whitelist:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ تمت ترقيته ليصبح عضو مميز \n✓️',17,USERCAR) 
end

if cmd == "remwhitelist" then
if not redis:sismember(Titan..'whitelist:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد ليس عضو مميز \n✓️',17,USERCAR) 
end
redis:srem(Titan..'whitelist:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ تمت تنزيله من عضو مميز \n✓️',17,USERCAR) 
end

if cmd == "setowner" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكنني رفع نفسي \n📛") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكن رفع بوت في البوت \n📛") 
end
if redis:sismember(Titan..'owners:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد مدير \n✓️',17,USERCAR) 
end
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:sadd(Titan..'owners:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ تمت ترقيته ليصبح مدير \n✓️',17,USERCAR) 
end

if cmd == "promote" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكنني رفع نفسي \n📛") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكن رفع بوت في البوت \n📛") 
end
if redis:sismember(Titan..'admins:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد ادمن \n✓️',17,USERCAR) 
end
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:sadd(Titan..'admins:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ تمت ترقيته ليصبح ادمن \n✓️',17,USERCAR) 
end

if cmd == "remowner" then
if not redis:sismember(Titan..'owners:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد ليس مدير \n✓️',17,USERCAR) 
end
redis:srem(Titan..'owners:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم تنزيله من المدير  \n✓️',17,USERCAR) 
end

if cmd == "demote" then
if not redis:sismember(Titan..'admins:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد ليس ادمن \n✓️',17,USERCAR) 
end
redis:srem(Titan..'admins:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم تنزيله من الادمنيه \n✓️',17,USERCAR) 
end

if cmd == "iduser" then
return SendMention(ChatID,UserID,MsgID,"🧟‍♂ܛ آضـغط على آلآيدي ليتم آلنسـخ\n\n "..USERNAME.." ~⪼ { "..UserID.." }",37,USERCAR)
end
if cmd == "whois" then
local namei = data.first_name_..' '..(data.last_name_ or "")
if data.username_ then useri = '@'..data.username_ else useri = " لا يوجد " end
return SendMention(ChatID,UserID,MsgID,'🤵🏼ܛ الاسم » '..namei..'\n'
..' ▾╮ الايدي ⊱ {'..UserID..'} \n'
..'▾╮ المستخدم ⊱ '..useri..'\n'
..'▾╮ الرتبه ⊱ '..Getrtba(UserID,ChatID)..'\n'
..'🕵🏻️‍♀️ܛ  نوع الكشف » بالرد\n➖',13,utf8.len(namei))
end

if cmd == "active" then
local maseegs = redis:get(Titan..'msgs:'..UserID..':'..ChatID) or 1
local namei = FlterName(data.first_name_..' '..(data.last_name_ or ""))
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..namei..' \n📮ܛ رسائلك » ❪ '..maseegs..' ❫ رسالةة\n🔖ܛ التفاعل »  ❪ '..Get_Ttl(maseegs)..' ❫\n🙇🏽',12,utf8.len(namei)) 
end

if cmd == "ban" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك حظر البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك حظر المطور الاساسي\n🛠") 
elseif redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك حظر المطور\n🛠") 
elseif redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك حظر المنشئ\n🛠") 
elseif redis:sismember(Titan..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك حظر المدير\n🛠") 
elseif redis:sismember(Titan..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك حظر الادمن\n🛠") 
end
kick_user(UserID,ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(ChatID,MsgID,'♦️ ܛ  لا يمكنني حظر العضو .\n🎟 ܛ  لانه مشرف في المجموعه \n ❕')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(ChatID,MsgID,'♦️ ܛ  لا يمكنني حظر العضو .\n🎟 ܛ  ليس لدي صلاحيه الحظر او لست مشرف\n ❕')    
else
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:sadd(Titan..'banned:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم حظره  \n✓️',17,USERCAR) 
end
end)

end

if cmd == "unban" then
if not redis:sismember(Titan..'banned:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم بالتأكيد الغاء حظره  \n✓️',17,USERCAR) 
else
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم الغاء حظره \n✓️',17,USERCAR) 
end
redis:srem(Titan..'banned:'..ChatID,UserID)
StatusLeft(ChatID,UserID)
end

if cmd == "silent" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك كتم البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك كتم المطور الاساسي\n🛠") 
elseif redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك كتم المطور\n🛠") 
elseif redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك كتم المنشئ\n🛠") 
elseif redis:sismember(Titan..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك كتم المدير\n🛠") 
elseif redis:sismember(Titan..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك كتم الادمن\n🛠") 
end
if redis:sismember(Titan..'is_silent_users:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم بالتأكيد كتمه  \n✓️',17,USERCAR) 
end
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:sadd(Titan..'is_silent_users:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم كتمه \n✓️',17,USERCAR) 
end

if cmd == "unsilent" then
if not redis:sismember(Titan..'is_silent_users:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم بالتاكيد الغاء كتمه  \n✓️',17,USERCAR) 
end
redis:srem(Titan..'is_silent_users:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم الغاء كتمه  \n✓️',17,USERCAR) 
end

if cmd == "banall" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك حظر البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"?? ܛ  لا يمكنك حظر المطور الاساسي\n🛠")
elseif redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك حظر المطور\n🛠") 
end
if GeneralBanned(UserID) then return sendMsg(ChatID,MsgID,'👤 ܛ  العضو » '..USERNAME..'\n🎟 ܛ  الايدي » ❪ `'..UserID..'` ❫\n💯 ܛ  تم بالتأكيد حظره عام \n✓️') end
redis:hset(Titan..'username:'..UserID, 'username',Resolv)
redis:sadd(Titan..'gban_users',UserID)
kick_user(UserID, ChatID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم حظره عام \n✓️',17,USERCAR) 
end

if cmd == "unbanall" then
if not GeneralBanned(UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم بالتأكيد الغاء حظره العام \n✓️',17,USERCAR) 
end
redis:srem(Titan..'gban_users',UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم الغاء حظره العام \n✓️',17,USERCAR) 
end

if cmd == "kick" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك طرد البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك طرد المطور الاساسي\n🛠") 
elseif redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك طرد المطور\n🛠") 
elseif redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك طرد المنشئ\n🛠") 
elseif redis:sismember(Titan..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك طرد المدير\n🛠") 
elseif redis:sismember(Titan..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك طرد الادمن\n🛠") 
end
kick_user(UserID, ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(ChatID,MsgID,'♦️ ܛ  لا يمكنني حظر العضو .\n🎟 ܛ  لانه مشرف في المجموعه \n ❕')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(ChatID,MsgID,'♦️ ܛ  لا يمكنني حظر العضو .\n🎟 ܛ  ليس لدي صلاحيه الحظر او لست مشرف\n ❕')    
end
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:sadd(Titan..'banned:'..ChatID,UserID)
StatusLeft(ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم طرد العضو \n✓️',17,USERCAR) 
end)

end

if cmd == "rtba" then
GetChatMember(ChatID,UserID,function(arg,data)
if data.status_ and data.status_.ID == "ChatMemberStatusEditor" then
SudoGroups = 'مشرف '
elseif data.status_ and data.status_.ID == "ChatMemberStatusCreator" then 
SudoGroups = "منشئ اساسي ."
else
SudoGroups = "عضو .!"
end
if UserID == our_id then 
Getrtb = 'ادمن' 
elseif  UserID == SUDO_ID then
Getrtb = 'مطور اساسي ' 
elseif redis:sismember(Titan..':SUDO_BOT:',UserID) then
Getrtb = 'مطور ' 
elseif redis:sismember(Titan..':KARA_BOT:'..ChatID,UserID) then
Getrtb = 'منشئ اساسي' 
elseif redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then
Getrtb = 'منشئ' 
elseif redis:sismember(Titan..'owners:'..ChatID,UserID) then
Getrtb = 'المدير ' 
elseif redis:sismember(Titan..'admins:'..ChatID,UserID) then
Getrtb = 'ادمن' 
elseif redis:sismember(Titan..'whitelist:'..ChatID,UserID) then
Getrtb = 'مميز' 
else
Getrtb = 'عضو' 
end
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n\nـ⠀❪ رتـبـه الشخص ❫\n\n🤖ܛ في البوت » ❪ '..Getrtb..' ❫\n💬ܛ في المجموعه » ❪ '..SudoGroups..' ❫\n✓',12,USERCAR) 
end)
end

if cmd == "up_sudo" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكنني رفع نفسي \n📛") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكن رفع بوت في البوت \n📛") 
end
if redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد مطور \n✓️',17,USERCAR) 
end
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:sadd(Titan..':SUDO_BOT:',UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم ترقيته ليصبح مطور \n✓️',17,USERCAR) 
end

if cmd == "dn_sudo" then
if not redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد ليس مطور \n✓️',17,USERCAR) 
end
redis:srem(Titan..':SUDO_BOT:',UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم تنزيله من المطورين \n✓️',17,USERCAR) 
end  -- End Cmd 
end,nil)
else
return sendMsg(ChatID,MsgID,"♦️ ܛ  عذرا هذا العضو ليس موجود ضمن المجموعات \n❕")
end 
end


function action_by_username(arg,data)
local cmd = arg.cmd 

local ChatID = arg.msg.chat_id_
local MsgID = arg.msg.id_
if data.id_ then
local UserID = data.id_
local UserName = '@'..arg.msg.text:match('@[%a%d_]+'):gsub('@',''):gsub('_',[[\_]])
print(UserName)
if cmd =="tqeed" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك تقييد البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك تقييد المطور الاساسي\n🛠") 
elseif redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك تقييد المطور\n🛠") 
elseif redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك تقييد المنشئ\n🛠") 
elseif redis:sismember(Titan..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك تقييد المدير\n🛠") 
elseif redis:sismember(Titan..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك تقييد الادمن\n🛠") 
end
GetChatMember(ChatID,our_id,function(arg,data)
if data.status_.ID == "ChatMemberStatusEditor" then 
GetChatMember(ChatID,UserID,function(arg,data)
if data.status_.ID == "ChatMemberStatusMember" then 
Restrict(ChatID,UserID,1)  
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n🎟 ܛ  الايدي » ❪ `'..UserID..'` ❫\n💯 ܛ  تم تقييد آلعضـو بنجآح \n✓️') 
else
return sendMsg(ChatID,MsgID,'♦️ ܛ  لا يمكنني تقييد العضو .\n🎟 ܛ  لانه مشرف في المجموعه \n ❕')    
end
end)
else
return sendMsg(ChatID,MsgID,'♦️ ܛ  لا يمكنني تقييد العضو .\n🎟 ܛ  لانني لست مشرف في المجموعه \n ❕')    
end
end)

end

if cmd =="fktqeed" then
if UserID == our_id then  
return sendMsg(ChatID,MsgID,"♦️ ܛ  البوت ليس مقييد \n❗️ ") 
end
GetUserID(UserID,function(arg,data)
GetChatMember(ChatID,our_id,function(arg,data)
if data.status_.ID == "ChatMemberStatusEditor" then 
Restrict(ChatID,UserID,2)
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n🎟 ܛ  الايدي » ❪ `'..UserID..'` ❫\n💯 ܛ  تم فك تقييد آلعضـو بنجآح \n✓️') 
else
return sendMsg(ChatID,MsgID,'♦️ ܛ  لا يمكنني قك تقييد العضو .\n🎟 ܛ  لانني لست مشرف في المجموعه \n ❕')    
end
end)
end,nil)
end

if cmd == "setmnsha" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكنني رفع نفسي \n📛") 
elseif data.type_.ID == "UserTypeBot" then
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكن رفع بوت في البوت \n📛") 
elseif data.type_.ID == "ChatTypeChannel" then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكن رفع قناة في البوت \n📛") 
end
if redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n🎟 ܛ  الايدي » ❪ `'..UserID..'` ❫\n▾╮ انه بالتأكيد منشىء في البوت \n✓️') 
end
redis:hset(Titan..'username:'..UserID, 'username', UserName)
redis:sadd(Titan..':MONSHA_BOT:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n🎟 ܛ  الايدي » ❪ `'..UserID..'` ❫\n💯 ܛ  تمت ترقيته ليصبح منشىء في البوت \n✓️')
end

if cmd == "remmnsha" then
if not redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n🎟 ܛ  الايدي » ❪ `'..UserID..'` ❫\n▾╮ انه بالتأكيد ليس منشىء \n✓️') 
end
redis:srem(Titan..':MONSHA_BOT:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n🎟 ܛ  الايدي » ❪ `'..UserID..'` ❫\n💯 ܛ  تمت تنزيله من المنشىء \n✓️') 
end

if cmd == "setwhitelist" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكنني رفع نفسي \n📛") 
elseif data.type_.ID == "ChannelChatInfo" then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكن رفع قناة في البوت \n📛") 
end
if redis:sismember(Titan..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n🎟 ܛ  الايدي » ❪ `'..UserID..'` ❫\n▾╮ انه بالتأكيد من عضو مميز \n✓️') 
end
redis:hset(Titan..'username:'..UserID, 'username', UserName)
redis:sadd(Titan..'whitelist:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n🎟 ܛ  الايدي » ❪ `'..UserID..'` ❫\n💯 ܛ  تمت ترقيته ليصبح ضمن عضو مميز \n✓️')
end

if cmd == "remwhitelist" then
if not redis:sismember(Titan..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n🎟 ܛ  الايدي » ❪ `'..UserID..'` ❫\n▾╮ انه بالتأكيد ليس من عضو مميز \n✓️') 
end
redis:srem(Titan..'whitelist:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n🎟 ܛ  الايدي » ❪ `'..UserID..'` ❫\n💯 ܛ  تمت تنزيله من عضو مميز \n✓️')
end

if cmd == "setowner" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكنني رفع نفسي \n📛") 
elseif data.type_.ID == "ChannelChatInfo" then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكن رفع قناة في البوت \n📛") 
end
if redis:sismember(Titan..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n🎟 ܛ  الايدي » ❪ `'..UserID..'` ❫\n▾╮ انه بالتأكيد مدير \n✓️') 
end
redis:hset(Titan..'username:'..UserID, 'username', UserName)
redis:sadd(Titan..'owners:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n🎟 ܛ  الايدي » ❪ `'..UserID..'` ❫\n💯 ܛ  تمت ترقيته ليصبح مدير \n✓️')
end

if cmd == "promote" then
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكنني رفع نفسي \n📛") 
elseif data.type_.ID == "ChannelChatInfo" then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكن رفع قناة في البوت \n📛") 
end
if redis:sismember(Titan..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'  ܛ  العضو » '..USERNAME..'\n🎟 ܛ  الايدي » ❪ `'..UserID..'` ❫\n▾╮ انه بالتأكيد ادمن \n✓️') 
end
redis:hset(Titan..'username:'..UserID, 'username', UserName)
redis:sadd(Titan..'admins:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n🎟 ܛ  الايدي » ❪ `'..UserID..'` ❫\n💯 ܛ  تمت ترقيته ليصبح ادمن \n✓️')
end

if cmd == "remowner" then
if not redis:sismember(Titan..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n🎟 ܛ  الايدي » ❪ `'..UserID..'` ❫\n▾╮ انه بالتأكيد ليس مدير \n✓️') 
end
redis:srem(Titan..'owners:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n🎟 ܛ  الايدي » ❪ `'..UserID..'` ❫\n💯 ܛ  تم تنزيله من الاداره \n✓️')
end

if cmd == "demote" then
if not redis:sismember(Titan..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n🎟 ܛ  الايدي » ❪ `'..UserID..'` ❫\n▾╮ انه بالتأكيد ليس ادمن \n✓️') 
end
redis:srem(Titan..'admins:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n🎟 ܛ  الايدي » ❪ `'..UserID..'` ❫\n💯 ܛ  تم تنزيله من الادمنيه \n✓️')
end

if cmd == "iduser" then
return sendMsg(ChatID,MsgID,"🧟‍♂ ܛ  آضـغط على آلآيدي ليتم آلنسـخ\n\n "..UserName.." ~⪼ ( `"..UserID.."` )")
end

if cmd == "whois" then
return sendMsg(ChatID,MsgID,
  'ـ🤵🏼 ܛ  الاسم » '..FlterName(data.title_,30)..'\n'
..' ▾╮ الايدي ⊱ {`'..UserID..'`} \n'
..'🎟 ܛ  المعرف » '..UserName..'\n'
..'🕵🏻️‍♀️ ܛ  نوع الكشف » بالمعرف\n'
..'➖')
end

if cmd == "active" then
local maseegs = redis:get(Titan..'msgs:'..UserID..':'..ChatID) or 1
local namei = FlterName(data.title_)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ ❪ '..namei..' ❫\n📮ܛ رسائلك » ❪ '..maseegs..' ❫ رسالةة\n🔖ܛ التفاعل »  ❪ '..Get_Ttl(maseegs)..' ❫\n🙇🏽',12,utf8.len(namei)) 
end 

if cmd == "ban" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك حظر البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك حظر المطور الاساسي\n🛠") 
elseif redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك حظر المطور\n🛠") 
elseif redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك حظر المنشئ\n🛠") 
elseif redis:sismember(Titan..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك حظر المدير\n🛠") 
elseif redis:sismember(Titan..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك حظر الادمن\n🛠") 
end
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكنني حظر نفسي \n📛") 
elseif data.type_.ID == "ChannelChatInfo" then 
return sendMsg(ChatID,MsgID,"  ܛ  عذرا لا يمكن حظر قناة \n📛") 
end
if redis:sismember(Titan..'banned:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ ❪ `'..UserID..'` ❫\n💯 ܛ  تم بالتأكيد حظره \n✓️') 
end
kick_user(UserID, ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(ChatID,MsgID,'♦️ ܛ  لا يمكنني حظر العضو .\n🎟 ܛ  لانه مشرف في المجموعه \n ❕')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(ChatID,MsgID,'♦️ ܛ  لا يمكنني حظر العضو .\n🎟 ܛ  ليس لدي صلاحيه الحظر او لست مشرف\n ❕')    
end
redis:hset(Titan..'username:'..UserID, 'username', UserName)
redis:sadd(Titan..'banned:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ ❪ `'..UserID..'` ❫\n💯 ܛ  تم حظره \n✓️')
end)
end  

if cmd == "unban" then
if not redis:sismember(Titan..'banned:'..ChatID,UserID) then 
sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ ❪ `'..UserID..'` ❫\n💯 ܛ  تم بالتأكيد الغاء حظره \n✓️') 
else
sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ ❪ `'..UserID..'` ❫\n💯 ܛ  تم الغاء حظره \n✓️')
end
redis:srem(Titan..'banned:'..ChatID,UserID)
StatusLeft(ChatID, UserID)
end

if cmd == "silent" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك كتم البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك كتم المطور الاساسي\n🛠") 
elseif redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك كتم المطور\n🛠") 
elseif redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك كتم المنشئ\n🛠") 
elseif redis:sismember(Titan..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك كتم المدير\n🛠") 
elseif redis:sismember(Titan..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك كتم الادمن\n🛠") 
end
if redis:sismember(Titan..'is_silent_users:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ ❪`'..UserID..'` ❫\n💯 ܛ  تم بالتأكيد كتمه \n✓️') 
end
redis:hset(Titan..'username:'..UserID, 'username', UserName)
redis:sadd(Titan..'is_silent_users:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ ❪ `'..UserID..'` ❫\n💯 ܛ  تم كتمه \n✓️')
end

if cmd == "unsilent" then
if not redis:sismember(Titan..'is_silent_users:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ ❪ `'..UserID..'` ❫\n💯 ܛ  م بالتأكيد الغاء كتمه \n✓️') 
end
redis:srem(Titan..'is_silent_users:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ ❪ `'..UserID..'` ❫\n💯 ܛ  تم الغاء كتمه \n✓️')
end

if cmd == "banall" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك حظر البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك حظر المطور الاساسي\n🛠")
elseif redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك حظر المطور\n🛠") 
end
if GeneralBanned(UserID) then 
return sendMsg(ChatID,MsgID,'  ܛ  العضو » '..USERNAME..'\n ▾╮ الايدي ⊱ ❪ `'..UserID..'` ❫\n💯 ܛ  تم بالتأكيد حظره عام \n✓️') 
end
redis:hset(Titan..'username:'..UserID, 'username', UserName)
redis:sadd(Titan..'gban_users',UserID)
kick_user(UserID, ChatID)
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ ❪ `'..UserID..'` ❫\n💯 ܛ  تم حظره عام \n✓️')
end

if cmd == "unbanall" then
if not GeneralBanned(UserID) then 
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ ❪ `'..UserID..'` ❫\n💯 ܛ  م بالتأكيد الغاء حظره العام \n✓️') 
end
redis:srem(Titan..'gban_users',UserID)
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ ❪ `'..UserID..'` ❫\n💯 ܛ  تم الغاء حظره العام \n✓️')
end

if cmd == "kick" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك طرد البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك طرد المطور الاساسي\n🛠") 
elseif redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك طرد المطور\n🛠") 
elseif redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك طرد المنشئ\n🛠") 
elseif redis:sismember(Titan..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك طرد المدير\n🛠") 
elseif redis:sismember(Titan..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك طرد الادمن\n🛠") 
end
kick_user(UserID,ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(ChatID,MsgID,'♦️ ܛ  لا يمكنني طرد العضو .\n🎟 ܛ  لانه مشرف في المجموعه \n ❕')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(ChatID,MsgID,'♦️ ܛ  لا يمكنني طرد العضو .\n🎟 ܛ  ليس لدي صلاحيه الحظر او لست مشرف\n ❕')    
end
redis:hset(Titan..'username:'..UserID, 'username', UserName)
redis:sadd(Titan..'banned:'..ChatID,UserID)
StatusLeft(ChatID,UserID)
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ ❪ `'..UserID..'` ❫\n💯 ܛ  تم طرد العضو \n✓️')
end)
 
end

if cmd == "up_sudo" then
if redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ ❪ `'..UserID..'` ❫\n▾╮ انه بالتأكيد مطور \n✓') 
end
redis:hset(Titan..'username:'..UserID, 'username', UserName)
redis:sadd(Titan..':SUDO_BOT:',UserID)
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ ❪ `'..UserID..'` ❫\n💯 ܛ  تم ترقيته ليصبح مطور \n✓')
end

if cmd == "dn_sudo" then
if not redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ ❪ `'..UserID..'` ❫\n💯 ܛ  نه بالتأكيد ليس مطور \n✓')
end
redis:srem(Titan..':SUDO_BOT:',UserID)
return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ ❪ `'..UserID..'` ❫\n💯 ܛ  تم تنزيله من المطورين \n✓') 
end

else
return sendMsg(ChatID,MsgID,"♦️ ܛ  لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕")
end 

end

function action_by_id(arg, data)

local cmd = arg.cmd
local ChatID = arg.msg.chat_id_
local MsgID = arg.msg.id_
if not data.id_ then 
sendMsg(ChatID,MsgID,"♦️ ܛ  العضو لا يوجد\n❕") 
return false
end
local UserID = data.id_
local Resolv = ResolveUser(data)

if data.username_ then 
USERNAME = '@'..data.username_
else 
USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or ""),20) 
end
USERCAR = utf8.len(USERNAME)


if cmd == "tqeed" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك تقييد البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك طرد المطور الاساسي\n🛠") 
elseif redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك طرد المطور\n🛠") 
elseif redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك طرد المنشئ\n🛠") 
elseif redis:sismember(Titan..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك طرد المدير\n🛠") 
elseif redis:sismember(Titan..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"  ܛ  لا يمكنك طرد الادمن\n🛠") 
end
Restrict(ChatID,UserID,1)
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:sadd(Titan..':tqeed:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم تقييد آلعضـو بنجآح \n✓️',17,USERCAR) 
end 
if cmd =="fktqeed" then
Restrict(ChatID,UserID,2)
redis:srem(Titan..':tqeed:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم فگ تقييد آلعضـو بنجآح \n✓️',17,USERCAR) 
end
if cmd == "setwhitelist" then
if redis:sismember(Titan..'whitelist:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد من عضو مميز \n✓️',17,USERCAR) 
end
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:sadd(Titan..'whitelist:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ تمت ترقيته ليصبح ضمن عضو مميز \n✓️',17,USERCAR) 
end
if cmd == "setmnsha" then
if redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد منشىء \n✓️',17,USERCAR) 
end
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:sadd(Titan..':MONSHA_BOT:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ تمت ترقيته ليصبح منشىء في البوت \n✓️',17,USERCAR) 
end
if cmd == "remmnsha" then
if not redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد ليس منشىء \n✓️',17,USERCAR) 
end
redis:srem(Titan..':MONSHA_BOT:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم تنزيله من المنشىء \n✓️',17,USERCAR) 
end
if cmd == "remwhitelist" then
if not redis:sismember(Titan..'whitelist:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد ليس من عضو مميز \n✓️',17,USERCAR) 
end
redis:srem(Titan..'whitelist:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ تمت تنزيله من عضو مميز \n✓️',17,USERCAR) 
end
if cmd == "setowner" then
if redis:sismember(Titan..'owners:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد مدير \n✓️',17,USERCAR) 
end
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:sadd(Titan..'owners:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ تمت ترقيته ليصبح مدير \n✓️',17,USERCAR) 
end
if cmd == "promote" then
if redis:sismember(Titan..'admins:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد ادمن \n✓️',17,USERCAR) 
end
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:sadd(Titan..'admins:'..ChatID,UserID) 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ تمت ترقيته ليصبح ادمن \n✓️',17,USERCAR) 
end
if cmd == "remowner" then
if not redis:sismember(Titan..'owners:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد ليس مدير \n✓️',17,USERCAR) 
end
redis:srem(Titan..'owners:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم تنزيله من الاداره \n✓️',17,USERCAR) 
end
if cmd == "demote" then
if not redis:sismember(Titan..'admins:'..ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n💯ܛ انه بالتأكيد ليس ادمن \n✓️',17,USERCAR) 
end
redis:srem(Titan..'admins:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم تنزيله من الادمنيه \n✓️',17,USERCAR) 
end
if cmd == "whois" then
GetChatMember(ChatID,UserID,function(arg,data1)
local namei = data1.first_name_..' '..(data1.last_name_ or "")
if data1.username_ then useri = '@'..data1.username_ else useri = " لا يوجد " end
return SendMention(ChatID,UserID,MsgID,'🤵🏼ܛ الاسم » '..namei..'\n'
..' ▾╮ الايدي ⊱ {'..UserID..'} \n'
..'▾╮ المستخدم ⊱ '..useri..'\n'
..'▾╮ الرتبه ⊱ '..Getrtba(UserID,ChatID)..'\n'
..'🕵🏻️‍♀️ܛ  نوع الكشف » بالايدي\n➖',13,utf8.len(namei))
end)
end

if cmd == "up_sudo" then
if redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\nܛ نه بالتأكيد مطور \n✓️',17,USERCAR) 
end
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:sadd(Titan..':SUDO_BOT:',UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم ترقيته ليصبح مطور \n✓️',17,USERCAR) 
end

if cmd == "dn_sudo" then
if not redis:sismember(Titan..':SUDO_BOT:',UserID) then return sendMsg(ChatID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..' \n ▾╮ الايدي ⊱ (`'..UserID..'`)\n▾╮ انه بالتأكيد ليس مطور \n✓') end
redis:srem(Titan..':SUDO_BOT:',UserID) 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم تنزيله من المطورين \n✓️',17,USERCAR) 
end

if cmd == "ban" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك حظر البوت") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك حظر المطور الاساسي") 
elseif redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك حظر المطور") 
elseif redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك حظر المنشئ") 
elseif redis:sismember(Titan..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك حظر المدير") 
elseif redis:sismember(Titan..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك حظر الادمن") 
end
if Check_Banned(ChatID,UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم بالتأكيد حظره \n✓️',17,USERCAR) 
end
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:sadd(Titan..'banned:'..ChatID,UserID)
kick_user(UserID, ChatID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم حظره  \n✓️',17,USERCAR) 
end

if cmd == "kick" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك طرد البوت") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك طرد المطور الاساسي") 
elseif redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك طرد المطور") 
elseif redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك طرد المنشئ") 
elseif redis:sismember(Titan..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك طرد المدير") 
elseif redis:sismember(Titan..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك طرد الادمن") 
end
kick_user(UserID, ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(ChatID,MsgID,'ܛ  لا يمكنني طرد العضو .\nܛ  لانه مشرف في المجموعه')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(ChatID,MsgID,'ܛ  لا يمكنني طرد العضو .\nܛ  ليس لدي صلاحيه الحظر او لست مشرف')    
end
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:sadd(Titan..'banned:'..ChatID,UserID)
StatusLeft(ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم طرد العضو \n✓️',17,USERCAR) 
end)
end

if cmd == "uban" then
if not Check_Banned(ChatID,UserID) then 
 SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم بالتأكيد الغاء حظره \n✓️',17,USERCAR) 
else
 SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم الغاء حظره \n✓️',17,USERCAR) 
end
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:srem(Titan..'banned:'..ChatID,UserID)
StatusLeft(ChatID,UserID)
return false
end

if cmd == "ktm" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك كتم البوت") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك كتم المطور الاساسي") 
elseif redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك كتم المطور") 
elseif redis:sismember(Titan..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك كتم المنشئ") 
elseif redis:sismember(Titan..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك كتم المدير") 
elseif redis:sismember(Titan..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك كتم الادمن") 
end
if redis:sismember(Titan..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك كتم المدراء او الادمنيه") 
end
if MuteUser(ChatID, UserID) then
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم بالتأكيد كتمه \n✓️',17,USERCAR) 
end
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:sadd(Titan..'is_silent_users:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم كتمه  \n✓️',17,USERCAR) 
end

if cmd == "unktm" then
if not MuteUser(ChatID, UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم بالتأكيد الغاء كتمه \n✓️',17,USERCAR) 
end
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:srem(Titan..'is_silent_users:'..ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم الغاء كتمه \n✓️',17,USERCAR) 
end

if cmd == "bandall" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك حظر البوت") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك حظر المطور الاساسي")
elseif redis:sismember(Titan..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"ܛ  لا يمكنك حظر المطور") 
end
if GeneralBanned(UserID) then 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم بالتأكيد حظره عام \n✓️',17,USERCAR) 
end
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:sadd(Titan..'gban_users',UserID)
kick_user(UserID,ChatID) 
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم حظره عام \n✓️',17,USERCAR) 
end

if cmd == "unbandall" then
if not GeneralBanned(UserID) then
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم بالتأكيد الغاء حظره العام \n✓️',17,USERCAR) 
end
redis:hset(Titan..'username:'..UserID, 'username', Resolv)
redis:srem(Titan..'gban_users',UserID)
StatusLeft(ChatID,UserID)
return SendMention(ChatID,UserID,MsgID,'▾╮ المستخدم ⊱ '..USERNAME..'\n ▾╮ الايدي ⊱ '..UserID..'\n▾╮ تم الغاء حظره العام \n✓️',17,USERCAR) 
end

end

function settingsall(msg)
if redis:get(Titan..'welcome:get'..msg.chat_id_) then welcomex = "❪ مفعل ❫" else welcomex = "❪ معطل ❫" end
if redis:get(Titan..'lock_id'..msg.chat_id_) then lock_idx = "❪ مفعل ❫" else lock_idx = "❪ معطل ❫" end
if redis:get(Titan..'replay'..msg.chat_id_)  then replayx  = "❪ مفعل ❫" else replayx  = "❪ معطل ❫" end
if redis:get(Titan..'lock_woring'..msg.chat_id_) then lock_woringx = "❪ مفعل ❫" else lock_woringx  = "❪ معطل ❫" end
list_settings = " ` اعدادات المجموعه :` \n"
.."\nܛ التعديل «» "..(redis:get(Titan..'lock_edit'..msg.chat_id_) or 'false')
.."\nܛ الروابط «» "..(redis:get(Titan..'lock_link'..msg.chat_id_) or 'false')
.."\nܛ التاك «» "..(redis:get(Titan..'lock_tag'..msg.chat_id_) or 'false')
.."\nܛ المعرفات «» "..(redis:get(Titan..'lock_username'..msg.chat_id_) or 'false')
.."\nܛ التكرار «» "..(redis:get(Titan..'lock_flood'..msg.chat_id_) or 'false')
.."\nܛ الكلايش «» "..(redis:get(Titan..'lock_spam'..msg.chat_id_) or 'false')
.."\nܛ الويب «» "..(redis:get(Titan..'lock_webpage'..msg.chat_id_) or 'false')
.."\nܛ الماركدوان «» "..(redis:get(Titan..'lock_markdown'..msg.chat_id_) or 'false')
.."\nܛ بالطرد البوتات «» "..(redis:get(Titan..'lock_bots_by_kick'..msg.chat_id_) or 'false')
.."\nܛ البوتات «» "..(redis:get(Titan..'lock_bots'..msg.chat_id_) or 'false')
.."\nܛ عدد التكرار «» "..(redis:get(Titan..'num_msg_Titan'..msg.chat_id_) or 'false')
.."\n\nـــــــــــــــــــــــــــــــــــــــــــــــــــــــــ\nܛ `اعدادات الوسائط :`\n"
.."\n ܛ  المتحركه «» "..(redis:get(Titan..'mute_gif'..msg.chat_id_) or 'false')
.."\nܛ الدردشه «» "..(redis:get(Titan..'mute_text'..msg.chat_id_) or 'false')
.."\nܛ الانلاين «» "..(redis:get(Titan..'mute_inline'..msg.chat_id_) or 'false')
.."\nܛ الالعاب «» "..(redis:get(Titan..'mute_game'..msg.chat_id_) or 'false')
.."\nܛ الصور «» "..(redis:get(Titan..'mute_photo'..msg.chat_id_) or 'false')
.."\nܛ الفيديو «» "..(redis:get(Titan..'mute_video'..msg.chat_id_) or 'false')
.."\nܛ البصمات «» "..(redis:get(Titan..'mute_audio'..msg.chat_id_) or 'false')
.."\nܛ الصوت «» "..(redis:get(Titan..'mute_voice'..msg.chat_id_) or 'false')
.."\nܛ الملصقات «» "..(redis:get(Titan..'mute_sticker'..msg.chat_id_) or 'false')
.."\nܛ الجهات «» "..(redis:get(Titan..'mute_contact'..msg.chat_id_) or 'false')
.."\nܛ التوجيه «» "..(redis:get(Titan..'mute_forward'..msg.chat_id_) or 'false')
.."\nܛ الموقع «» "..(redis:get(Titan..'mute_location'..msg.chat_id_) or 'false')
.."\nܛ الملفات «» "..(redis:get(Titan..'mute_document'..msg.chat_id_) or 'false')
.."\nܛ الاشعارات «» "..(redis:get(Titan..'mute_tgservice'..msg.chat_id_) or 'false')
.."\nܛ الكيبورد «» "..(redis:get(Titan..'mute_keyboard'..msg.chat_id_) or 'false')
.."\n\nـــــــــــــــــــــــــــــــــــــــــــــــــــــــــ\nܛ  `اعدادات اخرى : `"
.."\n\n ܛ  الترحيب «» "..welcomex
.."\n ܛ  الردود «» "..replayx
.."\n ܛ  التحذير «» "..lock_woringx
.."\n ܛ  الايدي «» "..lock_idx
list_settings = list_settings:gsub('true', '❬ مقفول ❭')
list_settings = list_settings:gsub('false', '❬ مفتوح ❭')
return sendMsg(msg.chat_id_,1,'➖\n'..list_settings..'\n')
end

function settings(msg)
list_settings = "ܛ `اعدادات المجموعه :` "
.."\n\n ܛ  التاك «» "..(redis:get(Titan..'lock_tag'..msg.chat_id_) or 'false')
.."\n ܛ  المعرفات «» "..(redis:get(Titan..'lock_username'..msg.chat_id_) or 'false')
.."\n ܛ  التعديل «» "..(redis:get(Titan..'lock_edit'..msg.chat_id_) or 'false')
.."\n ܛ  الروابط «» "..(redis:get(Titan..'lock_link'..msg.chat_id_) or 'false')
.."\n ܛ  التكرار «» "..(redis:get(Titan..'lock_flood'..msg.chat_id_) or 'false')
.."\n ܛ  الكلايش «» "..(redis:get(Titan..'lock_spam'..msg.chat_id_) or 'false')
.."\n ܛ  الويب «» "..(redis:get(Titan..'lock_webpage'..msg.chat_id_) or 'false')
.."\n ܛ  الماركدوان «» "..(redis:get(Titan..'lock_markdown'..msg.chat_id_) or 'false')
.."\n ܛ  البوتات بالطرد «» "..(redis:get(Titan..'lock_bots_by_kick'..msg.chat_id_) or 'false')
.."\n ܛ  البوتات «» "..(redis:get(Titan..'lock_bots'..msg.chat_id_) or 'false')
.."\n ܛ  عدد التكرار «» "..(redis:get(Titan..'num_msg_Titan'..msg.chat_id_) or 'false')
.."\n┄─┅═ـ═┅─┄\nاعدادات التقـييد :\n"
.."\n 💢ܛ  التقييد بالتوجيه «» "..(redis:get(Titan..':tqeed_fwd:'..msg.chat_id_) or 'false')
.."\n ܛ  التقييد بالصور «» "..(redis:get(Titan..':tqeed_photo:'..msg.chat_id_) or 'false')
.."\n ܛ  التقييد بالروابط «» "..(redis:get(Titan..':tqeed_link:'..msg.chat_id_) or 'false')
.."\n ܛ  التقييد بالمتحركه «» "..(redis:get(Titan..':tqeed_gif:'..msg.chat_id_) or 'false')
.."\n ܛ  التقييد الفيديو «» "..(redis:get(Titan..':tqeed_video:'..msg.chat_id_) or 'false')
list_settings = list_settings:gsub('true', '❬ مقفول ❭')
list_settings = list_settings:gsub('false', '❬ مفتوح ❭')
return sendMsg(msg.chat_id_, msg.id_,'➖\n'..list_settings..'\n')
end

function media(msg)
list_settings = " ܛ  `اعدادات الوسائط:`\n"
.."\n ܛ  المتحركه «» "..(redis:get(Titan..'mute_gif'..msg.chat_id_) or 'false')
.."\n ܛ  الدردشه «» "..(redis:get(Titan..'mute_text'..msg.chat_id_) or 'false')
.."\n ܛ  الانلاين «» "..(redis:get(Titan..'mute_inline'..msg.chat_id_) or 'false')
.."\n ܛ  الالعاب «» "..(redis:get(Titan..'mute_game'..msg.chat_id_) or 'false')
.."\n ܛ  الصور «» "..(redis:get(Titan..'mute_photo'..msg.chat_id_) or 'false')
.."\n ܛ  الفيديو «» "..(redis:get(Titan..'mute_video'..msg.chat_id_) or 'false')
.."\n ܛ  البصمات «» "..(redis:get(Titan..'mute_audio'..msg.chat_id_) or 'false')
.."\n ܛ  الصوت «» "..(redis:get(Titan..'mute_voice'..msg.chat_id_) or 'false')
.."\n ܛ  الملصقات «» "..(redis:get(Titan..'mute_sticker'..msg.chat_id_) or 'false')
.."\n ܛ  الجهات «» "..(redis:get(Titan..'mute_contact'..msg.chat_id_) or 'false')
.."\n ܛ  التوجيه «» "..(redis:get(Titan..'mute_forward'..msg.chat_id_) or 'false')
.."\n ܛ  الموقع «» "..(redis:get(Titan..'mute_location'..msg.chat_id_) or 'false')
.."\n ܛ  الملفات «» "..(redis:get(Titan..'mute_document'..msg.chat_id_) or 'false')
.."\n ܛ  الاشعارات «» "..(redis:get(Titan..'mute_tgservice'..msg.chat_id_) or 'false')
.."\n ܛ  الكيبورد «» "..(redis:get(Titan..'mute_keyboard'..msg.chat_id_) or 'false')
list_settings = list_settings:gsub('true', '❬ مقفول ❭')
list_settings = list_settings:gsub('false', '❬ مفتوح ❭')
return sendMsg(msg.chat_id_,msg.id_,'➖\n'..list_settings..'\n')
end
