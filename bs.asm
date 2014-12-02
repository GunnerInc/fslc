section .text
;~ rdx = label text
;~ rsi = search text
;~ rdi = label widget    
SetBSLabelMarkup:
    push    r15
    push    r14
    sub     rsp, 8

    mov     r14, rdi

    push    szAHrefEnd
    push    rdx
    push    szURLEnd
    mov     r9, szBSSearchEnd
    mov     r8, rsi
    mov     rcx, szBSSearch
    mov     rdx, szBotScoutURL
    mov     rsi, szAHrefStart
    mov     rdi, fmtstr8
    mov     rax, 0
    call    g_strdup_printf
    mov     r15, rax
    add     rsp, 8 * 3

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
    
QueryBotScout:
    push    r15
    push    r14
    push    r13
    push    r12
    sub     rsp, 8

    mov     r9, TRUE
    mov     rcx, SPINNER_BS_Y
    mov     rdx, SPINNER_BS_X
    mov     rsi, [oSFS_Spinner]
    mov     rdi, [rgpInfo_Fixed + FXD_BS]
    call    ShowSpinner
    
    mov     r15, BS_URL_LEN

    mov     rdi, [rgpKeys_TxtBoxes + KEY_BS]
    call    gtk_entry_get_text_length
    add     r15, rax

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
    ;~ http://botscout.com/test/?multi&name=krasnhello&mail=krasnhello@mail.ru&ip=84.16.230.111
    mov     rsi, szBotScoutURL              ; http://www.botscout.com/
    mov     rdi, r14
    call    g_stpcpy

    mov     rsi, szBSQuery                  ; test/?multi
    mov     rdi, rax
    call    g_stpcpy
    
.Name:
    mov     rdi, [pszSpammerInfo.Name]
    test    rdi, rdi
    jz      .Email

    mov     rsi, szBSNameField              ; &name=
    mov     rdi, rax
    call    g_stpcpy

    mov     rsi, [pszSpammerInfo.Name]                   
    mov     rdi, rax
    call    g_stpcpy
    
.Email:
    mov     rdi, [pszSpammerInfo.Email]
    test    rdi, rdi
    jz      .IP

    mov     rsi, szBSEmailField             ; &mail=        
    mov     rdi, rax
    call    g_stpcpy

    mov     rsi, [pszSpammerInfo.Email]                   
    mov     rdi, rax
    call    g_stpcpy
    
.IP:
    mov     rdi, [pszSpammerInfo.IP]
    test    rdi, rdi
    jz      .Key

    mov     rsi, szBSIPField                ; &ip=
    mov     rdi, rax
    call    g_stpcpy

    mov     rsi, [pszSpammerInfo.IP]                   
    mov     rdi, rax
    call    g_stpcpy
    
.Key:
    mov    r13, rax
    
    mov     rdi, [rgpKeys_TxtBoxes + KEY_BS]
    call    gtk_entry_get_text_length
    test    rax, rax
    jz      .Finish

    mov     rsi, szBSKeyField               ; &key=
    mov     rdi, r13
    call    g_stpcpy
    mov     r13, rax

    mov     rdi, [rgpKeys_TxtBoxes + KEY_BS]
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

    mov     r9, FALSE
    mov     rsi, [oSFS_Spinner]
    mov     rdi, [rgpInfo_Fixed + FXD_BS]
    call    ShowSpinner
    
    pop     rax
    test    rax, rax
    jz      .Ok

    mov     rdi, [rgpStatus_Imgs + BS_STATUS_Q_IDX]
    call    gtk_widget_show
    
    mov     rdi, CurlErr
    jmp     .LogIt

.Ok:
    mov     rdi, [rsp]
    call    ToLower

    mov     r14, [rsp]

   ;~ mov      rsi, r14
   ;~ call PrintString
;~ 
    ;~ mov     rsi, [rsp  +8]
    ;~ call    PrintDec
    

;~ y|multi|ip|0|mail|0|name|1

.GetRetVal:
    mov     rsi, 0
    mov     sil, byte [r14]
    cmp     sil, "!"
    je      .GotErrResponse
    cmp     sil, "y"
    je      .GetIP

