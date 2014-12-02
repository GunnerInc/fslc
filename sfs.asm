section .text

ClearSFSLabelMarkup:
    sub     rsp, 8

    mov     rsi, szIPText
    mov     rdi, [oSFSIP]
    call    gtk_label_set_text
    
    mov     rsi, szNameText
    mov     rdi, [oSFSName]
    call    gtk_label_set_text

    mov     rsi, szEmailText
    mov     rdi, [oSFSEmail]
    call    gtk_label_set_text

.Done:
    add     rsp, 8
    ret
;~ rcx = Label Text
;~ rdx = search item
;~ rsi = folder
;~ rdi = label widget
SetSFSLabelMarkup:
    push    r15
    push    r14
    sub     rsp, 8

    mov     r14, rdi
    
    push    szAHrefEnd
    push    rcx ;szIPText
    mov     r9, szURLEnd
    mov     r8, rdx ;[pszSpammerInfo.Name]
    mov     rcx, rsi ;szSFSSearch
    mov     rdx, szSFSURL
    mov     rsi, szAHrefStart
    mov     rdi, szSFSURLFormat
    mov     rax, 0
    call    g_strdup_printf
    mov     r15, rax
    add     rsp, 8 * 2

    ;~ mov     rsi, rax
    ;~ call    PrintString
    ;~ 
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
    
;~ #########################################
QueryStopFourmSpam:
    ;sub     rsp, 8
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbx
    sub     rsp, 8 * 2
    
    mov     r15, SFS_URL_LEN

    call    ClearSFSLabelMarkup

    mov     r9, TRUE
    mov     rcx, SPINNER_SFS_Y
    mov     rdx, SPINNER_SFS_X
    mov     rsi, [oSFS_Spinner]
    mov     rdi, [rgpInfo_Fixed + FXD_SFS]
    call    ShowSpinner
    
.IPLen:
    mov     rdi, [pszSpammerInfo.IP]
    test    rdi, rdi
    jz      .NameLen
    call    strlen
    add     r15, rax

.NameLen:
    mov     rdi, [pszSpammerInfo.Name]
    test    rdi, rdi
    jz      .EmailLen   
    call    strlen
    add     r15, rax

.EmailLen:
    mov     rdi, [pszSpammerInfo.Email]
    test    rdi, rdi
    jz      .Alloc
    call    strlen
    add     r15, rax
    
.Alloc:
    add     r15, 1
    
    mov     rdi, r15
    call    g_slice_alloc0
    mov     r14, rax

.CreateURL:
    mov     rsi, szSFSURL                   ; http://stopforumspam.com
    mov     rdi, r14
    call    g_stpcpy
    
    mov     rsi, szSFSQueryAPI              ; /api?
    mov     rdi, rax
    call    g_stpcpy

    
.IP_Param1:
    cmp     qword [pszSpammerInfo.IP], 0
    je      .Name_Param1

    mov     rsi, szSFSQueryIPField          ; ip=
    mov     rdi, rax
    call    g_stpcpy
    
    mov     rsi, [pszSpammerInfo.IP]
    mov     rdi, rax
    call    g_stpcpy

.CheckForNameParam:
    cmp     qword [pszSpammerInfo.Name], 0
    je      .CheckForEmailParam

.NameParam:
    mov     rsi, szAmp                      ; &
    mov     rdi, rax
    call    g_stpcpy
    
    mov     rsi, szSFSQueryNameField        ; name=
    mov     rdi, rax
    call    g_stpcpy

    mov     rsi, [pszSpammerInfo.Name]          
    mov     rdi, rax
    call    g_stpcpy
            
.CheckForEmailParam:
    cmp     qword [pszSpammerInfo.Email], 0
    je     .LastParam

.EmailParam:
    mov     rsi, szAmp                      ; &
    mov     rdi, rax
    call    g_stpcpy
    
    mov     rsi, szSFSQueryEmailField       ; email=
    mov     rdi, rax
    call    g_stpcpy

    mov     rsi, [pszSpammerInfo.Email]          
    mov     rdi, rax
    call    g_stpcpy
    jmp     .LastParam

