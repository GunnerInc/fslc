section .rodata
;~ UI  incbin 'fslc.ui'
;~ SettingsFile incbin 'settings.conf'

szInfo_TxtBoxes:
    .1  db 'txt_info_ip', 0
    .2  db 'txt_info_name', 0
    .3  db 'txt_info_email', 0
    .4  db 'txt_info_evdnce', 0
    
Info_TxtBoxes:
        dq  szInfo_TxtBoxes.1, szInfo_TxtBoxes.2, szInfo_TxtBoxes.3, szInfo_TxtBoxes.4
INFO_TXT_ARR_LEN equ ($ - Info_TxtBoxes) / 8

szInfo_Buttons:
    .1  db 'btn_info_search', 0
    .2  db 'btn_info_clear', 0
    .3  db 'btn_info_submit', 0
Info_Buttons:
        dq szInfo_Buttons.1, szInfo_Buttons.2, szInfo_Buttons.3
INFO_BTN_ARR_LEN equ ($ - Info_Buttons) / 8

szLog_Buttons:
    .1  db 'btn_log_save', 0
    .2  db 'btn_log_clear', 0
Log_Buttons:
        dq  szLog_Buttons.1, szLog_Buttons.2
LOG_BTN_ARR_LEN equ ($ - Log_Buttons) / 8

szSFS_Labels:
    .1  db 'sfs_ip_freq', 0
    .2  db 'sfs_ip_conf', 0
    .3  db 'sfs_ip_seen', 0
    .4  db 'sfs_name_freq', 0
    .5  db 'sfs_name_conf', 0
    .6  db 'sfs_name_seen', 0
    .7  db 'sfs_email_freq', 0
    .8  db 'sfs_email_conf', 0
    .9  db 'sfs_email_seen', 0
Info_SFS_Labels:
        dq szSFS_Labels.1, szSFS_Labels.2, szSFS_Labels.3
        dq szSFS_Labels.4, szSFS_Labels.5, szSFS_Labels.6
        dq szSFS_Labels.7, szSFS_Labels.8, szSFS_Labels.9
SFS_LABEL_ARR_LEN equ ($ - Info_SFS_Labels) / 8

szSFS_Label_IP      db 'sfs_ip', 0
szSFS_Label_Name    db 'sfs_name', 0
szSFS_Label_Email   db 'sfs_email', 0
szSFS_Spinner       db 'sfs_spinner', 0

szPHP_Labels:
    .1  db 'php_type', 0
    .2  db 'php_seen', 0
    .3  db 'php_threat', 0
Info_PHP_Labels:
        dq  szPHP_Labels.1, szPHP_Labels.2, szPHP_Labels.3
PHP_LABEL_ARR_LEN equ ($ - Info_PHP_Labels) / 8

szFSL_Labels:
    .1  db 'fsl_ip_times', 0
    .2  db 'fsl_ip_threat', 0
    .3  db 'fsl_ip_seen', 0
    .4  db 'fsl_name_times', 0
    .5  db 'fsl_name_threat', 0
    .6  db 'fsl_name_seen', 0
    .7  db 'fsl_email_times', 0
    .8  db 'fsl_email_threat', 0
    .9  db 'fsl_email_seen', 0
Info_FSL_Labels:
        dq szFSL_Labels.1, szFSL_Labels.2, szFSL_Labels.3
        dq szFSL_Labels.4, szFSL_Labels.5, szFSL_Labels.6
        dq szFSL_Labels.7, szFSL_Labels.8, szFSL_Labels.9
FSL_LABEL_ARR_LEN equ ($ - Info_FSL_Labels) / 8

szBS_Labels:
    .1  db 'bs_ip', 0
    .2  db 'bs_name', 0
    .3  db 'bs_email', 0
Info_BS_Labels:
        dq szBS_Labels.1, szBS_Labels.2, szBS_Labels.3
BS_LABEL_ARR_LEN equ ($ - Info_BS_Labels) / 8

