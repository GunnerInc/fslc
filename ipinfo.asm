section .text
QueryIpInfo: 
    push    r15
    push    r14
    push    r13
    push    r12
    sub     rsp, 8

.CheckForKey:
    ; Do we have an API Key?
    mov     rdi, [rgpKeys_TxtBoxes + KEY_IPI]
    call    gtk_entry_get_text_length
    test    rax, rax
    jnz     .CheckForIP

    ; No, Display "Missing Api Key"
    mov     rsi, szErrAPIKeyMissing
    mov     rdi, [rgpIPInfo_Labels + IPIDB_REGION_IDX]
    call    SetLabelTextBold    
    jmp     .Done1

.CheckForIP:
    ; Did user enter IP Address?
    mov     rax, [pszSpammerInfo.IP]
    test    rax, rax
    jnz     .PreCheckGood

    ; No, Display "No IP Entered"
    mov     rsi, szErrIPMissing
    mov     rdi, [rgpIPInfo_Labels + IPIDB_REGION_IDX]
    call    SetLabelTextBold    
    jmp     .Done1
    
.PreCheckGood:
    mov     r9, TRUE
    mov     rcx, SPINNER_IP_Y
    mov     rdx, SPINNER_IP_X
    mov     rsi, [oSFS_Spinner]
    mov     rdi, [rgpInfo_Fixed + FXD_IP]
    call    ShowSpinner

    ; We have an API key and IP entered
    ; Create URL for query
    ; http://api.ipinfodb.com/v3/ip-city/?key=<your_api_key>&ip=74.125.45.100

    mov     r15, IP_URL_LEN

    mov     rdi, [rgpKeys_TxtBoxes + KEY_IPI]
    call    gtk_entry_get_text_length
    add     r15, rax

    mov     rdi, [pszSpammerInfo.IP]
    call    strlen
    add     r15, rax
    add     r15, 1
    
    mov     rdi, r15
    call    g_slice_alloc0
    mov     r14, rax

.CreateURL:
    mov     rsi, szIPInfoURL                ; http://api.ipinfodb.com/v3/ip-city/?key=
    mov     rdi, r14
    call    g_stpcpy
    mov     r13, rax

    mov     rdi, [rgpKeys_TxtBoxes + KEY_IPI]
    call    gtk_entry_get_text
        
    mov     rsi, rax                        
    mov     rdi, r13
    call    g_stpcpy
                
    mov     rsi, szIPInfoIPField                        
    mov     rdi, rax
    call    g_stpcpy

    mov     rsi, [pszSpammerInfo.IP]                        
    mov     rdi, rax
    call    g_stpcpy

.Query:
    sub     rsp, 8 * 2

    mov     rdi, 1
    call    g_malloc    
    ;;~ chunk.memory = malloc(1);
    mov     [rsp], rax
    ;;~ chunk.size = 0;
    mov     qword [rsp + 8], 0
    
    mov     rdi, r14
    mov     rsi, ReceiveQuery
    mov     rdx, rsp
    mov     rcx, r15
    call    SendQuery
    push    rax

    mov     r9, FALSE
    mov     rsi, [oSFS_Spinner]
    mov     rdi, [rgpInfo_Fixed + FXD_IP]
    call    ShowSpinner
    
    pop     rax
    test    rax, rax
    jz      .Ok
    
    mov     rdi, CurlErr
    jmp     .QueryError
    
.Ok:
    mov     r14, [rsp]

    mov     rdi, r14
    call    ToLower
      
    mov     ax, word [r14]
    cmp     ax, "ok"
    je      .ParseReply
    
    mov     rdi, [rsp]
    jmp     .QueryError

.ParseReply:
    ; split reply into an array of 11 null terminated strings
    mov     rdx, -1
    mov     rsi, szSemiColon
    mov     rdi, r14
    call    g_strsplit
    mov     r14, rax

    mov     r15, IP_REPLY_TIME_ZONE
    mov     r13, IPIDB_LAT_IDX
    mov     r12, rgpIPInfo_Labels
.SetIPLabels:
    mov     rsi, [r14 + 8 * r15]
    mov     rdi, [r12 + 8 * r13]
    call    gtk_label_set_text
    sub     r15, 1
    sub     r13, 1
    jns     .SetIPLabels

    test    qword [QueryOptions], OPT_SHOW_FLAG
    jz      .OverFlag
    
    mov     rdi, [rgpIPInfo_Labels + 8 * IPIDB_FLAG_IDX]
    call    gtk_widget_hide

    mov     rcx, SPINNER_FLAG_Y
    mov     rdx, SPINNER_FLAG_X
    mov     rsi, [oSFS_Spinner]
    mov     rdi, [rgpInfo_Fixed + FXD_IP]
    call    gtk_fixed_move

    mov     rsi, TRUE
    mov     rdi, [oSFS_Spinner]
    call    gtk_widget_set_sensitive
    
    mov     rdi, [oSFS_Spinner]
    call    gtk_spinner_start
    
    mov     rdi, [oSFS_Spinner]
    call    gtk_widget_show
                
    mov     rdi, [r14 + 8 * IP_REPLY_COUNTRY_CODE]
    call    GetCountryFlag

    mov     r9, FALSE
    mov     rsi, [oSFS_Spinner]
    mov     rdi, [rgpInfo_Fixed + FXD_IP]
    call    ShowSpinner
       
    mov     rdi, [rgpIPInfo_Labels + 8 * IPIDB_FLAG_IDX]
    call    gtk_widget_show

