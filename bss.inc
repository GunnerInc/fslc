section .bss
rgpInfo_TxtBoxes    resq    INFO_TXT_ARR_LEN
rgpSFS_Labels       resq    SFS_LABEL_ARR_LEN
rgpPHP_Labels       resq    PHP_LABEL_ARR_LEN
rgpFSL_Labels       resq    FSL_LABEL_ARR_LEN
rgpBS_Labels        resq    BS_LABEL_ARR_LEN
rgpIPInfo_Labels    resq    IPINFO_LABEL_ARR_LEN
rgpInfo_Frames      resq    INFO_FRAME_ARR_LEN
rgpInfo_Buttons     resq    INFO_BTN_ARR_LEN
rgpInfo_Fixed       resq    INFO_FIXED_ARR_LEN
rgpQuery_ChkBoxes   resq    QUERY_CHECKS_ARR_LEN
rgpSFSQuery_Options resq    SFS_QUERY_OPTS_ARR_LEN
rgpKeys_TxtBoxes    resq    API_TXTBOX_ARR_LEN
rgpSubmit_ChkBoxes  resq    SUBMIT_CHECKS_ARR_LEN
rgpStatus_Imgs      resq    INFO_STATUS_IMGS_ARR_LEN
rgpLog_Buttons      resq    LOG_BTN_ARR_LEN

curl_handle         resq    1
oSearchMenu         resq    1
oNoteBook           resq    1
oSFSQueryOptFrame   resq    1
oMain               resq    1
QueryOptions        resq 1
DoSearch            resq 1
DoSubmit            resq    1
iterstart       resq 1
iterend     resq    1
oSFSName            resq 1
oSFSEmail           resq 1
oSFSIP              resq 1
oSFS_Spinner        resq 1
oErrLog             resq 1
oSubmitSpinner      resq 1
oInfo_Fixed         resq 1
oSaveDialog         resq 1
Err             resq    1
CurlErr             resb CURL_ERROR_SIZE

Color           resq    1
colsize     equ $-Color
pszSpammerInfo:
    .IP             resq 1
    .RevIP          resq 1
    .Name           resq 1
    .Email          resq 1
    

ReplyStruc_SFS_FSL:
SFSReplyStruc:
    .Freq           resb 32
    .Conf           resb 16 
    .Seen           resb 32    
    .len equ    $ - SFSReplyStruc

