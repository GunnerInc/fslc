
%include '../../include/gtk/gtkenums.inc'
%include '../../include/gdk/gdkkeysyms.h'
%include 'externs.inc'
%include 'exports.inc'
%include 'equates.inc'
%include 'rodata.inc'
%include 'bss.inc'

; Set to TRUE for debug output - FALSE for no output
; run make for changes.
;~ %define DEBUG TRUE

%include 'sfs.asm'
%include 'php.asm'
;~ %include 'fsl.asm'
%include 'bs.asm'
%include 'ipinfo.asm'


section .text
main:
    ; initialize GTK
    sub     rsp, 8 * 3
    mov     [rsp + 8], rdi                  ; argc
    lea     rdi, [rsp + 8]
    mov     [rsp], rsi                      ; argv
    mov     rsi, rsp        
    call    gtk_init_check
    add     rsp, 8 * 3 
    test    rax, rax
    jnz     .InitCurl

    ; Could not initialize GTK
    ; inform user, set retval to 1, and exit
    mov     rsi, szErrNoGTK
    mov     rdi, fmtstr
    xor     rax, rax
    call    printf
    mov     rdi, 1
    call    exit
    
.InitCurl:
    mov     rdi, CURL_GLOBAL_ALL
    call    curl_global_init
    test    rax, rax
    jnz     .CurlNoInit
    
    call    curl_easy_init
    test    rax, rax
    jnz     .CurlGood

.CurlNoInit:
    mov     rsi, szErrNoCurl
    mov     rdi, fmtstr
    xor     rax, rax
    call    printf
    mov     rdi, 1
    call    exit
    
.CurlGood:
    sub     rsp, 8
    mov     [curl_handle], rax

    call    gtk_builder_new
    mov     r15, rax
         
    mov     rdx, NULL  
    mov     rsi, szUIFile
    mov     rdi, rax  
    call    gtk_builder_add_from_file

    mov     rsi, szDlgSearchOptions
    mov     rdi, r15
    call    gtk_builder_get_object 
    mov     [oSearchMenu], rax

    mov     rsi, szSFS_Spinner
    mov     rdi, r15
    call    gtk_builder_get_object 
    mov     [oSFS_Spinner], rax
   
    call    SetAboutColor
   
    mov     rsi, szSubmitSpinner
    mov     rdi, r15
    call    gtk_builder_get_object 
    mov     [oSubmitSpinner], rax
    
    mov     rsi, szSFS_Label_IP
    mov     rdi, r15
    call    gtk_builder_get_object 
    mov     [oSFSIP], rax
    
    mov     rsi, szSFS_Label_Name
    mov     rdi, r15
    call    gtk_builder_get_object 
    mov     [oSFSName], rax

    mov     rsi, szSFS_Label_Email
    mov     rdi, r15
    call    gtk_builder_get_object 
    mov     [oSFSEmail], rax
        
    mov     rsi, szNoteBook
    mov     rdi, r15
    call    gtk_builder_get_object 
    mov     [oNoteBook], rax

    mov     rsi, szSFSQueryOptFrame
    mov     rdi, r15
    call    gtk_builder_get_object
    mov     [oSFSQueryOptFrame], rax

    mov     rsi, szErrTextView
    mov     rdi, r15
    call    gtk_builder_get_object 
    mov     [oErrLog], rax

    mov     rsi, szInfo_Fixed.1
    mov     rdi, r15
    call    gtk_builder_get_object 
    mov     [oInfo_Fixed], rax
            
    mov     rsi, szWinMain
    mov     rdi, r15
    call    gtk_builder_get_object
    mov     [oMain], rax
    mov     r14, rax

    
;-------------------------------------------
    mov     rbx, INFO_TXT_ARR_LEN - 1
    mov     r12, Info_TxtBoxes
    mov     r13, rgpInfo_TxtBoxes
.GetInfoTxtBoxes:
    mov     rsi, [r12 + 8 * rbx]
    mov     rdi, r15
    call    gtk_builder_get_object
    mov     [r13 + 8 * rbx], rax
    dec     rbx
    jns     .GetInfoTxtBoxes

;-------------------------------------------
    mov     rbx, SFS_LABEL_ARR_LEN - 1
    mov     r12, Info_SFS_Labels
    mov     r13, rgpSFS_Labels
.GetSFSLabels:
    mov     rsi, [r12 + 8 * rbx]
    mov     rdi, r15
    call    gtk_builder_get_object
    mov     [r13 + 8 * rbx], rax
    dec     rbx
    jns     .GetSFSLabels

;-------------------------------------------
    mov     rbx, PHP_LABEL_ARR_LEN - 1
    mov     r12, Info_PHP_Labels
    mov     r13, rgpPHP_Labels
.GetPHPLabels:
    mov     rsi, [r12 + 8 * rbx]
    mov     rdi, r15
    call    gtk_builder_get_object
    mov     [r13 + 8 * rbx], rax
    dec     rbx
    jns     .GetPHPLabels

;-------------------------------------------
    mov     rbx, FSL_LABEL_ARR_LEN - 1
    mov     r12, Info_FSL_Labels
    mov     r13, rgpFSL_Labels
.GetFSLLabels:
    mov     rsi, [r12 + 8 * rbx]
    mov     rdi, r15
    call    gtk_builder_get_object
    mov     [r13 + 8 * rbx], rax  
    dec     rbx
    jns     .GetFSLLabels

;-------------------------------------------
    mov     rbx, BS_LABEL_ARR_LEN - 1
    mov     r12, Info_BS_Labels
    mov     r13, rgpBS_Labels
.GetBSLabels:
    mov     rsi, [r12 + 8 * rbx]
    mov     rdi, r15
    call    gtk_builder_get_object
    mov     [r13 + 8 * rbx], rax
    dec     rbx
    jns     .GetBSLabels
                
;-------------------------------------------
    mov     rbx, IPINFO_LABEL_ARR_LEN - 1
    mov     r12, Info_IPInfo_Labels
    mov     r13, rgpIPInfo_Labels
.GetIPInfoLabels:
    mov     rsi, [r12 + 8 * rbx]
    mov     rdi, r15
    call    gtk_builder_get_object
    mov     [r13 + 8 * rbx], rax
    dec     rbx
    jns     .GetIPInfoLabels

;-------------------------------------------
    mov     rbx, INFO_FRAME_ARR_LEN - 1
    mov     r12, Info_Frames
    mov     r13, rgpInfo_Frames
.GetInfoFrames:
    mov     rsi, [r12 + 8 * rbx]
    mov     rdi, r15
    call    gtk_builder_get_object
    mov     [r13 + 8 * rbx], rax
    dec     rbx
    jns     .GetInfoFrames

;-------------------------------------------
    mov     rbx, INFO_BTN_ARR_LEN - 1
    mov     r12, Info_Buttons
    mov     r13, rgpInfo_Buttons
.GetInfoButtons:
    mov     rsi, [r12 + 8 * rbx]
    mov     rdi, r15
    call    gtk_builder_get_object
    mov     [r13 + 8 * rbx], rax
    dec     rbx
    jns     .GetInfoButtons

;-------------------------------------------
    mov     rbx, QUERY_CHECKS_ARR_LEN - 1
    mov     r12, Query_ChkBoxes
    mov     r13, rgpQuery_ChkBoxes
.GetQueryChkBoxes:
    mov     rsi, [r12 + 8 * rbx]
    mov     rdi, r15
    call    gtk_builder_get_object
    mov     [r13 + 8 * rbx], rax 
    dec     rbx
    jns     .GetQueryChkBoxes

;-------------------------------------------
    mov     rbx, SFS_QUERY_OPTS_ARR_LEN - 1
    mov     r12, SFSQuery_Options
    mov     r13, rgpSFSQuery_Options