.NotSpammer:
    sub     rsp, 8 * 2
    mov     byte [rsp], "0"
    mov     byte [rsp + 1], 0
    
    mov     r12, BS_LABEL_ARR_LEN - 1
    mov     r13, rgpBS_Labels
.NextField:
    mov     rsi, rsp
    mov     rdi, [r13 + 8 * r12]    
    call    gtk_label_set_text
    sub     r12, 1
    jns     .NextField
    add     rsp, 8 * 2
    jmp     .Done

.GetIP:  
    add     r14, 11
    lea     rdi, [SFSReplyStruc.Seen]
.NextIPChar:
    cmp     byte [r14], "|"
    je      .IPDone
    mov     al, byte [r14]
    mov     byte [rdi], al
    inc     r14
    inc     rdi
    jmp     .NextIPChar

.IPDone:
    mov     byte [rdi], 0
    lea     rdi, [SFSReplyStruc.Seen]
    call    atoi
    test    rax, rax
    jz      .ShowIPNormal

    lea     rdx, [SFSReplyStruc.Seen]
    mov     rsi, [pszSpammerInfo.IP]
    mov     rdi, [rgpBS_Labels + BS_IP_IDX]
    call    SetBSLabelMarkup
    jmp     .GetMail
    
.ShowIPNormal:
    lea     rsi, [SFSReplyStruc.Seen]
    mov     rdi, [rgpBS_Labels + BS_IP_IDX]
    call    gtk_label_set_text

.GetMail:
    add     r14, 6
    lea     rdi, [SFSReplyStruc.Seen]
.NextMailChar:
    cmp     byte [r14], "|"
    je      .MailDone
    mov     al, byte [r14]
    mov     byte [rdi], al
    inc     r14
    inc     rdi
    jmp     .NextMailChar

.MailDone:
    mov     byte [rdi], 0
    lea     rdi, [SFSReplyStruc.Seen]
    call    atoi
    test    rax, rax
    jz      .ShowMailNormal
   
    lea     rdx, [SFSReplyStruc.Seen]
    mov     rsi, [pszSpammerInfo.Email]
    mov     rdi, [rgpBS_Labels + BS_EMAIL_IDX]
    call    SetBSLabelMarkup
    jmp     .GetName
    
.ShowMailNormal:    
    lea     rsi, [SFSReplyStruc.Seen]
    mov     rdi, [rgpBS_Labels + BS_EMAIL_IDX]
    call    gtk_label_set_text

.GetName:
    add     r14, 6
    lea     rdi, [SFSReplyStruc.Seen]

.NextNameChar:
    cmp     byte [r14], 0
    je      .NameDone
    mov     al, byte [r14]
    mov     byte [rdi], al
    inc     r14
    inc     rdi
    jmp     .NextNameChar

.NameDone:
    mov     byte [rdi], 0
    lea     rdi, [SFSReplyStruc.Seen]
    call    atoi
    test    rax, rax
    jz      .ShowNameNormal

    lea     rdx, [SFSReplyStruc.Seen]
    mov     rsi, [pszSpammerInfo.Name]
    mov     rdi, [rgpBS_Labels + BS_NAME_IDX]
    call    SetBSLabelMarkup
    jmp     .Done

.ShowNameNormal:    
    lea     rsi, [SFSReplyStruc.Seen]
    mov     rdi, [rgpBS_Labels + BS_NAME_IDX]
    call    gtk_label_set_text
    jmp     .Done
    
.GotErrResponse:
    mov     rdi, [rgpStatus_Imgs + BS_STATUS_Q_IDX]
    call    gtk_widget_show

    mov     rdi, r14
.LogIt:    
    mov     rdx, szQuerySingle
    mov     rsi, szServBotScout   
    call    LogError
    
.Done:
    mov     rdi, [rsp]
    call    g_free

    add     rsp, 24
    pop     r12
    pop     r13
    pop     r14
    pop     r15
    ret

