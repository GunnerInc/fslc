;~ Info Tab - Txt box
TXT_INFO_IP_IDX     equ 0
TXT_INFO_NAME_IDX   equ (8 * 1)
TXT_INFO_EMAIL_IDX  equ (8 * 2)
TXT_INFO_EVDNCE_IDX equ (8 * 3)

;~ Info Tab - Frames
FRA_SFS_IDX         equ 0
FRA_PHP_IDX         equ (8 * 1)
FRA_FSL_IDX         equ (8 * 2)
FRA_BS_IDX          equ (8 * 3)
FRA_IPINFO_IDX      equ (8 * 4)

;~ Info Tab - Buttons
BTN_INFO_SEARCH_IDX     equ 0
BTN_INFO_CLEAR_IDX      equ (8 * 1)
BTN_INFO_SUBMIT_IDX     equ (8 * 2)

;~ Log Tab - Buttons
BTN_LOG_SAVE_IDX        equ 0
BTN_LOG_CLEAR_IDX       equ (8 * 1)

;~ Info Tab - Submit Check boxes
CHK_SUBMIT_SFS_IDX      equ 0
CHK_SUBMIT_BS_IDX       equ (8 * 1)

;~ Search Options Dialog - Check boxes
CHK_QUERY_SFS_IDX       equ 0
CHK_QUERY_PHP_IDX       equ (8 * 1)
CHK_QUERY_FSL_IDX       equ (8 * 2)
CHK_QUERY_BS_IDX        equ (8 * 3)
CHK_QUERY_IPINFO_IDX    equ (8 * 4)
CHK_QUERY_FLAG_IDX      equ (8 * 5)

CHK_SFSOPT_NOEMAIL_IDX  equ 0
CHK_SFSOPT_NONAME_IDX   equ (8 * 1)
CHK_SFSOPT_NOIP_IDX     equ (8 * 2)
CHK_SFSOPT_NOALL_IDX    equ (8 * 3)
CHK_SFSOPT_NOTOR_IDX    equ (8 * 4)

;~ Info Tab - Stop Forum Spam Labels
SFS_IP_FREQ_IDX     equ 0
SFS_IP_CONF_IDX     equ (8 * 1)
SFS_IP_SEEN_IDX     equ (8 * 2)
SFS_NAME_FREQ_IDX   equ (8 * 3)
SFS_NAME_CONF_IDX   equ (8 * 4)
SFS_NAME_SEEN_IDX   equ (8 * 5)
SFS_EMAIL_FREQ_IDX  equ (8 * 6)
SFS_EMAIL_CONF_IDX  equ (8 * 7)
SFS_EMAIL_SEEN_IDX  equ (8 * 8)

;~ Info Tab - Project Honeypot Labels
PHP_TYPE_IDX        equ 0
PHP_SEEN_IDX        equ (8 * 1)
PHP_THREAT_IDX      equ (8 * 2)

;~ Info Tab - Forum Spam LIst Labels
FSL_IP_FREQ_IDX     equ 0
FSL_IP_CONF_IDX     equ (8 * 1)
FSL_IP_SEEN_IDX     equ (8 * 2)
FSL_NAME_FREQ_IDX   equ (8 * 3)
FSL_NAME_CONF_IDX   equ (8 * 4)
FSL_NAME_SEEN_IDX   equ (8 * 5)
FSL_EMAIL_FREQ_IDX  equ (8 * 6)
FSL_EMAIL_CONF_IDX  equ (8 * 7)
FSL_EMAIL_SEEN_IDX  equ (8 * 8)

SFS_STATUS_Q_IDX    equ 0
PHP_STATUS_Q_IDX    equ (8 * 1)
FSL_STATUS_Q_IDX    equ (8 * 2)
BS_STATUS_Q_IDX     equ (8 * 3)
IP_STATUS_Q_IDX     equ (8 * 4)
SFS_STATUS_S_IDX    equ (8 * 5)
BS_STATUS_S_IDX     equ (8 * 6)
    
;~ Info Tab - IPInfoDB Labels
IPIDB_COUNTRY_IDX   equ 0
IPIDB_REGION_IDX    equ 1 ;(8 * 1)
IPIDB_CITY_IDX      equ 2 ;(8 * 2)
IPIDB_ZIP_IDX       equ 3 ;(8 * 3)
IPIDB_TZ_IDX        equ 4 ;(8 * 4)
IPIDB_LONG_IDX      equ 5 ;(8 * 5)
IPIDB_LAT_IDX       equ 6 ;(8 * 6)
IPIDB_FLAG_IDX      equ 7 ;(8 * 7)

;~ Info Tab - BotScout Labels
BS_IP_IDX           equ 0
BS_NAME_IDX         equ (8 * 1)
BS_EMAIL_IDX        equ (8 * 2)