.GetSFSOptChkBoxes:
    mov     rsi, [r12 + 8 * rbx]
    mov     rdi, r15
    call    gtk_builder_get_object
    mov     [r13 + 8 * rbx], rax
    dec     rbx
    jns     .GetSFSOptChkBoxes

;-------------------------------------------
    mov     rbx, SUBMIT_CHECKS_ARR_LEN - 1
    mov     r12, Submit_ChkBoxes
    mov     r13, rgpSubmit_ChkBoxes
.GetSubmitChkBoxes:
    mov     rsi, [r12 + 8 * rbx]
    mov     rdi, r15
    call    gtk_builder_get_object
    mov     [r13 + 8 * rbx], rax 
    dec     rbx
    jns     .GetSubmitChkBoxes



;-------------------------------------------
    mov     rbx, INFO_STATUS_IMGS_ARR_LEN - 1
    mov     r12, InfoStatusIcons
    mov     r13, rgpStatus_Imgs
.GetStatusImgs:
    mov     rsi, [r12 + 8 * rbx]
    mov     rdi, r15
    call    gtk_builder_get_object
    mov     [r13 + 8 * rbx], rax 
    dec     rbx
    jns     .GetStatusImgs
    
;-------------------------------------------
    mov     rbx, INFO_FIXED_ARR_LEN - 1
    mov     r12, rgpszInfo_Fixed
    mov     r13, rgpInfo_Fixed
.GetInfoFixed:
    mov     rsi, [r12 + 8 * rbx]
    mov     rdi, r15
    call    gtk_builder_get_object
    mov     [r13 + 8 * rbx], rax
    dec     rbx
    jns     .GetInfoFixed
    
;-------------------------------------------
    mov     rbx, API_TXTBOX_ARR_LEN - 1
    mov     r12, rgpszKeys_TxtBoxes
    mov     r13, rgpKeys_TxtBoxes
.GetAPITxtBoxes:
    mov     rsi, [r12 + 8 * rbx]
    mov     rdi, r15
    call    gtk_builder_get_object
    mov     [r13 + 8 * rbx], rax
    dec     rbx
    jns     .GetAPITxtBoxes

;-------------------------------------------
    mov     rbx, LOG_BTN_ARR_LEN - 1
    mov     r12, Log_Buttons
    mov     r13, rgpLog_Buttons
.GetLogButtons:
    mov     rsi, [r12 + 8 * rbx]
    mov     rdi, r15
    call    gtk_builder_get_object
    mov     [r13 + 8 * rbx], rax
    dec     rbx
    jns     .GetLogButtons
    
;-------------------------------------------

    mov     rsi,[rgpInfo_Fixed + FXD_SFS]
    mov     rdi, [oSFS_Spinner]
    call    gtk_widget_reparent
    
    call    LoadKeys
    call    LoadQueryFlags
   
    mov     rsi, NULL
    mov     rdi, r15    
    call    gtk_builder_connect_signals 
   
    mov     rdi, r15
    call    g_object_unref 

    mov     rdi, [oErrLog]
    call    gtk_text_view_get_buffer
    
    mov     r8, NULL
    mov     rcx, PANGO_WEIGHT_BOLD
    mov     rdx, szProperty
    mov     rsi, szTagName
    mov     rdi, rax
    call    gtk_text_buffer_create_tag
    
    mov     rdi, r14
    call    gtk_widget_show_all

    mov     rdi, [oSubmitSpinner]
    call    gtk_widget_hide
    
    mov     rdi, [oSFS_Spinner]
    call    gtk_widget_hide

    call    Clear_Query_Status_Imgs
            
    call    gtk_main
 
    mov     rdi, [curl_handle]
    call    curl_easy_cleanup

    call    curl_global_cleanup    
.DoneGood:
    add     rsp, 8
    mov     rdi, 0
    
.Done:
    call    exit
   
;~ #########################################
ShowSearchOptions:
    sub     rsp, 8

    mov     rdi,[oSearchMenu]
    call    gtk_dialog_run
    
    mov     rdi, [oSearchMenu]
    call    gtk_widget_hide

    call    SaveQueryFlags
    
    add     rsp, 8
    ret

;~ ######################################### 
Search_Opts_Enter:
    sub     rsp, 8
    mov     rdx, TRUE
    mov     rsi, GTK_STATE_ACTIVE
    call    gtk_widget_set_state_flags
    add     rsp, 8
    ret

;~ ######################################### 
Search_Opts_Leave:
    sub     rsp, 8
    mov     rdx, TRUE
    mov     rsi, GTK_STATE_NORMAL
    call    gtk_widget_set_state_flags

    add     rsp, 8
    MOV     RAX, TRUE
    ret
    
;~ #########################################    
Search_Opts_Btn_Key_Press:
    sub     rsp, 8

    mov     rax, [rsi + 28]
    cmp     ax, GDK_KEY_Return
    je      .DoOptions
    cmp     ax, GDK_KEY_KP_Enter
    je      .DoOptions
    cmp     ax, GDK_KEY_space
    je      .DoOptions

.Done:
    mov     rax, FALSE
    add     rsp, 8
    ret

.DoOptions:
    call    ShowSearchOptions
    jmp     .Done

;~ ######################################### 
ToLower:
    sub     rsp, 8

    xor     rax, rax
.NextChar:
    cmp     byte [rdi + rax], 0
    je      .Done
    cmp     byte [rdi + rax], 65
    jl      .Next
    cmp     byte [rdi + rax], 90
    jg      .Next
    add     byte [rdi + rax], 32
.Next:
    add     rax, 1
    jmp     .NextChar

.Done:
    add     rsp, 8
    ret

;~ #######################################
SetSearchServices:   
    sub     rsp, 8
     
    push    rdi
    sub     rsp, 8
    
    call    gtk_toggle_button_get_active
    mov     rsi, rax
    
    add     rsp, 8
    pop     rdi
    
    cmp     rdi, [rgpQuery_ChkBoxes + CHK_QUERY_SFS_IDX]
    je      .SFS
    cmp     rdi, [rgpQuery_ChkBoxes + CHK_QUERY_PHP_IDX]
    je      .PHP
    ;~ cmp     rdi, [rgpQuery_ChkBoxes + CHK_QUERY_FSL_IDX]
    ;~ je      .FSL
    cmp     rdi, [rgpQuery_ChkBoxes + CHK_QUERY_BS_IDX]
    je      .BS
    cmp     rdi, [rgpQuery_ChkBoxes + CHK_QUERY_IPINFO_IDX]
    je      .IPINFO
    cmp     rdi, [rgpQuery_ChkBoxes + CHK_QUERY_FLAG_IDX]
    je      .FLAG
    jmp     .Done

;-------------------------------------------
.SFS:
    test    rsi, rsi
    jz      .subsfs
    or      qword [QueryOptions], OPT_SFS
    add     qword [DoSearch], 1
    jmp     .oversubsfs

.subsfs:
    sub     qword [QueryOptions], OPT_SFS
    sub     qword [DoSearch], 1
.oversubsfs:
    push    rsi
    sub     rsp, 8
    mov     rdi, [oSFSQueryOptFrame]
    call    gtk_widget_set_sensitive
    add     rsp, 8
    pop     rsi
    mov     rdi, [rgpInfo_Frames + FRA_SFS_IDX]
    jmp     .DoSensitive

;-------------------------------------------
.PHP:
    test    rsi, rsi
    jz      .subphp
    or      qword [QueryOptions], OPT_PHP
    add     qword [DoSearch], 1
    jmp     .oversubphp

.subphp:
    sub     qword [QueryOptions], OPT_PHP
    sub     qword [DoSearch], 1
.oversubphp:
    mov     rdi, [rgpInfo_Frames + FRA_PHP_IDX]
    jmp     .DoSensitive
    
;-------------------------------------------
.FLAG:
    test    rsi, rsi
    jz      .subflag
    or      qword [QueryOptions], OPT_SHOW_FLAG
    add     qword [DoSearch], 1

    mov     rdi, [rgpIPInfo_Labels + 8 * IPIDB_FLAG_IDX]
    call    gtk_widget_show
    
    jmp     .oversubflag