.Name_Param1:
    cmp     qword [pszSpammerInfo.Name], 0
    je      .Email_Param1

    mov     rsi, szSFSQueryNameField        
    mov     rdi, rax
    call    g_stpcpy
    
    mov     rsi, [pszSpammerInfo.Name]
    mov     rdi, rax
    call    g_stpcpy
    jmp     .CheckForEmailParam

.Email_Param1:
    mov     rsi, szSFSQueryEmailField       ; email=
    mov     rdi, rax
    call    g_stpcpy

    mov     rsi, [pszSpammerInfo.Email]          
    mov     rdi, rax
    call    g_stpcpy
  
.LastParam:
    mov     rsi, szSFSQueryFmtJson          ; &f=json
    mov     rdi, rax
    call    g_stpcpy

    ;~ ; add on any options
    cmp     qword [pszSpammerInfo.Email], 0
    je     .CheckName

    mov     rcx, qword [QueryOptions]
    and     rcx, OPT_SFS_EMAIL
    jz      .CheckName

    mov     rsi, szSFSNoEmail              
    mov     rdi, rax
    call    g_stpcpy
    
.CheckName:   
    cmp     qword [pszSpammerInfo.Name], 0
    je      .CheckIp

    mov     rcx, qword [QueryOptions]
    and     rcx, OPT_SFS_NAME
    jz      .CheckIp

    mov     rsi, szSFSNoName               
    mov     rdi, rax
    call    g_stpcpy    

.CheckIp:
    cmp     qword [pszSpammerInfo.IP], 0
    je      .CheckAll

    mov     rcx, qword [QueryOptions]
    and     rcx, OPT_SFS_IP
    jz      .CheckAll

    mov     rsi, szSFSNoIP              
    mov     rdi, rax
    call    g_stpcpy

.CheckAll:
    mov     rcx, qword [QueryOptions]
    and     rcx, OPT_SFS_ALL
    jz      .CheckTor

    mov     rsi, szSFSNoAll             
    mov     rdi, rax
    call    g_stpcpy

.CheckTor:
    mov     rcx, qword [QueryOptions]
    and     rcx, OPT_SFS_TOR
    jz      .Over

    mov     rsi, szSFSNoTor            
    mov     rdi, rax
    call    g_stpcpy  
        
.Over:
    sub     rsp, 8 * 2
;~ 
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
    mov     rdi, [rgpInfo_Fixed + FXD_SFS]
    call    ShowSpinner
    
    pop     rax
    test    rax, rax
    jz      .Ok

    mov     rdi, CurlErr
    jmp     .QueryError

.Ok:
    lea     rdx, [rsp + 24]
    mov     rsi, CURLINFO_RESPONSE_CODE
    mov     rdi, [curl_handle]
    call    curl_easy_getinfo
    
    cmp     qword [rsp + 24], 200
    je      .GoodResponse

    
    mov     rdi, [rsp]
    jmp     .QueryError

;~ .GoodResponse:
    ;~ mov     r14, [rsp]
;~ .GetRetVal:
    ;~ mov     rsi, 0
    ;~ mov     sil, byte [r14]
    ;~ cmp     sil, ":"
    ;~ je      .CheckRetVal
    ;~ inc     r14
    ;~ jmp     .GetRetVal
    ;~ 
;~ .CheckRetVal:
    ;~ mov     rdi, [rsp]
    ;~ mov     rsi, 0
    ;~ mov     sil, byte [r14 + 1]
    ;~ cmp     sil, "1"
    ;~ jne      .QueryError

;~ .GetIPInfo:    
    ;~ cmp     qword [pszSpammerInfo.IP], 0
    ;~ jne     .ParseIP
;~ 
    ;~ mov     rbx, rgpSFS_Labels
    ;~ mov     r12, 2
;~ .NoIP:
    ;~ mov     rsi, szDash
    ;~ mov     rdi, [rbx + 8 * r12]
    ;~ call    gtk_label_set_text
    ;~ sub     r12, 1
    ;~ jns     .NoIP
    ;~ jmp     .GetNameInfo