szIPInfo_Labels:
    .1  db 'ip_country', 0
    .2  db 'ip_region', 0
    .3  db 'ip_city', 0
    .4  db 'ip_zip', 0
    ;~ .5  db 'ip_tz', 0
    .5  db 'ip_lat', 0
    .6  db 'ip_long', 0
    ;~ .7  db 'ip_lat', 0
    .7  db 'ip_tz', 0
    .8  db 'ip_flag', 0
Info_IPInfo_Labels:
        dq szIPInfo_Labels.1, szIPInfo_Labels.2, szIPInfo_Labels.3, szIPInfo_Labels.4
        dq szIPInfo_Labels.5, szIPInfo_Labels.6, szIPInfo_Labels.7, szIPInfo_Labels.8
IPINFO_LABEL_ARR_LEN equ ($ - Info_IPInfo_Labels) / 8

szInfo_Frames:
    .1  db 'sfs_info', 0
    .2  db 'php_info', 0
    .3  db 'fsl_info', 0
    .4  db 'bs_info', 0
    .5  db 'ip_info', 0
Info_Frames:
        dq  szInfo_Frames.1, szInfo_Frames.2
        dq  szInfo_Frames.3, szInfo_Frames.4, szInfo_Frames.5
INFO_FRAME_ARR_LEN equ ($ - Info_Frames) / 8

szQuery_ChkBoxes:
    .1  db 'sfs_query', 0
    .2  db 'php_query', 0
    .3  db 'fsl_query', 0
    .4  db 'bs_query', 0
    .5  db 'ip_query', 0
    .6  db 'ip_query_flag', 0
Query_ChkBoxes:
        dq szQuery_ChkBoxes.1, szQuery_ChkBoxes.2
        dq szQuery_ChkBoxes.3, szQuery_ChkBoxes.4, szQuery_ChkBoxes.5, szQuery_ChkBoxes.6 
QUERY_CHECKS_ARR_LEN equ ($ - Query_ChkBoxes) / 8

szSubmit_ChkBoxes:
    .1  db  'sfs_submit', 0
    .2  db  'bs_submit', 0
Submit_ChkBoxes:
        dq szSubmit_ChkBoxes.1, szSubmit_ChkBoxes.2
SUBMIT_CHECKS_ARR_LEN equ ($ - Submit_ChkBoxes) / 8
 
szSFSQuery_Options:
    .1  db 'sfs_nobademail', 0
    .2  db 'sfs_nobadusername', 0
    .3  db 'sfs_nobadip', 0
    .4  db 'sfs_nobadall', 0
    .5  db 'sfs_notorexit', 0
SFSQuery_Options:
        dq szSFSQuery_Options.1 , szSFSQuery_Options.2 , szSFSQuery_Options.3
        dq szSFSQuery_Options.4 , szSFSQuery_Options.5
SFS_QUERY_OPTS_ARR_LEN equ ($ - SFSQuery_Options) / 8

szKeys_TxtBoxes:
    .1  db  'key_sfs', 0
    .2  db  'key_php', 0
    .3  db  'key_fsl', 0
    .4  db  'key_bs', 0
    .5  db  'key_ip', 0
rgpszKeys_TxtBoxes:
        dq szKeys_TxtBoxes.1, szKeys_TxtBoxes.2
        dq szKeys_TxtBoxes.3, szKeys_TxtBoxes.4, szKeys_TxtBoxes.5
API_TXTBOX_ARR_LEN equ ($ - rgpszKeys_TxtBoxes) / 8

SearchFlags:
    dq  OPT_SFS, OPT_PHP, OPT_FSL, OPT_BS, OPT_IPINFO, OPT_SHOW_FLAG
SEARCH_FLAGS_LEN equ ($ - SearchFlags) / 8

SFSOptFlags:
    dq  OPT_SFS_EMAIL, OPT_SFS_NAME, OPT_SFS_IP, OPT_SFS_ALL, OPT_SFS_TOR
SFS_OPT_FLAGS_LEN equ ($ - SFSOptFlags) / 8

SubmitFlags:
    dq  OPT_SFS_SUBMIT, OPT_BS_SUBMIT
SUBMIT_FLAGS_LEN equ ($ - SubmitFlags) / 8