.subflag:
    sub     qword [QueryOptions], OPT_SHOW_FLAG
    sub     qword [DoSearch], 1
    
    mov     rdi, [rgpIPInfo_Labels + 8 * IPIDB_FLAG_IDX]
    call    gtk_widget_hide
    
.oversubflag:
    jmp     .Done

;-------------------------------------------
.BS:
    test    rsi, rsi
    jz      .subbs
    or      qword [QueryOptions], OPT_BS
    add     qword [DoSearch], 1
    jmp     .oversubbs

.subbs:
    sub     qword [QueryOptions], OPT_BS
    sub     qword [DoSearch], 1
.oversubbs:
    mov     rdi, [rgpInfo_Frames + FRA_BS_IDX]
    jmp     .DoSensitive

;-------------------------------------------
.IPINFO:
    push    rsi
    sub     rsp, 8
    
    test    rsi, rsi
    jz      .subipinfo
    or      qword [QueryOptions], OPT_IPINFO
    add     qword [DoSearch], 1
    mov     rax, qword [QueryOptions]
    and     rax, OPT_SHOW_FLAG
    jz      .oversubipinfo
    mov     rdi, [rgpIPInfo_Labels + 8 * IPIDB_FLAG_IDX]
    call    gtk_widget_show
    jmp     .oversubipinfo

.subipinfo:
    sub     qword [QueryOptions], OPT_IPINFO
    sub     qword [DoSearch], 1
    
    mov     rdi, [rgpIPInfo_Labels + 8 * IPIDB_FLAG_IDX]
    call    gtk_widget_hide
    
.oversubipinfo:
    add     rsp, 8
    pop     rsi
    mov     rdi, [rgpInfo_Frames + FRA_IPINFO_IDX] 
    
.DoSensitive:
    call    gtk_widget_set_sensitive        ; selected frame

    mov     rcx, 1
    xor     rsi, rsi
    mov     rax, qword [DoSearch]
    test    rax, rax
    cmovnz  rsi, rcx
    mov     rdi, [rgpInfo_Buttons + BTN_INFO_SEARCH_IDX]
    call    gtk_widget_set_sensitive

.Done:
    add     rsp, 8
    ret

;~ #######################################
SetSubmitServices:
    push    rdi
    
    call    gtk_toggle_button_get_active
    mov     rsi, rax

    pop     rdi
    sub     rsp, 8
    
    cmp     rdi, [rgpSubmit_ChkBoxes + CHK_SUBMIT_SFS_IDX]
    je      .SFS
    cmp     rdi, [rgpSubmit_ChkBoxes + CHK_SUBMIT_BS_IDX]
    je      .BS
    jmp     .Done

.SFS:
    test    rsi, rsi
    jz      .subsfs
    or      qword [QueryOptions], OPT_SFS_SUBMIT
    add     qword [DoSubmit], 1
    jmp     .SetSubmitButtonState

.subsfs:
    sub     qword [QueryOptions], OPT_SFS_SUBMIT
    sub     qword [DoSubmit], 1
    jmp     .SetSubmitButtonState
    
.BS:
    test    rsi, rsi
    jz      .subbs
    or      qword [QueryOptions], OPT_BS_SUBMIT
    add     qword [DoSubmit], 1
    jmp     .SetSubmitButtonState

.subbs:
    sub     qword [QueryOptions], OPT_BS_SUBMIT
    sub     qword [DoSubmit], 1
    
.SetSubmitButtonState:
    mov     rcx, 1
    xor     rsi, rsi
    mov     rax, qword [DoSubmit]
    test    rax, rax
    cmovnz  rsi, rcx
    mov     rdi, [rgpInfo_Buttons + BTN_INFO_SUBMIT_IDX]
    call    gtk_widget_set_sensitive
    
    call    SaveQueryFlags
    
.Done:
    add     rsp, 8
    ret
    
;~ #########################################
LoadQueryFlags:
    push    r15
    push    r14
    push    r13
    push    r12
    sub     rsp, 8

    mov     qword [DoSearch], 0
    mov     qword [DoSubmit], 0
    
    call    g_key_file_new
    mov     [rsp], rax

    mov     rcx, NULL
    mov     rdx, G_KEY_FILE_KEEP_COMMENTS
    mov     rsi, szSettingsFile
    mov     rdi, [rsp]
    call    g_key_file_load_from_file
    test    rax, rax
    jz      .BadVal
    
    mov     rcx, NULL
    mov     rdx, szKeyFlags
    mov     rsi, szGrpOptions
    mov     rdi, [rsp]
    call    g_key_file_get_uint64
    test    rax, rax
    js      .BadVal
    jnz     .SetChecks
    
.BadVal:
    mov     qword [QueryOptions], 0
    jmp     .Done    

.SetChecks:
    mov     [QueryOptions], rax
    
    mov     r15, rgpQuery_ChkBoxes
    mov     r14, SearchFlags
    mov     r13, SEARCH_FLAGS_LEN - 1
    mov     r12, rgpInfo_Frames
.NextFlag:
    mov     rax, qword [QueryOptions]
    and     rax, [r14 + 8 * r13]
    jz      .Over
    add     qword [DoSearch], 1
    mov     rsi, TRUE
    mov     rdi, [r15 + 8 * r13]
    call    gtk_toggle_button_set_active

    mov     rsi, TRUE
    mov     rdi, [r12 + 8 * r13]
    call    gtk_widget_set_sensitive        
.Over:
    dec     r13
    jns     .NextFlag
    
;----------------------------------------
.SetSubmitChecks:
    mov     r15, rgpSubmit_ChkBoxes
    mov     r14, SubmitFlags
    mov     r13, SUBMIT_FLAGS_LEN - 1
.NextSubmitOpt:
    mov     rax, qword [QueryOptions]
    and     rax, [r14 + 8 * r13]
    jz      .OverSubmit
    add     qword [DoSubmit], 1
    
    mov     rsi, TRUE
    mov     rdi, [r15 + 8 * r13]
    call    gtk_toggle_button_set_active
    
.OverSubmit:
    dec     r13
    jns     .NextSubmitOpt
    
    cmp     qword [DoSubmit], 0
    je      .OverSubmitButton

    mov     rsi, TRUE
    mov     rdi, [rgpInfo_Buttons + BTN_INFO_SUBMIT_IDX]
    call    gtk_widget_set_sensitive
        
.OverSubmitButton:
    mov     rsi, TRUE
    mov     rdi, [rgpInfo_Buttons + BTN_INFO_SEARCH_IDX]
    call    gtk_widget_set_sensitive

    ; If SFS is Checked, enable options otherwise disable
    mov     rdi, [rgpQuery_ChkBoxes + CHK_QUERY_SFS_IDX]
    call    gtk_toggle_button_get_active
    push    rax
    
    mov     rsi, rax
    mov     rdi, [oSFSQueryOptFrame]
    call    gtk_widget_set_sensitive
    pop     rax
    test    rax, rax
    jz      .Done
    
.SetSFSChecks:
    mov     r15, rgpSFSQuery_Options
    mov     r14, SFSOptFlags
    mov     r13, SFS_OPT_FLAGS_LEN - 1
.NextSFSOpt:
    mov     rax, qword [QueryOptions]
    and     rax, [r14 + 8 * r13]
    jz      .OverSFS

    mov     rsi, TRUE
    mov     rdi, [r15 + 8 * r13]
    call    gtk_toggle_button_set_active
.OverSFS:
    dec     r13
    jns     .NextSFSOpt
    
.Done:
    mov     rdi, [rsp]
    call    g_key_file_free
        
    add     rsp, 8
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    ret