;~ #########################################
SubmitBotScout:
    push    r15
    push    r14
    push    r13
    sub     rsp, 8 * 2
    
    mov     rdx, SPINNER_BS_SUBMIT_Y
    mov     rsi, SPINNER_BS_SUBMIT_X
    mov     rdi, TRUE
    call    ShowSubmitSpinner
    
    mov     r15, BS_SUBMIT_FIELD_LEN
    
    mov     rdi, [pszSpammerInfo.Name]
    call    strlen
    add     r15, rax

    mov     rdi, [pszSpammerInfo.IP]
    call    strlen
    add     r15, rax
    
    mov     rdi, [pszSpammerInfo.Email]
    call    strlen
    add     r15, rax

    mov     rdi, [rgpKeys_TxtBoxes + KEY_BS]
    call    gtk_entry_get_text_length
    add     r15, rax

ConcatFields:
    mov     rdi, r15
    call    g_slice_alloc0
    mov     r14, rax

.Name:
    mov     rsi, szBSSubmitNameField             
    mov     rdi, rax
    call    g_stpcpy

    mov     rsi, [pszSpammerInfo.Name]                   
    mov     rdi, rax
    call    g_stpcpy    

.Email:
    mov     rsi, szBSSubmitEmailField             
    mov     rdi, rax
    call    g_stpcpy

    mov     rsi, [pszSpammerInfo.Email]                   
    mov     rdi, rax
    call    g_stpcpy  
    
.IP:
    mov     rsi, szBSSubmitIPField               
    mov     rdi, rax
    call    g_stpcpy

    mov     rsi, [pszSpammerInfo.IP]                   
    mov     rdi, rax
    call    g_stpcpy

.Key:
    mov     rsi, szBSSubmitKeyField             
    mov     rdi, rax
    call    g_stpcpy
    mov     r13, rax
    
    mov     rdi, [rgpKeys_TxtBoxes + KEY_BS]
    call    gtk_entry_get_text
    
    mov     rsi, rax                   
    mov     rdi, r13
    call    g_stpcpy  
    
.Action:
    mov     rsi, szBSSubmitAddField               
    mov     rdi, rax
    call    g_stpcpy

.AppID:
    mov     rsi, szBSSubmitAppId               
    mov     rdi, rax
    call    g_stpcpy

.Submit:
    mov     rdx, r14
    mov     rsi, CURLOPT_COPYPOSTFIELDS
    mov     rdi, [curl_handle]
    call    curl_easy_setopt

    mov     rsi, r14
    mov     rdi, r15
    call    g_slice_free1
    
    mov     rdx, 1
    mov     rsi, CURLOPT_POST
    mov     rdi, [curl_handle]
    call    curl_easy_setopt
    
    sub     rsp, 8 * 2

    mov     rdi, 1
    call    g_malloc    
    mov     [rsp], rax
    mov     qword [rsp + 8], 0
    
    mov     rdi, szBSSubmitPage
    mov     rsi, ReceiveQuery
    mov     rdx, rsp
    mov     rcx, 0
    call    SendQuery   
    push    rax
    
    mov     rdi, FALSE
    call    ShowSubmitSpinner
    pop     rax
    test    rax, rax
    jz      .Over

    mov     rsi, szImgBad
    mov     rdi, [rgpStatus_Imgs + BS_STATUS_S_IDX]
    call    gtk_image_set_from_file
    mov     rdi, CurlErr
    jmp     .Bad
        
.Over:    
    mov     rdi, [rsp]

    cmp     byte [rdi], '!'
    jne     .Good

.BadSubmit:
    mov     rsi, szImgBad
    mov     rdi, [rgpStatus_Imgs + BS_STATUS_S_IDX]
    call    gtk_image_set_from_file

    ; BS Error Reply:
    ; ! Error Message
    mov     rdi, [rsp]
    call    StrLen              ; get len of error reply
    sub     rax, 2
    mov     byte [rdi + rax], 0 ; add NULL terminator before crlf

    add     rdi, 2              ; adjust pointer to skip  '! '   
.Bad:
    mov     rdx, szSubmitSingle
    mov     rsi, szServBotScout
    call    LogError
    jmp     .Done
        
.Good:
    mov     rsi, szImgGood
    mov     rdi, [rgpStatus_Imgs + BS_STATUS_S_IDX]
    call    gtk_image_set_from_file
    
.Done:
    mov     rdi, [rsp]
    call    g_free
    
    add     rsp, 8 * 4
    pop     r13
    pop     r14
    pop     r15
    ret