szInfo_Fixed:
    .1  db  'f1', 0
    .2  db  'f2', 0
    .3  db  'f3', 0
    .4  db  'f5', 0
    .5  db  'f6', 0
    .6  db  'f4', 0
rgpszInfo_Fixed:
        dq szInfo_Fixed.2, szInfo_Fixed.3, szInfo_Fixed.4
        dq szInfo_Fixed.5, szInfo_Fixed.6
INFO_FIXED_ARR_LEN equ ($ - rgpszInfo_Fixed) / 8

szSearchEngine_Array:
    .1  db 'Undocumented', 0
    .2  db 'AltaVista', 0
    .3  db 'Ask', 0
    .4  db 'Baidu', 0
    .5  db 'Excite', 0
    .6  db 'Google', 0
    .7  db 'Looksmart', 0
    .8  db 'Lycos', 0
    .9  db 'MSN', 0
    .10 db 'Yahoo', 0
    .11 db 'Cuil', 0
    .12 db 'InfoSeek', 0
    .13 db 'Miscellaneous', 0
rgpszSearchEngines:
        dq szSearchEngine_Array.1, szSearchEngine_Array.2, szSearchEngine_Array.3
        dq szSearchEngine_Array.4, szSearchEngine_Array.5, szSearchEngine_Array.6
        dq szSearchEngine_Array.7, szSearchEngine_Array.8, szSearchEngine_Array.9
        dq szSearchEngine_Array.10, szSearchEngine_Array.11, szSearchEngine_Array.12, szSearchEngine_Array.13
SE_ARRAY_LEN equ ($ - rgpszSearchEngines) / 8

szPHP_Type_Array:
    .0  db '', 0
    .1  db 'Suspicious', 0
    .2  db 'Harvester', 0
    .3  db 'Suspicious &amp; Harvester', 0
    .4  db 'Comment Spammer', 0
    .5  db 'Suspicious &amp; Comment Spammer', 0
    .6  db 'Harvester &amp; Comment Spammer', 0
    .7  db 'Suspicious, Harvester &amp; Comment Spammer', 0
    .8  db 'Reserved for Future Use', 0
rgpszPHP_Types:
        dq szPHP_Type_Array.0, szPHP_Type_Array.1, szPHP_Type_Array.2, szPHP_Type_Array.3, szPHP_Type_Array.4
        dq szPHP_Type_Array.5, szPHP_Type_Array.6, szPHP_Type_Array.7, szPHP_Type_Array.8
PHP_TYPE_ARR_LEN equ ($ - rgpszPHP_Types) / 8

szInfoStatusIcons:
    .1  db 'sfs_status_q', 0
    .2  db 'php_status_q', 0
    .3  db 'fsl_status_q', 0
    .4  db 'bs_status_q', 0
    .5  db 'ip_status_q', 0    
    .6  db 'sfs_status_s', 0
    .7  db 'bs_status_s', 0
InfoStatusIcons:
        dq szInfoStatusIcons.1, szInfoStatusIcons.2, szInfoStatusIcons.3, szInfoStatusIcons.4
        dq szInfoStatusIcons.5, szInfoStatusIcons.6, szInfoStatusIcons.7
INFO_STATUS_IMGS_ARR_LEN equ ($ - InfoStatusIcons) / 8

szErrTextView   db 'txt_err_logs', 0
szErrNoGTK      db  'Could not initialize GTK!', 0
szErrNoCurl     db  'Could not initialize cURL!', 0

fmtint          db '%ld',10,   0

fmtstr          db '%s', 10, 0
fmtstr2         db '%s%s', 0
fmtstr3         db '%s%s%s', 0
fmtstr4         db '%s%s%s%s', 0
fmtstr5         db '%s%s%s%s%s', 0
fmtstr6         db '%s%s%s%s%s%s', 0
fmtstr7         db '%s%s%s%s%s%s%s', 0
fmtstr8         db '%s%s%s%s%s%s%s%s', 0
fmttimedateLog  db '%x %X', 0
fmtTimeDateName db '%F-%T.log', 0

szUIFile        db 'fslc.ui', 0
szWinMain       db 'win_main', 0
szDlgSearchOptions  db 'dlg_search_options', 0
szNoteBook      db 'nb_main', 0
szSFSQueryOptFrame  db 'SFSQueryOptFrame', 0
szSubmitSpinner db 'submit_spinner', 0
szSaveDialog    db 'save_dialog', 0