;~ #########################################
LoadKeys:
    sub     rsp, 8 * 3

    call    g_key_file_new
    mov     [rsp], rax
    
    mov     rcx, NULL
    mov     rdx, G_KEY_FILE_KEEP_COMMENTS
    mov     rsi, szSettingsFile
    mov     rdi, [rsp]
    call    g_key_file_load_from_file
    test    rax, rax
    jz      .Done

.GetSFSKey:
    mov     rcx, NULL
    mov     rdx, szKeySFS
    mov     rsi, szGrpKeys
    mov     rdi, [rsp]
    call    g_key_file_get_value
    test    rax, rax
    jz      .GetPHPKey
    
    mov     [rsp + 8], rax
    
    mov     rsi, rax
    mov     rdi, [rgpKeys_TxtBoxes + KEY_SFS]
    call    gtk_entry_set_text

    mov     rdi, [rsp + 8]
    call    g_free

.GetPHPKey:
    mov     rcx, NULL
    mov     rdx, szKeyPHP
    mov     rsi, szGrpKeys
    mov     rdi, [rsp]
    call    g_key_file_get_value
    test    rax, rax
    jz      .GetBSKey
    
    mov     [rsp + 8], rax
    
    mov     rsi, rax
    mov     rdi, [rgpKeys_TxtBoxes + KEY_PHP]
    call    gtk_entry_set_text

    mov     rdi, [rsp + 8]
    call    g_free
    
.GetBSKey:
    mov     rcx, NULL
    mov     rdx, szKeyBS
    mov     rsi, szGrpKeys
    mov     rdi, [rsp]
    call    g_key_file_get_value
    test    rax, rax
    jz      .GetFSLKey
    
    mov     [rsp + 8], rax

    mov     rsi, rax
    mov     rdi, [rgpKeys_TxtBoxes + KEY_BS]
    call    gtk_entry_set_text

    mov     rdi, [rsp + 8]
    call    g_free
    
.GetFSLKey:
    mov     rcx, NULL
    mov     rdx, szKeyFSL
    mov     rsi, szGrpKeys
    mov     rdi, [rsp]
    call    g_key_file_get_value
    test    rax, rax
    jz      .GetIPKey
    
    mov     [rsp + 8], rax
    
    mov     rsi, rax
    mov     rdi, [rgpKeys_TxtBoxes + KEY_FSL]
    call    gtk_entry_set_text

    mov     rdi, [rsp + 8]
    call    g_free
    
.GetIPKey:
    mov     rcx, NULL
    mov     rdx, szKeyIP
    mov     rsi, szGrpKeys
    mov     rdi, [rsp]
    call    g_key_file_get_value
    test    rax, rax
    jz      .Done
    
    mov     [rsp + 8], rax
    
    mov     rsi, rax
    mov     rdi, [rgpKeys_TxtBoxes + KEY_IPI]
    call    gtk_entry_set_text

    mov     rdi, [rsp + 8]
    call    g_free

.Done:
    mov     rdi, [rsp]
    call    g_key_file_free
    
    add     rsp, 8 * 3
    ret

;~ #########################################
;~ void SwitchTab (GtkNotebook *notebook,
                ;~ GtkWidget   *page,
                ;~ guint        page_num,
                ;~ gpointer     user_data) 
SwitchTab:
    sub     rsp, 8

    cmp     rdx, TAB_OPTIONS    ; see if we are changing to the options tab
    jne     .GetPage
    
    call    ErrLog_Get_Modified

    mov     rdi, rax
    call    Enable_Log_Buttons
    
    jmp     .Done
    
.GetPage:
    call    gtk_notebook_get_current_page    
    cmp     rax, TAB_OPTIONS    ; see if we are leaving the options tab
    jne     .Done
    
.SaveKeys:
    call    SaveKeys

.Done:
    add     rsp, 8
    ret
    
;~ #########################################
SetSFSOptions:
    sub     rsp, 8

    push    rdi
    sub     rsp, 8
    
    call    gtk_toggle_button_get_active
    mov     rsi, rax

    add     rsp,8
    pop     rdi
    cmp     rdi, [rgpSFSQuery_Options + CHK_SFSOPT_NOEMAIL_IDX]
    je      .NoEmail
    cmp     rdi, [rgpSFSQuery_Options + CHK_SFSOPT_NONAME_IDX]
    je      .NoName
    cmp     rdi, [rgpSFSQuery_Options + CHK_SFSOPT_NOIP_IDX]
    je      .NoIP
    cmp     rdi, [rgpSFSQuery_Options + CHK_SFSOPT_NOALL_IDX]
    je      .NoAll
    cmp     rdi, [rgpSFSQuery_Options + CHK_SFSOPT_NOTOR_IDX]
    je      .NoTor
    jmp     .Done

.NoEmail:   
    test    rsi, rsi
    jz      .subemail
    or      qword [QueryOptions], OPT_SFS_EMAIL
    jmp     .Done
.subemail:
    sub     qword [QueryOptions], OPT_SFS_EMAIL
    jmp     .Done
    
.NoName:
    test    rsi, rsi
    jz      .subname
    or      qword [QueryOptions], OPT_SFS_NAME
    jmp     .Done
.subname:
    sub     qword [QueryOptions], OPT_SFS_NAME
    jmp     .Done

.NoIP:
    test    rsi, rsi
    jz      .subip
    or      qword [QueryOptions], OPT_SFS_IP
    jmp     .Done
.subip:
    sub     qword [QueryOptions], OPT_SFS_IP
    jmp     .Done

.NoAll:
    test    rsi, rsi
    jz      .suball
    or      qword [QueryOptions], OPT_SFS_ALL
    jmp     .Done
.suball:
    sub     qword [QueryOptions], OPT_SFS_ALL
    jmp     .Done

.NoTor:
    test    rsi, rsi
    jz      .subtor
    or      qword [QueryOptions], OPT_SFS_TOR
    jmp     .Done
.subtor:
    sub     qword [QueryOptions], OPT_SFS_TOR
    
.Done:
    add     rsp, 8
    ret

;~ #########################################
SaveQueryFlags:
    sub     rsp, 8 * 3

    call    g_key_file_new
    mov     [rsp], rax

    mov     rcx, NULL
    mov     rdx, G_KEY_FILE_KEEP_COMMENTS
    mov     rsi, szSettingsFile
    mov     rdi, [rsp]
    call    g_key_file_load_from_file

    mov     rcx, qword [QueryOptions]
    mov     rdx, szKeyFlags
    mov     rsi, szGrpOptions
    mov     rdi, [rsp]
    call    g_key_file_set_int64

    mov     rdx, NULL
    lea     rsi, [rsp + 8]
    mov     rdi, [rsp]
    call    g_key_file_to_data
    mov     [rsp + 16], rax

    mov     rcx, NULL
    mov     rdx, [rsp + 8]
    mov     rsi, [rsp + 16]
    mov     rdi, szSettingsFile
    call    g_file_set_contents
    
    mov     rdi, [rsp + 16]
    call    g_free
    
    mov     rdi, [rsp]
    call    g_key_file_free
            
    add     rsp, 8 * 3
    ret

;~ #########################################
SaveKeys:
    sub     rsp, 8 * 3

    call    g_key_file_new
    mov     [rsp], rax

    mov     rcx, NULL
    mov     rdx, G_KEY_FILE_KEEP_COMMENTS
    mov     rsi, szSettingsFile
    mov     rdi, [rsp]
    call    g_key_file_load_from_file

    ;~ mov     rdi, [rgpKeys_TxtBoxes + KEY_SFS]
    ;~ call    gtk_entry_get_text_length
    ;~ test    rax, rax
    ;~ jz      .OverSFS
    
.SaveSFSKey:
    mov     rdi, [rgpKeys_TxtBoxes + KEY_SFS]
    call    gtk_entry_get_text
    
    mov     rcx, rax
    mov     rdx, szKeySFS
    mov     rsi, szGrpKeys
    mov     rdi, [rsp]
    call    g_key_file_set_value