;~ 
;~ .ParseIP:   
    ;~ mov     rsi, szIP
    ;~ mov     rdi, r14
    ;~ call    ParseSFSQuery
;~ 
    ;~ mov     rbx, rgpSFS_Labels
    ;~ mov     r12, 2
    ;~ mov     r13, pSFS_Reply
;~ 
;~ .DisplayIPInfo:
    ;~ mov     rsi, [r13 + 8 * r12]
    ;~ mov     rdi, [rbx + 8 * r12]
    ;~ call    gtk_label_set_text
    ;~ sub     r12, 1
    ;~ jns     .DisplayIPInfo
;~ 
    ;~ mov     al, byte [SFSReplyStruc.Freq]
    ;~ cmp     al, "0"
    ;~ je      .GetNameInfo
;~ 
    ;~ mov     rcx, szIPText
    ;~ mov     rdx, [pszSpammerInfo.IP]
    ;~ mov     rsi, szSFSIPSearch
    ;~ mov     rdi, [oSFSIP]
    ;~ call    SetSFSLabelMarkup
       
;~ .GetNameInfo:   
    ;~ cmp     qword [pszSpammerInfo.Name], 0
    ;~ jne     .ParseName
;~ 
    ;~ mov     rbx, rgpSFS_Labels
    ;~ add     rbx, 24
    ;~ mov     r12, 2
;~ .NoName:
    ;~ mov     rsi, szDash
    ;~ mov     rdi, [rbx + 8  * r12]
    ;~ call    gtk_label_set_text
    ;~ sub     r12, 1
    ;~ jns     .NoName
    ;~ jmp     .GetEmailInfo
    ;~ 
;~ .ParseName: 
    ;~ mov     rsi, szUserName
    ;~ mov     rdi, r14
    ;~ call    ParseSFSQuery
;~ 
    ;~ mov     rbx, rgpSFS_Labels
    ;~ add     rbx, 24
    ;~ mov     r12, 2
    ;~ mov     r13, pSFS_Reply
;~ .DisplayNameInfo:
    ;~ mov     rsi, [r13 + 8 * r12]
    ;~ mov     rdi, [rbx + 8 * r12]
    ;~ call    gtk_label_set_text
    ;~ sub     r12, 1
    ;~ jns     .DisplayNameInfo
;~ 
    ;~ mov     al, byte [SFSReplyStruc.Freq]
    ;~ cmp     al, "0"
    ;~ je      .GetEmailInfo
;~ 
    ;~ mov     rcx, szNameText
    ;~ mov     rdx, [pszSpammerInfo.Name]
    ;~ mov     rsi, szSFSSearch
    ;~ mov     rdi, [oSFSName]
    ;~ call    SetSFSLabelMarkup
    ;~ 
;~ .GetEmailInfo:
    ;~ cmp     qword [pszSpammerInfo.Email], 0
    ;~ jne     .ParseEmail
;~ 
    ;~ mov     rbx, rgpSFS_Labels
    ;~ add     rbx, 48
    ;~ mov     r12, 2
;~ .NoEmail:
    ;~ mov     rsi, szDash
    ;~ mov     rdi, [rbx + 8  * r12]
    ;~ call    gtk_label_set_text
    ;~ sub     r12, 1
    ;~ jns     .NoEmail
    ;~ jmp     .Done
;~ 
;~ .ParseEmail:    
    ;~ mov     rsi, szEmail
    ;~ mov     rdi, r14
    ;~ call    ParseSFSQuery
;~ 
    ;~ mov     rbx, rgpSFS_Labels
    ;~ add     rbx, 48
    ;~ mov     r12, 2
    ;~ mov     r13, pSFS_Reply
;~ .DisplayEmailInfo:
    ;~ mov     rsi, [r13 + 8 * r12]
    ;~ mov     rdi, [rbx + 8 * r12]
    ;~ call    gtk_label_set_text
    ;~ sub     r12, 1
    ;~ jns     .DisplayEmailInfo
;~ 
    ;~ mov     al, byte [SFSReplyStruc.Freq]
    ;~ cmp     al, "0"
    ;~ je      .Done
