section .text
QueryProjectHoneyPot:
    push    r15
    push    r14
    push    r13
    push    r12
    sub     rsp, 8

.CheckForKey:
    ; Do we have an API Key?
    mov     rdi, [rgpKeys_TxtBoxes + KEY_PHP]
    call    gtk_entry_get_text_length
    test    rax, rax
    jnz     .CheckForIP

    ; No, Display "Missing Api Key"
    mov     rdx, szQuerySingle
    mov     rsi, szServPHP
    mov     rdi, szErrAPIKeyMissing
    call    LogError

    mov     rdi, [rgpStatus_Imgs + PHP_STATUS_Q_IDX]
    call    gtk_widget_show
    jmp     .Done1

.CheckForIP:
    ; Did user enter IP Address?
    mov     rax, [pszSpammerInfo.IP]
    test    rax, rax
    jnz     .PreCheckGood

    ; No, Display "No IP Entered"
    mov     rdx, szQuerySingle
    mov     rsi, szServPHP
    mov     rdi, szErrIPMissing
    call    LogError

    mov     rdi, [rgpStatus_Imgs + PHP_STATUS_Q_IDX]
    call    gtk_widget_show 
    jmp     .Done1
    
.PreCheckGood:
    mov     r9, TRUE
    mov     rcx, SPINNER_PHP_Y
    mov     rdx, SPINNER_PHP_X
    mov     rsi, [oSFS_Spinner]
    mov     rdi, [rgpInfo_Fixed + FXD_PHP]
    call    ShowSpinner

    ; We have an API key and IP entered
    ; Create dns query
    ; abcdefghijkl.2.1.9.127.dnsbl.httpbl.org
    ; [Access Key] [Octet-Reversed IP] [List-Specific Domain]
    
    ; Get API Key
    mov     rdi, [rgpKeys_TxtBoxes + KEY_PHP]
    call    gtk_entry_get_text

    mov     r8, szPHPQueryDNS
    mov     rcx, [pszSpammerInfo.RevIP] 
    mov     rdx, szDot
    mov     rsi, rax
    mov     rdi, fmtstr4
    mov     rax, 0
    call    g_strdup_printf
    mov     r15, rax

    ;~ Should figure out getaddrinfo and use it here!!!!
    mov     rdi, rax
    call    gethostbyname
    push    rax
    call    __h_errno_location
    mov     r13, rax
    sub     rsp, 8

    mov     rdi, r15
    call    g_free

    add     rsp, 8
    pop     rax
    test    rax, rax
    jnz     .ParseIt

    cmp     qword[r13], HOST_NOT_FOUND
    jne     .Bad
    mov     rsi, szErrIPNotFound
    mov     rdi, [rgpPHP_Labels + PHP_TYPE_IDX]
    call    SetLabelTextBold
    jmp     .Done

.Bad:
    mov     rdi, [r13]
    call    hstrerror
    
    mov     rdx, szQuerySingle
    mov     rsi, szServPHP
    mov     rdi, rax
    call    LogError

    mov     rdi, [rgpStatus_Imgs + PHP_STATUS_Q_IDX]
    call    gtk_widget_show
    jmp     .Done
.ParseIt:    
    mov     rdi, [rax + 8 * 3]
    mov     rdi, [rdi]
    mov     rdi, [rdi]
    call    inet_ntoa

    ; split reply into an array[4] of null terminated strings
    mov     rdx, -1
    mov     rsi, szDot
    mov     rdi, rax
    call    g_strsplit
    mov     r14, rax

    ; Check 1st octect and if not 127, bad reply
    mov     rdi, [r14 + PHP_REPLY_1ST_OCTET]
    call    atoi
    cmp     rax, 127
    jne     .ReplyError

    ; 4th octect = type
    ; 0 = search engine
    ; 1-7 spammer
    mov     rdi, [r14 + PHP_REPLY_4TH_OCTET]
    call    atoi
    test    rax, rax
    jnz     .NotSearchEngine

    mov     rdi, [r14 + PHP_REPLY_3RD_OCTET]
    call    atoi
    mov     rdx, [rgpszSearchEngines + 8 * rax]
    mov     rsi, szSearchEngine
    mov     rdi, fmtstr2
    mov     rax, 0
    call    g_strdup_printf
    mov     r15, rax

    mov     rsi, rax
    mov     rdi, [rgpPHP_Labels + PHP_TYPE_IDX]
    call    SetPHPLabelMarkup

    mov     rdi, r15
    call    g_free
    jmp     .Done2
    
.NotSearchEngine:
    mov     rdi, [r14 + PHP_REPLY_4TH_OCTET]
    call    atoi
    cmp     rax, 8
    jl      .ValidType

    ; reserved for future use
    mov     rsi, szPHP_Type_Array.8
    mov     rdi, [rgpPHP_Labels + PHP_TYPE_IDX]
    call    gtk_label_set_text
    jmp     .Done2
    
.ValidType:
    mov     rsi, [rgpszPHP_Types + 8 * rax]
    mov     rdi, [rgpPHP_Labels + PHP_TYPE_IDX]
    call    SetPHPLabelMarkup 

    mov     rsi, [r14 + PHP_REPLY_2ND_OCTET]
    mov     rdi, szDays
    mov     rax, 0
    call    g_strdup_printf
    mov     r15, rax

    mov     rsi, rax
    mov     rdi, [rgpPHP_Labels + PHP_SEEN_IDX]
    call    gtk_label_set_text

    mov     rdi, r15
    call    g_free
    
    mov     rsi, [r14 + PHP_REPLY_3RD_OCTET]
    mov     rdi, [rgpPHP_Labels + PHP_THREAT_IDX]
    call    gtk_label_set_text
    jmp     .Done2
       
.ReplyError:
    mov     rdx, szQuerySingle
    mov     rsi, szServPHP
    mov     rdi, szErrPHPReply
    call    LogError

    mov     rdi, [rgpStatus_Imgs + PHP_STATUS_Q_IDX]
    call    gtk_widget_show 

.Done2:
    mov     rdi, r14
    call    g_strfreev
    
.Done:
    mov     r9, FALSE
    mov     rsi, [oSFS_Spinner]
    mov     rdi, [rgpInfo_Fixed + FXD_PHP]
    call    ShowSpinner

.Done1:
    add     rsp, 8
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    ret

;~ rsi = Label Text
;~ rdi = label widget
SetPHPLabelMarkup:
    push    r15
    push    r14
    sub     rsp, 8

    mov     r14, rdi

    sub     rsp, 8
    push    szAHrefEnd
    mov     r9, rsi
    mov     r8, szURLEnd 
    mov     rcx, [pszSpammerInfo.IP]
    mov     rdx, szPHPSearchURL
    mov     rsi, szAHrefStart
    mov     rdi, fmtstr6
    mov     rax, 0
    call    g_strdup_printf
    mov     r15, rax
    add     rsp, 8 * 2

    mov     rsi, rax
    mov     rdi, r14
    call    gtk_label_set_markup

    mov     rdi, r15
    call    g_free

.Done:
    add     rsp, 8
    pop     r14
    pop     r15
    ret