.OverSFS:
    ;~ mov     rdi, [rgpKeys_TxtBoxes + KEY_PHP]
    ;~ call    gtk_entry_get_text_length
    ;~ test    rax, rax
    ;~ jz      .OverPHP

.SavePHPKey:
    mov     rdi, [rgpKeys_TxtBoxes + KEY_PHP]
    call    gtk_entry_get_text

    mov     rcx, rax
    mov     rdx, szKeyPHP
    mov     rsi, szGrpKeys
    mov     rdi, [rsp]
    call    g_key_file_set_value

.OverPHP:
    ;~ mov     rdi, [rgpKeys_TxtBoxes + KEY_BS]
    ;~ call    gtk_entry_get_text_length
    ;~ test    rax, rax
    ;~ jz      .OverBS
    
.SaveBSKey:
    mov     rdi, [rgpKeys_TxtBoxes + KEY_BS]
    call    gtk_entry_get_text

    mov     rcx, rax
    mov     rdx, szKeyBS
    mov     rsi, szGrpKeys
    mov     rdi, [rsp]
    call    g_key_file_set_value

.OverBS:
    ;~ mov     rdi, [rgpKeys_TxtBoxes + KEY_FSL]
    ;~ call    gtk_entry_get_text_length
    ;~ test    rax, rax
    ;~ jz      .OverFSL
    ;~ 
.SaveFSLKey:
    mov     rdi, [rgpKeys_TxtBoxes + KEY_FSL]
    call    gtk_entry_get_text

    mov     rcx, rax
    mov     rdx, szKeyFSL
    mov     rsi, szGrpKeys
    mov     rdi, [rsp]
    call    g_key_file_set_value

.OverFSL:
    ;~ mov     rdi, [rgpKeys_TxtBoxes + KEY_IPI]
    ;~ call    gtk_entry_get_text_length
    ;~ test    rax, rax
    ;~ jz      .OverIP
    
.SaveIPKey:
    mov     rdi, [rgpKeys_TxtBoxes + KEY_IPI]
    call    gtk_entry_get_text

    mov     rcx, rax
    mov     rdx, szKeyIP
    mov     rsi, szGrpKeys
    mov     rdi, [rsp]
    call    g_key_file_set_value

.OverIP:                
    mov     rdx, NULL
    lea     rsi, [rsp + 8]
    mov     rdi, [rsp]
    call    g_key_file_to_data
    mov     [rsp + 16], rax

    mov     rcx, NULL
    mov     rdx, [rsp + 8]
    mov     rsi, [rsp + 16]
    mov     rdi, szSettingsFile
    call    g_file_set_contents
    
    mov     rdi, [rsp + 16]
    call    g_free
    
    mov     rdi, [rsp]
    call    g_key_file_free
        
    add     rsp, 8 * 3
    ret

Clear_Query_Status_Imgs:
    sub     rsp, 8
    mov     rbx, INFO_STATUS_IMGS_ARR_LEN - 3
    mov     r13, rgpStatus_Imgs
.Next:

    mov     rdi, [r13 + 8 * rbx ]
    call    gtk_widget_hide
    dec     rbx
    jns     .Next 
    
    add     rsp, 8
    ret
        
Clear_Submit_Status_Imgs:
    sub     rsp, 8
    
    mov     rdi, [rgpStatus_Imgs + SFS_STATUS_S_IDX]
    call    gtk_image_clear

    mov     rdi, [rgpStatus_Imgs + BS_STATUS_S_IDX]
    call    gtk_image_clear

    add     rsp, 8
    ret
    
;~ #########################################
PreSubmit:
    push    r15
    sub     rsp, GTKTEXTITER_SIZE * 2
    
    call    StripInputs
    call    Clear_Submit_Status_Imgs

    
    ; make sure all three fields are filled in
.CheckIP:
    ; Do we have IP?
    mov     r15, [rgpInfo_TxtBoxes + TXT_INFO_IP_IDX]
    mov     rdi, [rgpInfo_TxtBoxes + TXT_INFO_IP_IDX]
    call    gtk_entry_get_text_length
    test    rax, rax
    jz      .EmptyField
    
.CheckName:
    ; Do we have a name?
    mov     r15, [rgpInfo_TxtBoxes + TXT_INFO_NAME_IDX]
    mov     rdi, [rgpInfo_TxtBoxes + TXT_INFO_NAME_IDX]
    call    gtk_entry_get_text_length
    test    rax, rax
    jz      .EmptyField
        
.CheckEmail:
    ; Do we have an email?
    mov     r15, [rgpInfo_TxtBoxes + TXT_INFO_EMAIL_IDX]
    mov     rdi, [rgpInfo_TxtBoxes + TXT_INFO_EMAIL_IDX]
    call    gtk_entry_get_text_length
    test    rax, rax
    jnz     .GetData
    
.EmptyField:
    ; A field was empty, inform user
    mov     rsi, szErrEmptyFieldsTitle
    mov     rdi, szFieldMissing
    call    ShowErrorDialog

.GrabFocus:
    ; and set focus to widget missing data
    mov     rdi, r15
    call    gtk_widget_grab_focus
    jmp     .Done
    
.InvalidIP:
    mov     rsi, szErrBadIPTitle
    mov     rdi, szErrBadIP
    call    ShowErrorDialog
    mov     r15, [rgpInfo_TxtBoxes + TXT_INFO_IP_IDX]
    jmp     .GrabFocus
    
.GetData:
    call    GetFields
    test    rax, rax
    js      .InvalidIP    
    
%define _IterStart  [rsp]
%define _IterEnd    [rsp + GTKTEXTITER_SIZE]  
  
    mov     rdi, [rgpInfo_TxtBoxes + TXT_INFO_EVDNCE_IDX]
    call    gtk_text_view_get_buffer
    mov     r15, rax 
        
    lea     rdx, _IterEnd
    lea     rsi, _IterStart
    mov     rdi, r15
    call    gtk_text_buffer_get_bounds

    mov     rcx, FALSE
    lea     rdx, _IterEnd
    lea     rsi, _IterStart
    mov     rdi, r15
    call    gtk_text_buffer_get_text

    mov     rdx, rax
    mov     rsi, SubmitServices
    mov     rdi, NULL
    call    g_thread_new

    mov     rdi, rax
    call    g_thread_unref
            
.Done:
    add     rsp, GTKTEXTITER_SIZE * 2
    pop     r15
    ret
    
;~ #########################################
PreQuery:
    sub     rsp, 8

    call    Clear_Query_Status_Imgs
    
    call    StripInputs
    call    GetFields
    test    rax, rax
    js      .InvalidIP
    jz      .NoInput

    mov     rdx, 0
    mov     rsi, QueryServices
    mov     rdi, NULL
    call    g_thread_new

    mov     rdi, rax
    call    g_thread_unref
        
    jmp     .Done
    
.InvalidIP:
    mov     rsi, szErrBadIPTitle
    mov     rdi, szErrBadIP
    call    ShowErrorDialog
    jmp     .GrabIPFocus
    
.NoInput:
    mov     rsi, szErrEmptyFieldsTitle
    mov     rdi, szErrEmptyFields
    call    ShowErrorDialog

.GrabIPFocus:
    mov     rdi, [rgpInfo_TxtBoxes + TXT_INFO_IP_IDX]
    call    gtk_widget_grab_focus
    
.Done:
    add     rsp, 8 
    ret

;~ #########################################
SubmitServices:
    push    r14
    push    r15
    sub     rsp, 8 * 3

    mov     [rsp], rdi
    
    mov     rdx, FALSE
    mov     rsi, NULL
    call    g_uri_escape_string
    mov     [rsp + 8], rax
    
    mov     rdi, [rsp]      
    call    g_free
    