;~ 
    ;~ mov     rcx, szEmailText
    ;~ mov     rdx, [pszSpammerInfo.Email]
    ;~ mov     rsi, szSFSSearch
    ;~ mov     rdi, [oSFSEmail]
    ;~ call    SetSFSLabelMarkup
    ;~ 
    ;~ jmp     .Done
    
.QueryError:   
    mov     rdx, szQuerySingle
    mov     rsi, szServSFS
    call    LogError

    mov     rdi, [rgpStatus_Imgs + SFS_STATUS_Q_IDX]
    call    gtk_widget_show
    
.Done:    
    mov     rdi, [rsp]
    call    g_free
;~ 
    add     rsp, 8 * 4
    ;~ 
    pop     rbx
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    ret

;~ #########################################
;~ rsi = needle to search for
;~ rdi = haystack to search
ParseSFSQuery:
    push    r14

    mov     rdx, rsi
    mov     rsi, -1
    call    g_strstr_len                    ; Find needle
    mov     r14, rax                        ; save pointer to first char

    mov     rdx, szAppears
    mov     rsi, -1
    mov     rdi, r14
    call    g_strstr_len                    ; find `appears`
    mov     sil, byte[rax + 9]              ; skip over it
    cmp     sil, "0"                        ; If value != ASCII 0, not a spammer
    jne     .HaveSpammerInfo

.NoInfo:
    mov     rsi, "0"
    mov     rdi, SFSReplyStruc              
    mov     [rdi], rsi                      ; fill in structure with ASCII 0
    mov     [rdi + 32], rsi
    mov     [rdi + 48], rsi
    jmp     .Done                           ; and be done with this

.HaveSpammerInfo:
    mov     rdx, szLastSeen
    mov     rsi, -1
    mov     rdi, r14
    call    g_strstr_len                    ; find `lastseen`
    add     rax, 11                         ; skip over it
    lea     rdi, [SFSReplyStruc.Seen]
    
.GetSeen:
    mov     sil, byte [rax]
    cmp     sil, '"'
    je      .SeenDone
    mov     byte [rdi], sil
    inc     rdi
    inc     rax
    jmp     .GetSeen

.SeenDone:
    mov     byte [rdi], 0
    
    mov     rdx, szFrequency
    mov     rsi, -1
    mov     rdi, r14
    call    g_strstr_len
    add     rax, 11
    lea     rdi, [SFSReplyStruc.Freq]
    
.GetFreq:
    mov     sil, byte [rax]
    cmp     sil, ','
    je      .FreqDone
    mov     byte [rdi], sil
    inc     rdi
    inc     rax
    jmp     .GetFreq

.FreqDone:
    mov     byte [rdi], 0
    
    mov     rdx, szConf
    mov     rsi, -1
    mov     rdi, r14
    call    g_strstr_len
    add     rax, 12
    lea     rdi, [SFSReplyStruc.Conf]
    
.GetConf:
    mov     sil, byte [rax]
    cmp     sil, '}'
    je      .ConfDone
    mov     byte [rdi], sil
    inc     rdi
    inc     rax
    jmp     .GetConf

.ConfDone:
    mov     byte [rdi], 0
    
.Done:
    pop     r14
    ret 

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SubmitStopFourmSpam:
    push    r15
    push    r14
    push    r13
    sub     rsp, 8 * 2
        
    mov     [rsp], rdi

    mov     rdx, SPINNER_SFS_SUBMIT_Y
    mov     rsi, SPINNER_SFS_SUBMIT_X
    mov     rdi, TRUE
    call    ShowSubmitSpinner
        
    mov     r15, SFS_SUBMIT_URL_LEN
    
    mov     rdi, [pszSpammerInfo.Name]
    call    strlen
    add     r15, rax

    mov     rdi, [pszSpammerInfo.IP]
    call    strlen
    add     r15, rax

    mov     rdi, [rsp]  ; evidence len
    call    strlen
    add     r15, rax
    mov     r13, rax
    
    mov     rdi, [pszSpammerInfo.Email]
    call    strlen
    add     r15, rax

    mov     rdi, [rgpKeys_TxtBoxes + KEY_SFS]
    call    gtk_entry_get_text_length
    add     r15, rax
                    