szSettingsFile          db 'settings.conf', 0
szGrpKeys               db 'keys', 0
szKeySFS                db 'sfs', 0
szKeyPHP                db 'php', 0
szKeyFSL                db 'fsl', 0
szKeyBS                 db 'bs', 0
szKeyIP                 db 'ipinfo', 0
szGrpOptions            db 'options', 0
szKeyFlags              db 'flags', 0
;szGrpQuery              db 'query', 0
szGrpSubmit             db 'submit', 0
szGrpBatchSubmit        db 'bsubmit', 0

;~ ##### Error
szErrEmptyFields        db 'Please enter some data to search for!', 0
szErrEmptyFieldsTitle   db 'Missing data!', 0
szErrBadIP              db 'You entered an invalid IP Address!', 0
szErrBadIPTitle         db 'Invalid IP Address', 0
szErrIPNotFound         db 'IP WAS NOT FOUND', 0
szErrPHPReply           db 'ERROR IN QUERY REPLY!', 0
szErrIPMissing          db '**** Query Skipped - No IP Address ****', 0
szErrAPIKeyMissing      db '**** Query Skipped - Missing API Key! ****', 0
szQuery                 db '<b>Query!</b>', 0
szSkipped               db '<b>Skipped</b>', 0
szMissing               db '<b>Missing</b>', 0
szAPI                   db '<b>API</b>', 0
szKey                   db '<b>Key!!</b>', 0
szErrError              db 'ERROR', 0
szErrLogged             db 'LOGGED', 0
szFieldMissing          db 'The following fields are required:', 10, 10
                        db '    IP', 10
                        db '    Name', 10
                        db '    Email', 10, 10
                        db 'The evidence field is optional', 0
    
;~ ##### Stop Forum Spam
szSFSURL                db 'http://www.stopforumspam.com', 0
SFS_BASE_URL_LEN        equ $ - szSFSURL
szSFSQueryAPI           db '/api?', 0
szSFSQueryFmtJson       db '&f=json', 0
szSFSQueryEmailField    db 'email=', 0
szSFSQueryIPField       db 'ip=', 0
szSFSQueryNameField     db 'username=', 0
szSFSNoEmail            db '&nobademail', 0
szSFSNoName             db '&nobadusername', 0
szSFSNoIP               db '&nobadip', 0
szSFSNoAll              db '&nobadall', 0
szSFSNoTor              db '&notorexit', 0
SFS_URL_LEN             equ $ - szSFSURL

szSFSSubmitAPI          db  '/add.php', 0
szSFSSubmitName         db  '?username=', 0
szSFSSubmitIP           db  '&ip_addr=', 0
szSFSSubmitEvdnce       db  '&evidence=', 0
szSFSSubmitEmail        db  '&email=', 0
szSFSSubmitAPIKey       db  '&api_key=', 0
SFS_SUBMIT_URL_LEN      equ ($ - szSFSSubmitAPI) + SFS_BASE_URL_LEN + 1

szLabelBoldFormat       equ fmtstr3 
szSFSURLFormat          db '%s%s%s%s%s%s%s', 0
szAHrefStart            db '<a href="', 0
szSFSSearch             db '/search/', 0
szSFSIPSearch           db '/ipcheck/', 0
szURLEnd                db '">', 0
szAHrefEnd              db '</a>', 0
szIPText                db 'IP' , 0
szNameText              db 'Name', 0
szEmailText             db 'Email', 0
szBoldOpen              db '<b>', 0
szBoldClose             db '</b>', 0

;~ ##### Project Honey Pot
szPHPQueryDNS           db '.dnsbl.httpbl.org', 0
szPHPSearchURL          db 'http://www.projecthoneypot.org/ip_', 0

szUserAgent             db 'Forum Spam List Checker/5.0.1 Alpha (Linux)', 0