.CheckSFS:
    test    qword [QueryOptions], OPT_SFS_SUBMIT
    jz      .CheckBS

    ; Do we have an API Key?
    mov     rdi, [rgpKeys_TxtBoxes + KEY_SFS]
    call    gtk_entry_get_text_length
    test    rax, rax
    jnz     .SFSGood

    mov     rsi, szImgBad
    mov     rdi, [rgpStatus_Imgs + SFS_STATUS_S_IDX]
    call    gtk_image_set_from_file
    
    mov     rdx, szSubmitSingle
    mov     rsi, szServSFS
    mov     rdi, szMissingAPIKey
    call    LogError
 
    jmp     .CheckBS
    
.SFSGood:    
    mov     rdi, [rsp + 8]
    call    SubmitStopFourmSpam

.CheckBS:
    test    qword [QueryOptions], OPT_BS_SUBMIT
    jz      .Done

    ; Do we have an API Key?
    mov     rdi, [rgpKeys_TxtBoxes + KEY_BS]
    call    gtk_entry_get_text_length
    test    rax, rax
    jnz     .BSGood

    mov     rsi, szImgBad
    mov     rdi, [rgpStatus_Imgs + BS_STATUS_S_IDX]
    call    gtk_image_set_from_file
    
    mov     rdx, szSubmitSingle
    mov     rsi, szServBotScout
    mov     rdi, szMissingAPIKey
    call    LogError
 
    jmp     .Done
    
.BSGood:
    call    SubmitBotScout
        
.Done:    

    mov     rdi, [rsp + 8]
    call    g_free
    
    mov     r14, pszSpammerInfo
    mov     r15, 3
.FreeSpammerInfo:
    mov     rdi, [r14 + 8 * r15]
    call    g_free
  
    mov     qword [r14 + 8 * r15], 0
    sub     r15, 1
    jns     .FreeSpammerInfo

    add     rsp, 8 * 3
    pop     r15
    pop     r14
    ret
    
;~ #########################################
QueryServices:
    push    r14
    push    r15
    sub     rsp, 8
       
    call    ClearInfoText

.CheckSFS:
    test    qword [QueryOptions], OPT_SFS
    jz      .CheckPHP
    call    QueryStopFourmSpam
    
.CheckPHP:
    test    qword [QueryOptions], OPT_PHP
    jz      .CheckBS 
    call    QueryProjectHoneyPot
    
;~ .CheckFSL:
    ;~ test    qword [QueryOptions], OPT_FSL
    ;~ jz      .CheckBS
    ;~ call    QueryFSpamlist
    
.CheckBS:
    test    qword [QueryOptions], OPT_BS
    jz      .CheckIPInfo
    call    QueryBotScout

.CheckIPInfo:
    test    qword [QueryOptions], OPT_IPINFO
    jz      .Done
    call    QueryIpInfo
    
.Done:    
    mov     r14, pszSpammerInfo
    mov     r15, 3
.FreeSpammerInfo:
    mov     rdi, [r14 + 8 * r15]
    call    g_free
  
    mov     qword [r14 + 8 * r15], 0
    sub     r15, 1
    jns     .FreeSpammerInfo

    add     rsp, 8
    pop     r15
    pop     r14
    ret

;~ #########################################
GetFields:
    push    r15
    push    r14
    push    r13
    push    r12
    sub     rsp, 8
    
    mov     r15, 0
    
    mov     rdi, [rgpInfo_TxtBoxes + TXT_INFO_IP_IDX]
    call    gtk_entry_get_text_length
    test    rax, rax
    jz      .GetName
    add     rax, 1
    mov     r13, rax

    mov     rdi, [rgpInfo_TxtBoxes + TXT_INFO_IP_IDX]
    call    gtk_entry_get_text
    mov     r12, rax

    lea     rdx, [rsp]
    mov     rsi, r12
    mov     rdi, 2
    call    inet_pton
    test    eax, eax
    jz      .InvalidIP
    js      .InvalidIP
    
    mov     rdi, r13
    call    g_malloc0
    mov     [pszSpammerInfo.IP], rax

    mov     rsi, r12
    mov     rdi, [pszSpammerInfo.IP]
    call    g_stpcpy

    mov     rdi, r13
    call    g_malloc0
    mov     [pszSpammerInfo.RevIP], rax

    lea     rsi, [rsp]
    mov     rdi, r12
    call    inet_aton
    mov     rax, [rsp]    
    bswap   eax
    
    mov     rdi, rax
    call    inet_ntoa

    mov     rsi, rax
    mov     rdi, [pszSpammerInfo.RevIP]
    call    g_stpcpy

    add     r15, 1
    jmp     .GetName
    
.InvalidIP:
    mov     rax, -1
    jmp     .DoneErr
    
.GetName:
    mov     rdi, [rgpInfo_TxtBoxes + TXT_INFO_NAME_IDX]
    call    gtk_entry_get_text_length
    test    rax, rax
    jz      .GetEmail
    
    mov     rdi, [rgpInfo_TxtBoxes + TXT_INFO_NAME_IDX]
    call    gtk_entry_get_text

    mov     rdx, FALSE
    mov     rsi, NULL
    mov     rdi, rax
    call    g_uri_escape_string
    mov     [pszSpammerInfo.Name], rax
    add     r15, 1
    
.GetEmail:
    mov     rdi, [rgpInfo_TxtBoxes + TXT_INFO_EMAIL_IDX]
    call    gtk_entry_get_text_length
    test    rax, rax
    jz      .Done

    mov     rdi, [rgpInfo_TxtBoxes + TXT_INFO_EMAIL_IDX]
    call    gtk_entry_get_text

    mov     rdx, FALSE
    mov     rsi, NULL
    mov     rdi, rax
    call    g_uri_escape_string
    mov     [pszSpammerInfo.Email], rax
    add     r15, 1
    
.Done:
    mov     rax, r15
.DoneErr:
    add     rsp, 8
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    ret
    
;~ #########################################
ShowErrorDialog:
    push    r15
    push    r14
    sub     rsp, 8 

    mov     [rsp], rsi
    
    mov     r8, rdi
    mov     rcx, GTK_BUTTONS_OK
    mov     rdx, GTK_MESSAGE_ERROR
    mov     rsi, GTK_DIALOG_DESTROY_WITH_PARENT
    mov     rdi, [oMain]
    call    gtk_message_dialog_new
    mov     r15, rax

    mov     rsi, [rsp]
    mov     rdi, rax
    call    gtk_window_set_title
     
    mov     rdi, r15
    call    gtk_dialog_run

    mov     rdi, r15
    call    gtk_widget_destroy
    
    add     rsp, 8
    pop     r14
    pop     r15
    ret

;~ #########################################
StripInputs:
    sub     rsp, 8

    ;~ IP
    mov     rdi, [rgpInfo_TxtBoxes + TXT_INFO_IP_IDX]
    call    gtk_entry_get_text 

    mov     rdi, rax
    call    g_strdup
    mov     [rsp], rax
    
    mov     rdi, [rsp]
    call    g_strchug

    mov     rdi, [rsp]
    call    g_strchomp

    mov     rsi, [rsp]
    mov     rdi, [rgpInfo_TxtBoxes + TXT_INFO_IP_IDX]
    call    gtk_entry_set_text

    mov     rdi, [rsp]
    call    g_free

    ;~ Name
    mov     rdi, [rgpInfo_TxtBoxes + TXT_INFO_NAME_IDX]
    call    gtk_entry_get_text 

    mov     rdi, rax
    call    g_strdup
    mov     [rsp], rax
    
    mov     rdi, [rsp]
    call    g_strchug

    mov     rdi, [rsp]
    call    g_strchomp

    mov     rsi, [rsp]
    mov     rdi, [rgpInfo_TxtBoxes + TXT_INFO_NAME_IDX]
    call    gtk_entry_set_text 
    
    mov     rdi, [rsp]
    call    g_free
    
    ;~ Email
    mov     rdi, [rgpInfo_TxtBoxes + TXT_INFO_EMAIL_IDX]
    call    gtk_entry_get_text 

    mov     rdi, rax
    call    g_strdup
    mov     [rsp], rax
    
    mov     rdi, [rsp]
    call    g_strchug
 
    mov     rdi, [rsp]
    call    g_strchomp
    
    mov     rsi, [rsp]
    mov     rdi, [rgpInfo_TxtBoxes + TXT_INFO_EMAIL_IDX]
    call    gtk_entry_set_text

    mov     rdi, [rsp]
    call    g_free

    add     rsp, 8
    ret