;~ http://www.stopforumspam.com/add.php
;~ ?username=USERNAME
;~ &ip_addr=IPADDRESS
;~ &evidence=XXXXXXXXXX
;~ &email=EMAILADDRESS
;~ &api_key=ZZZZZZZZZZZZZZZ    

.CreateURL:
    mov     rdi, r15
    call    g_slice_alloc0
    mov     r14, rax
    
    mov     rsi, szSFSURL
    mov     rdi, r14
    call    g_stpcpy
    
    mov     rsi, szSFSSubmitAPI                  ; /add.php
    mov     rdi, rax
    call    g_stpcpy

.Name:
    mov     rsi, szSFSSubmitName             
    mov     rdi, rax
    call    g_stpcpy

    mov     rsi, [pszSpammerInfo.Name]                   
    mov     rdi, rax
    call    g_stpcpy    

.IP:
    mov     rsi, szSFSSubmitIP               
    mov     rdi, rax
    call    g_stpcpy

    mov     rsi, [pszSpammerInfo.IP]                   
    mov     rdi, rax
    call    g_stpcpy
    
.Evidence:
    test    r13, r13
    jz      .Email
    
    mov     rsi, szSFSSubmitEvdnce               
    mov     rdi, rax
    call    g_stpcpy

    mov     rsi, [rsp]                   
    mov     rdi, rax
    call    g_stpcpy    

.Email:
    mov     rsi, szSFSSubmitEmail             
    mov     rdi, rax
    call    g_stpcpy

    mov     rsi, [pszSpammerInfo.Email]                   
    mov     rdi, rax
    call    g_stpcpy  

.Key:
    mov     rsi, szSFSSubmitAPIKey             
    mov     rdi, rax
    call    g_stpcpy
    mov     r13, rax
    
    mov     rdi, [rgpKeys_TxtBoxes + KEY_SFS]
    call    gtk_entry_get_text
    
    mov     rsi, rax                   
    mov     rdi, r13
    call    g_stpcpy  
    
.Finish:
    sub     rsp, 8 * 2

    mov     rdi, 1
    call    g_malloc    
    mov     [rsp], rax
    mov     qword [rsp + 8], 0
    
    mov     rdi, r14
    mov     rsi, ReceiveQuery
    mov     rdx, rsp
    mov     rcx, r15
    call    SendQuery   
    push    rax

    mov     rdi, FALSE
    call    ShowSubmitSpinner
    
    pop     rax
    test    rax, rax
    jz      .Ok
    
    mov     rsi, szImgBad
    mov     rdi, [rgpStatus_Imgs + SFS_STATUS_S_IDX]
    call    gtk_image_set_from_file
    
    mov     rdi, CurlErr
    jmp     .Doit
    
.Ok:
    lea     rdx, [rsp + 24]
    mov     rsi, CURLINFO_RESPONSE_CODE
    mov     rdi, [curl_handle]
    call    curl_easy_getinfo
    
    cmp     qword [rsp + 24], 200
    jne     .BadSubmit

    mov     rsi, szImgGood
    mov     rdi, [rgpStatus_Imgs + SFS_STATUS_S_IDX]
    call    gtk_image_set_from_file
    
    jmp     .Done
        
.BadSubmit:
    mov     rsi, szImgBad
    mov     rdi, [rgpStatus_Imgs + SFS_STATUS_S_IDX]
    call    gtk_image_set_from_file

    ; SFS Error Reply:
    ; <p>Error Message</p>
    mov     rdi, [rsp]
    call    StrLen              ; get len of error reply
    sub     rax, 4
    mov     byte [rdi + rax], 0 ; add NULL terminator before </p>
    add     rdi, 3              ; adjust pointer to skip <p>  

.Doit:
    mov     rdx, szSubmitSingle
    mov     rsi, szServSFS
    call    LogError
    
.Done:
    mov     rdi, [rsp]
    call    g_free
    
    add     rsp, 8 * 4
    pop     r13
    pop     r14
    pop     r15
    ret