;~ ##### FSpamlist
szFSLURL                db 'http://www.fspamlist.com/api.php?key=', 0
szFSLSpammperField      db '&spammer=', 0
szFSLFmtJson            db '&json', 0
FSL_URL_LEN             equ ($ - szFSLURL) + 2 ; 2 commas

;~ ##### BotScout
szBotScoutURL           db 'http://www.botscout.com/', 0
szBSQuery               db 'test/?multi', 0
szBSNameField           db '&name=', 0
szBSEmailField          db '&mail=', 0
szBSIPField             db '&ip=', 0
szBSKeyField            db '&key=', 0
BS_URL_LEN              equ $ - szBotScoutURL
szBSSearch              db 'search.htm?stype=q&amp;sterm=', 0
szBSSearchEnd           db '&amp;stype=q', 0

szBSSubmitPage			db 'http://www.botscout.com/api_submitter.htm', 0
szBSSubmitNameField		db 'xname=', 0
szBSSubmitEmailField	db '&xrg=', 0
szBSSubmitIPField		db '&xdc=', 0
szBSSubmitKeyField		db '&apk=', 0
szBSSubmitAddField		db '&act=addbot', 0
szBSSubmitAppId		    db '&appid=FSLC_5.0.0_', 0
BS_SUBMIT_FIELD_LEN     equ ($ - szBSSubmitNameField) + 25

;~ ##### IPINfoDB
szIPInfoURL             db 'http://api.ipinfodb.com/v3/ip-city/?key=', 0
szIPInfoIPField         equ szBSIPField
IP_URL_LEN              equ $ - szIPInfoURL + 5

szDot                   db '.', 0
;szWww                   db 'www', 0
;szHttp                  db 'http://', 0
;szCom                   db 'com' , 0
szAmp                   db '&', 0
szDash                  db '-', 0
szComma                 db ',', 0
szSemiColon             db ';', 0
szZero                  db '0', 0
szDays                  db '%s day(s) ago', 0
szLF                    db 10, 0
szLFx2                  db 10, 10, 0
szEmpty                 db "", 0


szIsSpammer             db 'isspammer', 0
szTimesReported         db 'timesreported', 0
szThreat                db 'threat', 0
szLastSeen              db 'lastseen', 0
szUserName              db 'username', 0
szFrequency             db 'frequency', 0
szIP                    db 'ip', 0
szEmail                 db 'email', 0
szMail                  db 'mail', 0
szName                  db 'name', 0
szConf                  db 'confidence', 0
szAppears               db 'appears', 0
szNever                 db 'never', 0
szSearchEngine		    db 'Search Engine - ', 0

szQuerySingle           db ' - Single Query', 0
szSubmitSingle          db ' - Single Submit', 0
szServBotScout          db 'BotScout', 0
szServSFS               db 'Stop Forum Spam', 0
szServPHP               db 'Project Honey Pot', 0
szServIP                db 'IPInfoDB', 0

szMissingAPIKey         db 'Missing API Key', 0

szHomeURL               db 'http://www.gunnerinc.com/', 0
szFlagsFolder           db 'images/flags/', 0
FLAGS_URL_LEN           equ $ - szHomeURL + 7
szPngExt                db '.png', 0
szReserved              db 'rd', 0
szFlagsDir              db 'res/flags/', 0
FLAGS_FILE_LEN          equ $ - szPngExt + 1
szImgBad                db  'res/bad.png', 0
szImgGood               db  'res/good.png', 0

szTagName               db  'bold', 0
szProperty              db  'weight',0
szSaveLog               db  'Save Log to File', 0
szCancel                db  '_Cancel', 0
szSave                  db  '_Save', 0
szClearLogAfterSave     db  'Clear Log window after save', 0
szDelete                db  'clicked', 0

szAboutCSS              db 'GtkEventBox#abouttab{'
                        db 'background-color: black;'
                        db 'color: white;'
                        db 'font: bold;}'
                        db 'GtkButton#update{'
                        db 'font: normal;}'
                        db 'GtkLabel#version{'
                        db 'color: #FF0000;'
                        db 'font-size: 10px}', 0

mode            db 'wb', 0
pSFS_Reply:
        dq  SFSReplyStruc.Freq, SFSReplyStruc.Conf, SFSReplyStruc.Seen