;~ size_t function( char *contents, 
                    ;~ size_t size, 
                    ;~ size_t nmemb, 
                    ;~ void *userdata);;
;~ #########################################
;~ http://curl.haxx.se/libcurl/c/getinmemory.html
ReceiveQuery:
    push    r15                             ; *userdata
    push    r14                             ; realsize
    push    r13                             ; *contents
    push    rbx
    sub     rsp, 8

    mov     r13, rdi

    ; size_t realsize = size * nmemb;
    mov     rax, rsi
    mov     rbx, rdx
    mul     rbx
    mov     r14, rax

    ;~ ; struct MemoryStruct *mem = (struct MemoryStruct *)userp;
    mov     r15, rcx
 
    ;~ ;;~ mem->memory = realloc(mem->memory, mem->size + realsize + 1);
    mov     rsi, [r15 + 8]
    add     rsi, r14
    add     rsi, 1
    mov     rdi, [r15]
    call    g_realloc
    ;~ ;;~ ; should really test for failure here
    mov     [r15], rax

    ; memcpy(&(mem->memory[mem->size]), contents, realsize);
    mov     rdx, r14
    mov     rsi, r13
    mov     rdi, [r15]
    call    memcpy

    ; mem->size += realsize;
    add     [r15 + 8], r14
    
    ; mem->memory[mem->size] = 0;
    mov     rcx, [r15]
    lea     rcx, [rcx]
    mov     byte [rcx + r14 ], 0


    ; return realsize;
    mov     rax, r14
.Done:
    add     rsp, 8
    pop     rbx
    pop     r13
    pop     r14
    pop     r15
    ret


;~ #########################################
;~ Input:
    ;~ rdi = Query URL
    ;~ rsi = cllback function
    ;~ rdx = buffer for data
    ;~ rcx = URL size
SendQuery:
    push    r15
    push    r14
    push    r13
    push    r12
    sub     rsp, 8
    
    mov     r15, rdi
    mov     r14, rsi
    mov     r13, rdx
    mov     r12, rcx
    
    mov     rdx, rdi
    mov     rsi, CURLOPT_URL
    mov     rdi, [curl_handle]
    call    curl_easy_setopt

    test    r12, r12
    jz      .Over
    
    mov     rsi, r15
    mov     rdi, r12
    call    g_slice_free1

.Over:    
    mov     rdx, szUserAgent 
    mov     rsi, CURLOPT_USERAGENT
    mov     rdi, [curl_handle]
    call    curl_easy_setopt

    mov     rdx, r13
    mov     rsi, CURLOPT_WRITEDATA
    mov     rdi, [curl_handle] 
    call    curl_easy_setopt
    
    mov     rdx, CurlErr
    mov     rsi, CURLOPT_ERRORBUFFER
    mov     rdi, [curl_handle]
    call    curl_easy_setopt
    
    mov     rdx, r14
    mov     rsi, CURLOPT_WRITEFUNCTION
    mov     rdi, [curl_handle] 
    call    curl_easy_setopt

    mov     rdi, [curl_handle]
    call    curl_easy_perform
   
    add     rsp, 8
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    ret

;~ #########################################
;~ gboolean
;~ user_function (GtkWidget *widget,
               ;~ GdkEvent  *event,
               ;~ gpointer   user_data)
TextEntryFocusOut:
    sub rsp, 8

    mov     rsi, -1
    call    gtk_editable_set_position
    mov     rax, FALSE
    add     rsp, 8
    ret

;~ #########################################
;~ rsi = text to display
;~ rdi = label widget    
SetLabelTextBold:
    push    r15
    push    r14
    sub     rsp, 8

    mov     r14, rdi
    
    mov     rcx, szBoldClose
    mov     rdx, rsi
    mov     rsi, szBoldOpen
    mov     rdi, szLabelBoldFormat
    mov     rax, 0
    call    g_strdup_printf
    mov     r15, rax

    mov     rsi, rax
    mov     rdi, r14
    call    gtk_label_set_markup

    mov     rdi, r15
    call    g_free
    
    add     rsp, 8
    pop     r14
    pop     r15
    ret

;~ #########################################
;~ rdx = y
;~ rsi = x
;~ rdi = TRUE or FALSE
ShowSubmitSpinner:
    sub     rsp, 8
    
    test    rdi, rdi
    jz      .Hide

.Show:
    mov     rcx, rdx
    mov     rdx, rsi
    mov     rsi, [oSubmitSpinner]
    mov     rdi, [oInfo_Fixed]
    call    gtk_fixed_move

    mov     rsi, TRUE
    mov     rdi, [oSubmitSpinner]
    call    gtk_widget_set_sensitive
    
    mov     rdi, [oSubmitSpinner]
    call    gtk_spinner_start
    
    mov     rdi, [oSubmitSpinner]
    call    gtk_widget_show
       
    jmp     .Done
    
.Hide:
    mov     rdi, [oSubmitSpinner]
    call    gtk_spinner_stop 
    
    mov     rdi, [oSubmitSpinner]
    call    gtk_widget_hide

.Done:
    add     rsp, 8
    ret
    
;~ #########################################
;~ r9 = TRUE or FALSE
;~ rcx = y
;~ rdx = x
;~ rsi = widget
;~ rdi = parent
ShowSpinner:
    push    r15
    push    r14
    push    r13
    push    r12
    sub     rsp, 8

    mov     r15, rdi
    mov     r14, rsi
    mov     r13, rdx
    mov     r12, rcx
 
    test    r9, r9
    jz      .Hide

.SetParent: 
    mov     rdi, r14
    call    gtk_widget_get_parent
    cmp     rax, r15
    je      .Show
    ;~ 
    mov     rsi, r15
    mov     rdi, r14
    call    gtk_widget_reparent
;~ 
    mov     rcx, r12
    mov     rdx, r13
    mov     rsi, r14
    mov     rdi, r15
    call    gtk_fixed_move

.Show:
    mov     rsi, TRUE
    mov     rdi, r14
    call    gtk_widget_set_sensitive
    
    mov     rdi, r14
    call    gtk_spinner_start
    
    mov     rdi, r14
    call    gtk_widget_show
       
    jmp     .Done

.Hide:
    mov     rdi, r14
    call    gtk_spinner_stop 
    
    mov     rdi, r14
    call    gtk_widget_hide
    
.Done:

    add     rsp, 8
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    ret

;~ #########################################
ClearInfoText:
    push    r15

    mov     r15, INFO_LABELS_ARRAY_LEN 
.NextLabel:
    mov     rsi, szPHP_Type_Array.0
    mov     rdi, [rgpSFS_Labels + 8 * r15]
    call    gtk_label_set_text
    sub     r15, 1
    jns     .NextLabel
    
    mov     rdi, [rgpIPInfo_Labels + 8 * IPIDB_FLAG_IDX]
    call    gtk_image_clear
    
    pop     r15
    ret

PrintDec:
    sub     rsp, 8

    mov     rdi, fmtint
    mov     rax, 0
    call    printf
    
    add     rsp, 8
    ret

PrintString:
    sub     rsp, 8

    mov     rdi, fmtstr
    mov     rax, 0
    call    printf
    
    add     rsp, 8
    ret

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
LogError:
    push    r15
    push    r14
    push    r13
    push    r12
    sub     rsp, 56 + GTKTEXTITER_SIZE
    