KEY_SFS             equ 0
KEY_PHP             equ (8 * 1)
KEY_FSL             equ (8 * 2)
KEY_BS              equ (8 * 3)
KEY_IPI             equ (8 * 4)

FXD_SFS             equ 0
FXD_PHP             equ (8 * 1)
FXD_FSL             equ (8 * 2)
FXD_BS              equ (8 * 3)
FXD_IP              equ (8 * 4)

SPINNER_SFS_X       equ 195
SPINNER_SFS_Y       equ 34
SPINNER_PHP_X       equ SPINNER_SFS_X
SPINNER_PHP_Y       equ 0
SPINNER_FSL_X       equ SPINNER_SFS_X
SPINNER_FSL_Y       equ SPINNER_SFS_Y
SPINNER_BS_X        equ SPINNER_SFS_X - 65
SPINNER_BS_Y        equ SPINNER_PHP_Y 
SPINNER_IP_X        equ SPINNER_SFS_X 
SPINNER_IP_Y        equ SPINNER_BS_Y + 25
SPINNER_FLAG_X      equ 20
SPINNER_FLAG_Y      equ 15

SPINNER_SFS_SUBMIT_X    equ 81
SPINNER_SFS_SUBMIT_Y    equ 439
SPINNER_BS_SUBMIT_X     equ 186
SPINNER_BS_SUBMIT_Y     equ SPINNER_SFS_SUBMIT_Y

PHP_REPLY_1ST_OCTET equ 0
PHP_REPLY_2ND_OCTET equ (8 * 1)
PHP_REPLY_3RD_OCTET equ (8 * 2)
PHP_REPLY_4TH_OCTET equ (8 * 3)

IP_REPLY_STAT_CODE      equ 0
IP_REPLY_STAT_MESG      equ 1 ;(8 * 1)
IP_REPLY_IP_ADR         equ 2 ;(8 * 2)
IP_REPLY_COUNTRY_CODE   equ 3 ;(8 * 3)
IP_REPLY_COUNTRY_NAME   equ 4 ;(8 * 4)
IP_REPLY_REGION_NAME    equ 5; (8 * 5)
IP_REPLY_CITY_NAME      equ 6 ;(8 * 6)
IP_REPLY_ZIP            equ 7 ;(8 * 7)
IP_REPLY_LAT            equ 8 ;(8 * 8)
IP_REPLY_LONG           equ 9 ;(8 * 9)
IP_REPLY_TIME_ZONE      equ 10 ;(8 * 10)

INFO_LABELS_ARRAY_LEN equ SFS_LABEL_ARR_LEN + PHP_LABEL_ARR_LEN + FSL_LABEL_ARR_LEN + BS_LABEL_ARR_LEN + IPINFO_LABEL_ARR_LEN - 2

;~ Bitmasks for Services to query
OPT_SFS         equ 1
OPT_PHP         equ 2
OPT_FSL         equ 4
OPT_BS          equ 8
OPT_IPINFO      equ 16
OPT_SHOW_FLAG   equ 32

;~ Bitmasks for SFS Options
OPT_SFS_EMAIL   equ 64                      ; &nobademail
OPT_SFS_NAME    equ 128                     ; &nobadusername
OPT_SFS_IP      equ 256                     ; &nobadip
OPT_SFS_ALL     equ 512                     ; &nobadall
OPT_SFS_TOR     equ 1024                    ; &notorexit

;~ Bitmasks for Services to query - Single Submit
OPT_SFS_SUBMIT  equ 2048
OPT_BS_SUBMIT   equ 4096

NULL    equ 0
FALSE   equ 0
TRUE    equ 1
EMPTY_FILENAME equ 0

GTKTEXTITER_SIZE    equ 112

%define S_IRWXU 0o00700

TAB_INFO            equ 0
TAB_BATCH_SEARCH    equ 1
TAB_BATCH_SUBMIT    equ 2
TAB_OPTIONS         equ 3
TAB_ABOUT           equ 4

HTTP_NOT_FOUND      equ 404

%define PANGO_WEIGHT_BOLD 700

%define   G_FILE_TEST_IS_REGULAR    1 << 0
%define   G_FILE_TEST_IS_SYMLINK    1 << 1
%define   G_FILE_TEST_IS_DIR        1 << 2
%define   G_FILE_TEST_IS_EXECUTABLE 1 << 3
%define   G_FILE_TEST_EXISTS        1 << 4
%define G_FILE_ERROR_EXIST  0


%define G_SOURCE_REMOVE FALSE
;~ GtkButtonsType
GTK_BUTTONS_NONE        equ 0
GTK_BUTTONS_OK          equ 1
GTK_BUTTONS_CLOSE       equ 2
GTK_BUTTONS_CANCEL      equ 3
GTK_BUTTONS_YES_NO      equ 4
GTK_BUTTONS_OK_CANCEL   equ 5