.OverFlag:              
    mov     rdi, r14
    call    g_strfreev
    
    jmp     .Done
    
.QueryError:
    mov     rdx, szQuerySingle
    mov     rsi, szServIP
    call    LogError
    
    mov     rdi, [rgpStatus_Imgs + IP_STATUS_Q_IDX]
    call    gtk_widget_show

.Done:
    mov     rdi, [rsp]
    call    g_free

    add     rsp, 8 * 2

.Done1:
    add     rsp, 8
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    ret

; rdi = country code
GetCountryFlag:
    push    r15
    push    r14
    push    r13
    push    r12
    sub     rsp, 8 * 3

    mov     r13, rdi
    
    ; does our flags dircetory exist?
    mov     rsi, G_FILE_TEST_EXISTS
    mov     rdi, szFlagsDir
    call    g_file_test
    test    rax, rax
    jnz     .CheckForFile

    ; not there, create it.
    mov     rsi, S_IRWXU
    mov     rdi, szFlagsDir
    call    mkdir

.CheckForFile:
    mov     rcx, szPngExt
    mov     rdx, r13
    cmp     byte [r13], '-'
    jne     .NotReserved
    mov     rdx, szReserved
.NotReserved:
    mov     rsi, szFlagsDir
    mov     rdi, fmtstr3
    mov     rax, 0
    call    g_strdup_printf
    mov     [rsp], rax
       
    mov     rsi, G_FILE_TEST_EXISTS
    mov     rdi, [rsp]
    call    g_file_test
    test    rax, rax
    jnz     .DisplayFlag

.DownloadFlag:   
    mov     r15, FLAGS_URL_LEN
    add     r15, 1

    mov     rdi, r15
    call    g_slice_alloc0
    mov     r14, rax

    mov     rsi, szHomeURL                   ; http://www.gunnerinc.com/
    mov     rdi, r14
    call    g_stpcpy
    
    mov     rsi, szFlagsFolder              ; images/flags/
    mov     rdi, rax
    call    g_stpcpy
    
    cmp     byte [r13], '-'
    je      .Reserved

    mov     rsi, r13             
    mov     rdi, rax
    call    g_stpcpy
    
    jmp     .Continue

.Reserved:
    mov     rsi, szReserved             
    mov     rdi, rax
    call    g_stpcpy
    
.Continue:
    mov     rsi, szPngExt             
    mov     rdi, rax
    call    g_stpcpy
        
    mov     rdx, r14
    mov     rsi, CURLOPT_URL
    mov     rdi, [curl_handle]
    call    curl_easy_setopt
    
    mov     rsi, r14
    mov     rdi, r15
    call    g_slice_free1
    
    mov     rdx, szUserAgent 
    mov     rsi, CURLOPT_USERAGENT
    mov     rdi, [curl_handle]
    call    curl_easy_setopt
    
    mov     rsi, mode
    mov     rdi, [rsp]
    call    fopen 
    mov     r15, rax
    
    mov     rdx, rax
    mov     rsi, CURLOPT_WRITEDATA
    mov     rdi, [curl_handle]
    call    curl_easy_setopt
    
    mov     rdx, NULL
    mov     rsi, CURLOPT_WRITEFUNCTION
    mov     rdi, [curl_handle]
    call    curl_easy_setopt
    
    mov     rdi, [curl_handle]
    call    curl_easy_perform
    
    lea     rdx, [rsp + 8]
    mov     rsi, CURLINFO_RESPONSE_CODE
    mov     rdi, [curl_handle]
    call    curl_easy_getinfo

    mov     rdi, r15
    call    fclose
        
    cmp     qword [rsp + 8], HTTP_NOT_FOUND
    jne     .DisplayFlag
    
    mov     rsi, r13
    call    PrintString
    mov     rdi, [rsp]
    call    unlink

    mov     byte [r13], '-'
    jmp     .CheckForFile
  
.DisplayFlag:
    mov     rsi, [rsp]
    mov     rdi, [rgpIPInfo_Labels + 8 * IPIDB_FLAG_IDX]
    call    gtk_image_set_from_file

    mov     rdi, [rsp]
    call    g_free
    
.Done:
    add     rsp, 8 * 3
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    ret