%define _IterEnd    [rsp + 56]

    mov     r15, rdi
    mov     r14, rsi
    mov     r13, rdx

    mov     rdi, [oErrLog]
    call    gtk_text_view_get_buffer
    mov     r12, rax   
    
    lea     rsi, _IterEnd
    mov     rdi, rax
    call    gtk_text_buffer_get_end_iter
    
    mov     r9, NULL
    mov     r8, szTagName
    mov     rcx, -1
    mov     rdx, r14
    lea     rsi, _IterEnd
    mov     rdi, r12
    call    gtk_text_buffer_insert_with_tags_by_name
        
    sub     rsp, 40
    mov     qword [rsp + 32], fmttimedateLog
    call    GetDateTime
    
    push    szLFx2  
    mov     r9, r15
    mov     r8, szLF
    lea     rcx, [rsp + 8]
    mov     rdx, szLF
    mov     rsi, r13
    mov     rdi, fmtstr6
    mov     rax, 0
    call    g_strdup_printf
    mov     r15, rax
    add     rsp, 48 

    lea     rsi, _IterEnd
    mov     rdi, r12
    call    gtk_text_buffer_get_end_iter
    
    mov     rcx, -1
    mov     rdx, r15
    lea     rsi, _IterEnd
    mov     rdi, r12
    call    gtk_text_buffer_insert

    mov     rdi, r15
    call    g_free
    
    add     rsp, 56 + GTKTEXTITER_SIZE
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    ret

;~ #########################################
;~ strlen = find length of NUL terminated string
;~ in      rdi = address of string
;~ out     rax = length of string not including NUL
;~ #########################################
StrLen:
    mov     rcx, 0

.Next:
    cmp     byte [rdi + rcx], 0
    je      .Done
    inc     rcx
    jmp     .Next

.Done:
    mov     rax, rcx
    ret
    
;~ StrLen:
	;~ push	rdi
	;~ xor	    rcx, rcx
	;~ not	    rcx
	;~ xor     rax, rax
	;~ cld
    ;~ repne	scasb
	;~ not	    rcx
	;~ pop	    rdi
	;~ lea	    rax, [rcx-1]
	;~ ret

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ClearLog:
    sub     rsp, 8

    mov     rdi, [oErrLog]
    call    gtk_text_view_get_buffer 
        
    mov     rdx, -1
    mov     rsi, szEmpty
    mov     rdi, rax
    call    gtk_text_buffer_set_text
    
    call    ErrLog_Set_Modified
    
    mov     rdi, FALSE
    call    Enable_Log_Buttons

    call    Clear_Submit_Status_Imgs    
    call    Clear_Query_Status_Imgs
    
    add     rsp, 8
    ret

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Enable_Log_Buttons:
    sub     rsp, 8 

    push    rdi
    
    mov     rsi, rdi
    mov     rdi, [rgpLog_Buttons + BTN_LOG_SAVE_IDX]
    call    gtk_widget_set_sensitive
    
    pop     rsi
    mov     rdi, [rgpLog_Buttons + BTN_LOG_CLEAR_IDX]
    call    gtk_widget_set_sensitive
        
    add     rsp, 8 
    ret

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~    
ErrLog_Get_Modified:
    sub     rsp, 8
    
    mov     rdi, [oErrLog]
    call    gtk_text_view_get_buffer
        
    mov     rdi, rax
    call    gtk_text_buffer_get_modified

    add     rsp, 8
    ret

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ErrLog_Set_Modified:
    sub     rsp, 8
    
    mov     rdi, [oErrLog]
    call    gtk_text_view_get_buffer

    mov     rsi, FALSE
    mov     rdi, rax
    call    gtk_text_buffer_set_modified
        
    add     rsp, 8
    ret

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SaveLog:
    push    r15
    push    r14
    push    r13
    
    push    NULL
    push    GTK_RESPONSE_ACCEPT    
    mov     r9, szSave
    mov     r8, GTK_RESPONSE_CANCEL
    mov     rcx, szCancel
    mov     rdx, GTK_FILE_CHOOSER_ACTION_SAVE
    mov     rsi, [oMain]
    mov     rdi, szSaveLog
    call    gtk_file_chooser_dialog_new
    mov     r15, rax
    add     rsp, 8 * 2
   
    mov     rsi, TRUE
    mov     rdi, rax
    call    gtk_file_chooser_set_do_overwrite_confirmation
    
    sub     rsp, 40
    mov     qword [rsp + 32], fmtTimeDateName
    call    GetDateTime
    
    lea     rsi, [rsp]
    mov     rdi, r15
    call    gtk_file_chooser_set_current_name
    add     rsp, 40
    
    mov     rdi, szClearLogAfterSave
    call    gtk_check_button_new_with_label
    
    mov     rsi, rax
    mov     rdi, r15
    call    gtk_file_chooser_set_extra_widget

.RunDialog:    
    mov     rdi, r15
    call    gtk_dialog_run    
    cmp     al, GTK_RESPONSE_ACCEPT
    jne     .Done   

    mov     rdi, r15
    call    gtk_file_chooser_get_filename
    mov     r14, rax

    mov     rdi, r15
    call    gtk_file_chooser_get_extra_widget

    mov     rdi, rax
    call    gtk_toggle_button_get_active
    mov     r13, rax

    mov     rdi, r15
    call    gtk_widget_destroy

    sub     rsp, GTKTEXTITER_SIZE * 2  

%define _IterStart  [rsp]
%define _IterEnd    [rsp + GTKTEXTITER_SIZE]  

    mov     rdi, [oErrLog]
    call    gtk_text_view_get_buffer
    mov     r15, rax   

    lea     rdx, _IterEnd
    lea     rsi, _IterStart
    mov     rdi, rax
    call    gtk_text_buffer_get_bounds
 
    mov     rcx, FALSE
    lea     rdx, _IterEnd
    lea     rsi, _IterStart
    mov     rdi, r15
    call    gtk_text_buffer_get_text
    mov     r15, rax

    mov     rcx, NULL
    mov     rdx, -1
    mov     rsi, rax
    mov     rdi, r14
    call    g_file_set_contents

    mov     rdi, r14
    call    g_free
    
    mov     rdi, r15
    call    g_free   
         
    test    r13, r13
    jz      .OverClear
    
    call    ClearLog

.OverClear:
    add     rsp, GTKTEXTITER_SIZE * 2   
    jmp     .Done2
     
.Done:    
    mov     rdi, r15
    call    gtk_widget_destroy

.Done2:        
    pop     r13
    pop     r14
    pop     r15
    ret

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SetAboutColor:
    sub     rsp, 8 

%define _Provider   [rsp]

    call    gtk_css_provider_new
    mov     _Provider, rax
    
    call    gdk_display_get_default
    
    mov     rdi, rax
    call    gdk_display_get_default_screen
    
    mov     rdx, GTK_STYLE_PROVIDER_PRIORITY_APPLICATION
    mov     rsi, _Provider
    mov     rdi, rax
    call    gtk_style_context_add_provider_for_screen
    
    mov     rcx, NULL
    mov     rdx, -1
    mov     rsi, szAboutCSS
    mov     rdi, _Provider
    call    gtk_css_provider_load_from_data
    
    mov     rdi, _Provider
    call    g_object_unref

    add     rsp, 8
    ret

GetDateTime:
    sub     rsp, 8 * 2

%define _Buffer [rsp + 24]
%define _fmt    [rsp + 56]

    lea     rdi, [rsp]
    call    time

    lea     rdi, [rsp]
    call    localtime

    mov     rcx, rax
    mov     rdx, _fmt  
    mov     rsi, 32
    lea     rdi, _Buffer
    call    strftime    
    
    add     rsp, 8 * 2
    ret

;~ SetSubmitStatusIcon:
    ;~ sub     rsp, 8
;~ 
    ;~ call    gtk_image_set_from_file
    ;~ 
    ;~ add     rsp, 8
    ;~ ret