;~ GtkDialogFlags:
;~ Flags used to influence dialog construction.
GTK_DIALOG_MODAL                equ 1 << 0
GTK_DIALOG_DESTROY_WITH_PARENT  equ 1 << 1

;~ ;GtkWindowPosition
;~ GTK_WIN_POS_NONE                equ 0
;~ GTK_WIN_POS_CENTER              equ 1
;~ GTK_WIN_POS_MOUSE               equ 2
;~ GTK_WIN_POS_CENTER_ALWAYS       equ 3
;~ GTK_WIN_POS_CENTER_ON_PARENT    equ 4
;~ 
;~ ;GtkWindowType
;~ GTK_WINDOW_TOPLEVEL     equ 0
;~ GTK_WINDOW_POPUP        equ 1

;~ GtkResponseType
GTK_RESPONSE_NONE               equ -1
GTK_RESPONSE_REJECT             equ -2
GTK_RESPONSE_ACCEPT             equ -3
GTK_RESPONSE_DELETE_EVENT       equ -4
GTK_RESPONSE_OK                 equ -5
GTK_RESPONSE_CANCEL             equ -6
GTK_RESPONSE_CLOSE              equ -7
GTK_RESPONSE_YES                equ -8
GTK_RESPONSE_NO                 equ -9
GTK_RESPONSE_APPLY              equ -10
GTK_RESPONSE_HELP               equ -11

;~ GtkMessageType
;~ The type of message being displayed in the dialog.
GTK_MESSAGE_INFO        equ 0
GTK_MESSAGE_WARNING     equ 1
GTK_MESSAGE_QUESTION    equ 2
GTK_MESSAGE_ERROR       equ 3
GTK_MESSAGE_OTHER       equ 4

%define G_KEY_FILE_NONE 0
%define G_KEY_FILE_KEEP_COMMENTS 1 << 0
%define G_KEY_FILE_KEEP_TRANSLATIONS 1 << 1

G_KEY_FILE_ERROR_UNKNOWN_ENCODING   equ 0
G_KEY_FILE_ERROR_PARSE              equ 1
G_KEY_FILE_ERROR_NOT_FOUND          equ 2
G_KEY_FILE_ERROR_KEY_NOT_FOUND      equ 3
G_KEY_FILE_ERROR_GROUP_NOT_FOUND    equ 4
G_KEY_FILE_ERROR_INVALID_VALUE      equ 5


%define CURL_GLOBAL_SSL (1<<0)
%define CURL_GLOBAL_WIN32 (1<<1)
%define CURLOPT_FILE 10001
%define CURL_GLOBAL_ALL (CURL_GLOBAL_SSL|CURL_GLOBAL_WIN32)
%define CURL_GLOBAL_NOTHING 0
%define CURL_GLOBAL_DEFAULT CURL_GLOBAL_ALL
%define CURLOPT_URL 10002
%define CURLOPT_WRITEFUNCTION 20011
%define CURLOPT_USERAGENT 10018
%define CURLFORM_COPYNAME 1
%define CURLFORM_COPYCONTENTS 4
%define CURLFORM_END 17
%define CURLOPT_HTTPPOST 10024
%define CURLOPT_WRITEDATA CURLOPT_FILE
%define CURLOPT_POSTFIELDS 10015
%define CURLOPT_POST 47
%define CURLOPT_COPYPOSTFIELDS 10165
%define CURLOPT_ERRORBUFFER 10010
%define CURLINFO_STRING   0x100000
%define CURLINFO_LONG     0x200000
%define CURLINFO_DOUBLE   0x300000
%define CURLINFO_SLIST    0x400000
%define CURLINFO_MASK     0x0fffff
%define CURLINFO_TYPEMASK 0xf00000

CURLINFO_RESPONSE_CODE    equ CURLINFO_LONG + 2
%define CURL_ERROR_SIZE 256


%define INET_ADDRSTRLEN        16
%define INET6_ADDRSTRLEN       46
%define NETDB_SUCCESS   0	       ;	/* no problem */
%define HOST_NOT_FOUND  1 		;/* Authoritative Answer Host not found */
%define TRY_AGAIN       2 		;/* Non-Authoritative Host not found, or SERVERFAIL */
%define NO_RECOVERY     3 		;/* Non recoverable errors, FORMERR, REFUSED, NOTIMP */
%define NO_DATA         4 		;/* Valid name, no data record of requested type */
%define NO_ADDRESS      NO_DATA        ; /* no address, look for MX record */

;~ typedef enum
;~ {
%define GTK_FILE_CHOOSER_ACTION_OPEN 0
%define GTK_FILE_CHOOSER_ACTION_SAVE 1
%define GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER 2
%define GTK_FILE_CHOOSER_ACTION_CREATE_FOLDER 3
;~ } GtkFileChooserAction;

%define GTK_STYLE_PROVIDER_PRIORITY_APPLICATION 600
